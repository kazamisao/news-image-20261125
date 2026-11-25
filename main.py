"""Entry program for the make.fun bounty news-image-20261125.

The finished front page lives in this repository as entry.png, rendered by
make_image.sh. The grader runs this program twice in a sandbox with no
network and a read-only repository, so the program's whole job is to copy
that committed image into the output directory, unchanged, which makes both
runs byte-identical.
"""

import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))


def main() -> int:
    out_dir = os.environ.get("MAKEFUN_OUTPUT_DIR") or "/output"
    os.makedirs(out_dir, exist_ok=True)
    shutil.copyfile(os.path.join(HERE, "entry.png"),
                    os.path.join(out_dir, "entry.png"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
