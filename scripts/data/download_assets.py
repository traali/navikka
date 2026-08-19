
import requests
import json
import os

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&outputFormat=json&srsName=EPSG:4326"

print(f"Downloading FULL data from {url}...")
try:
    # Use allow_redirects just in case, and a timeout
    response = requests.get(url, timeout=120) 
    response.raise_for_status()
    
    data = response.json()
    count = len(data.get('features', []))
    print(f"Downloaded {count} features.")
    
    if count > 0:
        output_path = os.path.join("assets", "data", "speed_limits.geojson")
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(data, f) # Minified save to save space
            
        print(f"Successfully saved to {output_path}")
    else:
        print("Warning: No features found in response.")

except Exception as e:
    print(f"Error: {e}")
