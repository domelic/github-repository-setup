#!/bin/bash

# Setup Branch Protection Script
# This script configures branch protection rules and repository settings
# using the GitHub CLI (gh)
#
# Prerequisites:
# - GitHub CLI installed and authenticated (gh auth login)
# - Repository admin access
#
# Usage:
#   ./setup-branch-protection.sh owner/repo [branch]
#   ./setup-branch-protection.sh myorg/myrepo main
#   ./setup-branch-protection.sh myorg/myrepo  # defaults to main

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
if [ -z "$1" ]; then
    echo -e "${RED}Error: Repository required${NC}"
    echo "Usage: $0 owner/repo [branch]"
    exit 1
fi

REPO="$1"
BRANCH="${2:-main}"

echo -e "${GREEN}Setting up branch protection for ${REPO} (branch: ${BRANCH})${NC}"
echo ""

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed${NC}"
    echo "Install it from: https://cli.github.com/"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${RED}Error: Not authenticated with GitHub CLI${NC}"
    echo "Run: gh auth login"
    exit 1
fi

# Function to handle errors
handle_error() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

# Enable auto-delete merged branches
echo "Enabling auto-delete merged branches..."
gh api "repos/${REPO}" -X PATCH -f delete_branch_on_merge=true || handle_error "Could not enable auto-delete branches"

# Enable Discussions (optional)
echo "Enabling Discussions..."
gh api "repos/${REPO}" -X PATCH -f has_discussions=true || handle_error "Could not enable Discussions"

# Configure branch protection
echo "Configuring branch protection for ${BRANCH}..."
gh api "repos/${REPO}/branches/${BRANCH}/protection" -X PUT --input - <<EOF || handle_error "Could not set branch protection"
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "require_last_push_approval": false
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_linear_history": false,
  "required_conversation_resolution": true
}
EOF

# Require signed commits (optional, uncomment if needed)
# echo "Requiring signed commits..."
# gh api "repos/${REPO}/branches/${BRANCH}/protection/required_signatures" -X POST || handle_error "Could not require signed commits"

echo ""
echo -e "${GREEN}Branch protection configured successfully!${NC}"
echo ""
echo "Summary of settings applied:"
echo "  - Auto-delete merged branches: enabled"
echo "  - Discussions: enabled"
echo "  - Branch protection on ${BRANCH}:"
echo "    - Require pull request before merging"
echo "    - Enforce for administrators"
echo "    - Dismiss stale reviews"
echo "    - Require conversation resolution"
echo "    - Disallow force pushes"
echo "    - Disallow deletions"
echo ""
echo -e "${YELLOW}Note: To require status checks, add required checks to branch protection in GitHub settings.${NC}"

# Optional: Create labels
read -p "Create recommended labels? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Creating labels..."
    gh label create "bug" -c "d73a4a" -d "Something isn't working" -R "$REPO" 2>/dev/null || true
    gh label create "enhancement" -c "a2eeef" -d "New feature or request" -R "$REPO" 2>/dev/null || true
    gh label create "documentation" -c "0075ca" -d "Improvements or additions to documentation" -R "$REPO" 2>/dev/null || true
    gh label create "good first issue" -c "7057ff" -d "Good for newcomers" -R "$REPO" 2>/dev/null || true
    gh label create "help wanted" -c "008672" -d "Extra attention is needed" -R "$REPO" 2>/dev/null || true
    gh label create "stale" -c "ededed" -d "Inactive issue/PR" -R "$REPO" 2>/dev/null || true
    gh label create "pinned" -c "006b75" -d "Exempt from stale bot" -R "$REPO" 2>/dev/null || true
    gh label create "dependencies" -c "0366d6" -d "Pull requests that update a dependency file" -R "$REPO" 2>/dev/null || true
    gh label create "github-actions" -c "000000" -d "Pull requests that update GitHub Actions" -R "$REPO" 2>/dev/null || true
    echo -e "${GREEN}Labels created!${NC}"
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
