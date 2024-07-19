import requests
import json

# GitHub repository details
owner = 'Atmosphere-NX'
repo = 'Atmosphere'

# GitHub API URL for latest release
api_url = f'https://api.github.com/repos/{owner}/{repo}/releases/latest'

# Fetch the latest release data
response = requests.get(api_url)
response.raise_for_status()
latest_release = response.json()

# Extract the tag name, title, and download URL for the latest release
latest_tag_name = latest_release['tag_name']
latest_title = latest_release['name']
latest_download_url = None

for asset in latest_release['assets']:
    if 'atmosphere' in asset['name'].lower():
        latest_download_url = asset['browser_download_url']
        break

if not latest_download_url:
    print("No suitable download URL found in the latest release.")
else:
    # Path to the updates.json file
    updates_file_path = 'updates.json'

    # Load the current updates.json content
    with open(updates_file_path, 'r') as file:
        updates = json.load(file)

    # Update the cfws -> Atmosphere entry with the new release
    if 'cfws' not in updates:
        updates['cfws'] = {}
    if 'Atmosphere' not in updates['cfws']:
        updates['cfws']['Atmosphere'] = {}

    # Remove the "[Latest]" word from the existing entries and update them
    current_entries = updates['cfws']['Atmosphere']
    updated_entries = {}
    
    for key, value in current_entries.items():
        # Remove "[Latest]" from key if it exists
        new_key = key.replace('[Latest]', '').strip()
        updated_entries[new_key] = value

    # Create the new entry with dynamic naming
    new_entry_name = f'8BP {latest_tag_name} - {latest_title} [Latest]'
    updated_entries = {new_entry_name: latest_download_url, **updated_entries}

    # Update the JSON with the new entries
    updates['cfws']['Atmosphere'] = updated_entries

    # Save the updated content back to updates.json
    with open(updates_file_path, 'w') as file:
        json.dump(updates, file, indent=4)

    print("updates.json has been updated with the latest release.")
