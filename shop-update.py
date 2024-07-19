import json
import requests
import re

# Load your current JSON file
with open('file.json', 'r') as f:
    data = json.load(f)

# Fetch the README content
url = 'https://raw.githubusercontent.com/carcaschoi/tinfoil-json/main/README.md'
response = requests.get(url)
readme_content = response.text

# Extract the "## Shop Links" section
shop_links_section = re.search(r'## Shop Links\n(.*?)(\n##|\Z)', readme_content, re.DOTALL).group(1)

# Extract shop links from the "## Shop Links" section
shop_links = re.findall(r'Protocol: https\nHost: (.*?)\nTitle:', shop_links_section)
new_locations = [f"https://{link}" for link in shop_links]

# Update the locations in the JSON file
data['locations'] = [link for link in data['locations'] if link in new_locations] + [link for link in new_locations if link not in data['locations']]

# Write updated JSON to file
with open('file.json', 'w') as f:
    json.dump(data, f, indent=4)

print("file.json has been updated successfully.")
