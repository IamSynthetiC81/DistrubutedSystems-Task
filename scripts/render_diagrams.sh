#!/usr/bin/env bash

set -e

INPUT_DIR="doc/diagrams"
OUTPUT_EXT="png"

# Create output directory if needed
mkdir -p "$INPUT_DIR"

for file in "$INPUT_DIR"/*.mmd; do
    [ -e "$file" ] || continue  # skip if no .mmd files
    base="${file%.mmd}"
    output="${base}.${OUTPUT_EXT}"

    echo "Rendering $file → $output"
    mmdc -i "$file" -o "$output"
done

echo "Done."