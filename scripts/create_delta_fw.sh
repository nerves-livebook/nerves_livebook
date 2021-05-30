#!/bin/bash

#
# create_delta_fw.sh <from> <to> <delta>
#

set -e

FROM_FW="$1"
TO_FW="$2"
DELTA_FW="$3"

[[ -e "$FROM_FW" ]] || (echo "Can't find $FROM_FW"; exit 1)
[[ -e "$TO_FW" ]] || (echo "Can't find $TO_FW"; exit 1)

WORK_DIR="$PWD/delta_work"
FROM_DIR="$WORK_DIR/source"
TO_DIR="$WORK_DIR/target"
OUT_DIR="$WORK_DIR/output"

rm -fr "$WORK_DIR" "$DELTA_FW"
mkdir -p "$FROM_DIR" "$TO_DIR" "$OUT_DIR/data"

unzip -qq "$FROM_FW" -d "$FROM_DIR"
unzip -qq "$TO_FW" -d "$TO_DIR"

xdelta3 -A -S -f -s "$FROM_DIR/data/rootfs.img" "$TO_DIR/data/rootfs.img" "$OUT_DIR/data/rootfs.img"

cp "$TO_FW" "$DELTA_FW"

(cd "$OUT_DIR" && zip -qq "$DELTA_FW" "data/rootfs.img")

# Cleanup
rm -fr "$WORK_DIR"

