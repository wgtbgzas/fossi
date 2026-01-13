#!/usr/bin/env python3
import os, sys, struct, pathlib

MAGIC = b"\xd0\x0d\xfe\xed"  # 0xd00dfeed

def u32be(b): return struct.unpack(">I", b)[0]

def main():
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input.img> <out_dir>")
        sys.exit(2)

    inp = pathlib.Path(sys.argv[1])
    out = pathlib.Path(sys.argv[2])
    out.mkdir(parents=True, exist_ok=True)

    data = inp.read_bytes()
    hits = []
    i = 0
    while True:
        j = data.find(MAGIC, i)
        if j < 0:
            break
        # DTB header: magic (4) + totalsize (4), totalsize is big-endian
        if j + 8 <= len(data):
            total = u32be(data[j+4:j+8])
            if total >= 0x100 and j + total <= len(data):
                hits.append((j, total))
        i = j + 4

    # de-dup/avoid overlaps (simple)
    extracted = []
    last_end = -1
    for k, (off, size) in enumerate(sorted(hits)):
        if off < last_end:
            continue
        blob = data[off:off+size]
        (out / f"{k:03d}_off{off:08x}_sz{size:08x}.dtb").write_bytes(blob)
        extracted.append((off, size))
        last_end = off + size

    print(f"Found {len(hits)} candidates, extracted {len(extracted)} DTBs into {out}")

if __name__ == "__main__":
    main()
