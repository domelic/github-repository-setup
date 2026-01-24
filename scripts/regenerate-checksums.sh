#!/bin/bash
#
# Regenerate SHA-256 checksums for all templates
#
# Usage: ./scripts/regenerate-checksums.sh [version]
# Example: ./scripts/regenerate-checksums.sh v0.1.14
#
# If no version is provided, reads from .release-please-manifest.json

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$ROOT_DIR/templates"
OUTPUT_FILE="$TEMPLATES_DIR/checksums.json"

# Get version from argument or manifest
if [[ $# -ge 1 ]]; then
    VERSION="${1#v}"  # Strip leading 'v' if present
else
    # Read from release-please manifest
    VERSION=$(grep -o '"\.": "[^"]*"' "$ROOT_DIR/.release-please-manifest.json" | cut -d'"' -f4)
fi

echo "Generating checksums for version: $VERSION"
echo "Templates directory: $TEMPLATES_DIR"

# Start JSON output
cat > "$OUTPUT_FILE" << EOF
{
  "\$schema": "https://json-schema.org/draft/2020-12/schema",
  "\$comment": "SHA-256 checksums for template integrity verification. Generated for v$VERSION",
  "version": "$VERSION",
  "algorithm": "sha256",
  "checksums": {
EOF

# Find all files, excluding checksums.json and commands directory
# Sort for consistent ordering
FIRST=true
find "$TEMPLATES_DIR" -type f \
    ! -name "checksums.json" \
    ! -path "*/commands/*" \
    | sort \
    | while read -r file; do

    # Get relative path from templates directory
    relative_path="${file#$TEMPLATES_DIR/}"

    # Calculate SHA-256 checksum
    checksum=$(shasum -a 256 "$file" | cut -d' ' -f1)

    # Add comma before all entries except first
    if [[ "$FIRST" == "true" ]]; then
        FIRST=false
    else
        echo ","
    fi

    # Output JSON entry (no trailing newline)
    printf '    "%s": "%s"' "$relative_path" "$checksum"
done >> "$OUTPUT_FILE"

# Close JSON
cat >> "$OUTPUT_FILE" << EOF

  }
}
EOF

echo ""
echo "Checksums written to: $OUTPUT_FILE"

# Count files
FILE_COUNT=$(grep -c '": "' "$OUTPUT_FILE" | head -1 || echo 0)
echo "Total templates checksummed: $FILE_COUNT"
