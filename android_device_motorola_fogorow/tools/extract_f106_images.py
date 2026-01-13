#!/usr/bin/env python3
import argparse
import pathlib
import struct
import sys

BOOT_MAGIC = b"ANDROID!"
DTBO_MAGIC = 0xD7B7AB1E
LFS_MAGIC = b"version https://git-lfs.github.com/spec/v1"
PAGE_SIZE = 4096


def align(value: int, alignment: int) -> int:
    return (value + alignment - 1) // alignment * alignment


def is_lfs_pointer(path: pathlib.Path) -> bool:
    with path.open("rb") as handle:
        head = handle.read(len(LFS_MAGIC))
    return head == LFS_MAGIC


def write_file(path: pathlib.Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def extract_boot_image(path: pathlib.Path, out_dir: pathlib.Path, label: str) -> None:
    data = path.read_bytes()
    if data[:8] != BOOT_MAGIC:
        raise ValueError(f"{label} does not look like an Android boot image")

    kernel_size, ramdisk_size, os_version, header_size = struct.unpack_from("<4I", data, 8)
    header_version = struct.unpack_from("<I", data, 40)[0]
    if header_version not in (3, 4):
        raise ValueError(f"{label} uses unsupported boot header version {header_version}")

    cmdline_start = 44
    cmdline_end = cmdline_start + 1536
    cmdline = data[cmdline_start:cmdline_end].split(b"\x00", 1)[0].decode("utf-8", "replace")

    kernel_offset = align(header_size, PAGE_SIZE)
    kernel_end = kernel_offset + kernel_size
    ramdisk_offset = align(kernel_end, PAGE_SIZE)
    ramdisk_end = ramdisk_offset + ramdisk_size

    kernel = data[kernel_offset:kernel_end]
    ramdisk = data[ramdisk_offset:ramdisk_end]

    write_file(out_dir / "kernel", kernel)
    write_file(out_dir / "ramdisk.cpio", ramdisk)

    info = (
        f"source={path.name}\n"
        f"header_version={header_version}\n"
        f"os_version=0x{os_version:08x}\n"
        f"kernel_size={kernel_size}\n"
        f"ramdisk_size={ramdisk_size}\n"
        f"cmdline={cmdline}\n"
    )
    write_file(out_dir / "bootinfo.txt", info.encode("utf-8"))


def extract_dtbo(path: pathlib.Path, out_dir: pathlib.Path) -> None:
    data = path.read_bytes()
    magic = struct.unpack_from("<I", data, 0)[0]
    if magic != DTBO_MAGIC:
        raise ValueError("dtbo.img does not have a valid DTBO magic")

    (
        _magic,
        total_size,
        header_size,
        entry_size,
        entry_count,
        entries_offset,
        page_size,
        version,
    ) = struct.unpack_from("<8I", data, 0)

    info = (
        f"source={path.name}\n"
        f"total_size={total_size}\n"
        f"header_size={header_size}\n"
        f"entry_size={entry_size}\n"
        f"entry_count={entry_count}\n"
        f"entries_offset={entries_offset}\n"
        f"page_size={page_size}\n"
        f"version={version}\n"
    )
    write_file(out_dir / "dtboinfo.txt", info.encode("utf-8"))

    for index in range(entry_count):
        entry_offset = entries_offset + index * entry_size
        dt_size, dt_offset, dt_id, dt_rev = struct.unpack_from("<4I", data, entry_offset)
        dt_data = data[dt_offset : dt_offset + dt_size]
        name = f"dtb_{index:02d}_id{dt_id:08x}_rev{dt_rev:08x}.dtb"
        write_file(out_dir / name, dt_data)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Extract FOSSiBOT F106 boot/init_boot/vendor_boot/dtbo payloads",
    )
    parser.add_argument(
        "--input",
        type=pathlib.Path,
        default=pathlib.Path("real fossibot"),
        help="Directory containing the firmware images (default: real fossibot)",
    )
    parser.add_argument(
        "--output",
        type=pathlib.Path,
        default=pathlib.Path("real fossibot/extracted"),
        help="Directory to write extracted payloads (default: real fossibot/extracted)",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    input_dir = args.input
    output_dir = args.output

    boot_img = input_dir / "boot.img"
    init_boot_img = input_dir / "init_boot.img"
    vendor_boot_img = input_dir / "vendor_boot.img"
    dtbo_img = input_dir / "dtbo.img"

    missing = [p.name for p in (boot_img, init_boot_img, vendor_boot_img, dtbo_img) if not p.exists()]
    if missing:
        print(f"Missing required images: {', '.join(missing)}", file=sys.stderr)
        return 1

    if is_lfs_pointer(vendor_boot_img):
        print(
            "vendor_boot.img is a Git LFS pointer. Replace it with the real image before extracting.",
            file=sys.stderr,
        )
        return 1

    output_dir.mkdir(parents=True, exist_ok=True)

    extract_boot_image(boot_img, output_dir / "boot", "boot.img")

    if init_boot_img.read_bytes().strip(b"\x00"):
        extract_boot_image(init_boot_img, output_dir / "init_boot", "init_boot.img")
    else:
        print("init_boot.img appears to be empty; skipping extraction.", file=sys.stderr)

    extract_dtbo(dtbo_img, output_dir / "dtbo")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
