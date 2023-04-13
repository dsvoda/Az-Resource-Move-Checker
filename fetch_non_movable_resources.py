# Author: @seanvoda
# Description: Fetches the list of non-movable resources from the Azure docs and saves them to a JSON file
# Usage: python fetch_non_movable_resources.py
# Output: NonMovableResources.json
# Notes: This script is not meant to be run as part of the build process. It is provided as a convenience for updating the list of non-movable resources.
# Dependencies: requests, re, json
# Date: 2023-04-13
# Version: 1.0.0

import json
import re
import requests

url = 'https://raw.githubusercontent.com/MicrosoftDocs/azure-docs/main/articles/azure-resource-manager/management/move-support-resources.md'
response = requests.get(url)

non_movable_resource_types = []

service_pattern = r'^##\s+(.*?)$'
service_matches = list(re.finditer(service_pattern, response.text, re.IGNORECASE | re.MULTILINE))

row_pattern = r'\|\s*(.*?)(?:\*\*Yes\*\*|\*\*No\*\*)?\s*\|\s*(?:Yes|No)\s*\|\s*No\s*\|'
row_matches = list(re.finditer(row_pattern, response.text, re.IGNORECASE | re.MULTILINE))

service_index = 0

for row_match in row_matches:
    row_pos = row_match.start()

    while service_index < len(service_matches) - 1 and row_pos > service_matches[service_index + 1].start():
        service_index += 1

    full_resource_type = f"{service_matches[service_index].group(1)}/{row_match.group(1)}"
    
    # Fix resource type format
    full_resource_type = full_resource_type.replace('>', '/').replace('|', '').replace(' ', '').replace('//', '/')
    non_movable_resource_types.append(full_resource_type.strip())

with open('NonMovableResources.json', 'w') as outfile:
    json.dump({'ResourceTypes': non_movable_resource_types}, outfile)