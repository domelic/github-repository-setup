#!/bin/bash
# generate-workflow-changelog.sh
#
# Generates a changelog entry for workflow template changes between two git refs.
# Outputs markdown format suitable for appending to docs/WORKFLOW_CHANGELOG.md
#
# Usage:
#   ./scripts/generate-workflow-changelog.sh <old-ref> <new-ref>
#   ./scripts/generate-workflow-changelog.sh v0.1.20 v0.1.21
#
# If no arguments provided, compares HEAD~1 to HEAD

set -euo pipefail

OLD_REF="${1:-HEAD~1}"
NEW_REF="${2:-HEAD}"
WORKFLOW_DIR="templates/workflows"

# Get the version from the new ref (strip 'v' prefix if present)
VERSION="${NEW_REF#v}"
DATE=$(date +%Y-%m-%d)

# Arrays to store changes
declare -a ADDED=()
declare -a MODIFIED=()
declare -a REMOVED=()

# Get diff of workflow files
while IFS=$'\t' read -r status file; do
    # Only process .yml files in the workflows directory
    if [[ "$file" == "$WORKFLOW_DIR"/*.yml ]]; then
        # Extract just the filename
        filename=$(basename "$file")

        case "$status" in
            A)
                ADDED+=("$filename")
                ;;
            M)
                MODIFIED+=("$filename")
                ;;
            D)
                REMOVED+=("$filename")
                ;;
            R*)
                # Renamed - treat as removed old + added new
                old_file=$(echo "$status" | cut -f2)
                REMOVED+=("$(basename "$old_file")")
                ADDED+=("$filename")
                ;;
        esac
    fi
done < <(git diff --name-status "$OLD_REF".."$NEW_REF" -- "$WORKFLOW_DIR")

# Check if there are any changes
if [[ ${#ADDED[@]} -eq 0 && ${#MODIFIED[@]} -eq 0 && ${#REMOVED[@]} -eq 0 ]]; then
    echo "No workflow changes between $OLD_REF and $NEW_REF"
    exit 0
fi

# Generate markdown output
echo ""
echo "## $VERSION ($DATE)"
echo ""

if [[ ${#ADDED[@]} -gt 0 ]]; then
    echo "### Added"
    for file in "${ADDED[@]}"; do
        # Try to get the workflow name from metadata
        name=$(grep -A1 "file: $file" "$WORKFLOW_DIR/workflow-metadata.yaml" 2>/dev/null | grep "name:" | sed 's/.*name: //' || echo "")
        if [[ -n "$name" ]]; then
            echo "- \`$file\` - $name"
        else
            echo "- \`$file\`"
        fi
    done
    echo ""
fi

if [[ ${#MODIFIED[@]} -gt 0 ]]; then
    echo "### Modified"
    for file in "${MODIFIED[@]}"; do
        echo "- \`$file\`"
    done
    echo ""
fi

if [[ ${#REMOVED[@]} -gt 0 ]]; then
    echo "### Removed"
    for file in "${REMOVED[@]}"; do
        echo "- \`$file\`"
    done
    echo ""
fi
