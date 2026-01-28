#!/bin/bash

set -e

# Check if the GitHub CLI is installed
if ! command -v gh &> /dev/null; then
  echo "GitHub CLI (gh) is not installed. Please install it and try again."
  exit 1
fi

# For the following command:
# - We use awk to print the file because it will append a trailing newline if it is missing
# - We use 'tr -d "\r"' to remove carriage returns in case the file has been edited on Windows
awk 1 features.txt | tr -d "\r" | while read title; do
    if [[ $title == *REDUNDANT* ]]; then
      echo "Skipping REDUNDANT feature: $title"
      continue
    fi

    echo "Creating issue for: $title"

    # Create a GitHub issue
    issue_url="$(gh issue create --repo vanderbilt-redcap/redcap_rsvc --title "$title" --body ""| grep https)"

    gh project item-add 2 --url $issue_url --owner vanderbilt-redcap

    # Attempt to avoid API rate limiting (may need tweaking depending on batch size)
    sleep 1
done