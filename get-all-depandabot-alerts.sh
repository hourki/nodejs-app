#!/bin/bash

REPO_OWNER="hourki"
REPO_NAME="nodejs-app"
GITHUB_TOKEN="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"

# Retrieve the list of open Dependabot alerts
RESPONSE=$(curl -H "Authorization: Bearer $GITHUB_TOKEN" \
                -H "X-GitHub-Api-Version: 2022-11-28" \
                -H "Accept: application/vnd.github+json" \
                "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/dependabot/alerts")


# Check if the response is empty
if [ "$(echo "$RESPONSE" | jq '.[]')" == "null" ]; then
    echo "There are no Dependabot alerts in this repository."
    exit 0
fi

# Filter the alerts by severity level
ALERTS=$(echo "$RESPONSE" | jq '.[] | select(.security_advisory.severity == "critical")')

# Print the list of alerts
echo "Dependabot low severity alerts:"
echo "$ALERTS"