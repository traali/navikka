
import requests
import json
import os

# Fetch 200 items to have a reasonable initial set
url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&outputFormat=json&srsName=EPSG:4326&count=200"

output_path = os.path.join("assets", "data", "speed_limits.geojson")
print(f"Downloading initial seed data to {output_path}...")

try:
    response = requests.get(url, timeout=30)
    response.raise_for_status()
    
    data = response.json()
    count = len(data.get('features', []))
    print(f"Downloaded {count} features.")
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(data, f)
        
    print(f"Saved initial dataset. Size: {os.path.getsize(output_path)} bytes")

except Exception as e:
    print(f"Error: {e}")
