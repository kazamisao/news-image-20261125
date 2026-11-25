"""Checks for the news-image-20261125 entry.

Run: python3 test_entry.py
Verifies that entry.png is a whole PNG inside the competition limits and
that main.py copies it to the output directory byte for byte, twice.
"""

import os
import struct
import subprocess
import sys
import tempfile
import zlib

HERE = os.path.dirname(os.path.abspath(__file__))
PNG = os.path.join(HERE, "entry.png")
MAX_BYTES = 1048576
MAX_SIDE = 1024


def png_dimensions(data):
    assert data[:8] == b"\x89PNG\r\n\x1a\n", "not a PNG"
    pos = 8
    width = height = None
    while pos < len(data):
        (length,) = struct.unpack(">I", data[pos:pos + 4])
        kind = data[pos + 4:pos + 8]
        body = data[pos + 8:pos + 8 + length]
        (crc,) = struct.unpack(">I", data[pos + 8 + length:pos + 12 + length])
        assert zlib.crc32(kind + body) & 0xFFFFFFFF == crc, f"bad CRC in {kind}"
        if kind == b"IHDR":
            width, height = struct.unpack(">II", body[:8])
        pos += 12 + length
        if kind == b"IEND":
            break
    return width, height


def main():
    data = open(PNG, "rb").read()
    assert len(data) <= MAX_BYTES, f"entry.png too large: {len(data)}"
    width, height = png_dimensions(data)
    assert width <= MAX_SIDE and height <= MAX_SIDE, (width, height)
    print(f"entry.png: {width}x{height}, {len(data)} bytes, chunks OK")

    for run in (1, 2):
        with tempfile.TemporaryDirectory() as out:
            env = dict(os.environ, MAKEFUN_OUTPUT_DIR=out)
            subprocess.run([sys.executable, "-P", "-s",
                            os.path.join(HERE, "main.py")],
                           env=env, check=True)
            copied = open(os.path.join(out, "entry.png"), "rb").read()
            assert copied == data, f"run {run}: copy differs"
    print("main.py: two runs, byte-identical copies")
    print("ALL CHECKS PASSED")


if __name__ == "__main__":
    main()
