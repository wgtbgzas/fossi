#!/usr/bin/env python3
import os, sys, struct, pathlib

DTBO_MAGIC = 0x4454424F  # 'DTBO'

def parse_header(buf):
    # Try big-endian first (common), then little-endian
    for endian in (">", "<"):
        vals = struct.unpack(endian + "8I", buf[:32])
        magic = vals[0]
        if magic == DTBO_MAGIC:
            return endian, vals
    raise SystemExit("Not a DTBO image (missing DTBO magic).")

def main():
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <dtbo.img> <out_dir>")
        sys.exit(2)

    in_path = sys.argv[1]
    out_dir = pathlib.Path(sys.argv[2])
    out_dir.mkdir(parents=True, exist_ok=True)

    data = pathlib.Path(in_path).read_bytes()
    endian, h = parse_header(data)

    _, total_size, header_size, entry_size, entry_count, entries_off, page_size, version = h

    if total_size > len(data):
        raise SystemExit(f"DTBO total_size ({total_size}) > file size ({len(data)}). Corrupt?")

    def u32s(b):
        # DTBO entry fields are u32s in same endianness as header
        return struct.unpack(endian + "8I", b[:32])

    for i in range(entry_count):
        off = entries_off + i * entry_size
        ent = data[off: off + entry_size]
        if len(ent) < 32:
            raise SystemExit(f"Entry {i} truncated.")

        dt_size, dt_off, dt_id, dt_rev, c0, c1, c2, c3 = u32s(ent)
        blob = data[dt_off: dt_off + dt_size]
        if len(blob) != dt_size:
            raise SystemExit(f"DTB {i} truncated: wanted {dt_size}, got {len(blob)}")

        name = out_dir / f"{i:03d}_id{dt_id:08x}_rev{dt_rev:08x}.dtb"
        name.write_bytes(blob)

    print(f"Extracted {entry_count} DTBs to: {out_dir}")

if __name__ == "__main__":
    main()
