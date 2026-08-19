
import requests
import shutil
import os

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&outputFormat=json&srsName=EPSG:4326"
output_path = os.path.join("assets", "data", "speed_limits.geojson")

print(f"Downloading to {output_path}...")
try:
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(output_path, 'wb') as f:
            shutil.copyfileobj(r.raw, f)
            
    print("Download complete.")
    
    # Check size
    size = os.path.getsize(output_path)
    print(f"File size: {size} bytes")
    
    if size < 1000:
        print("Warning: File is suspiciously small.")
        with open(output_path, 'r') as f:
            print(f.read())

except Exception as e:
    print(f"Failed: {e}")
