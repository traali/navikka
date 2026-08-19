import json

with open('assets/data/speed_limits.geojson', 'r', encoding='utf-8') as f:
    data = json.load(f)

features = data.get('features', [])
print(f'Bundled features: {len(features)}')

# Calculate file size
import os
file_size = os.path.getsize('assets/data/speed_limits.geojson')
print(f'File size: {file_size / 1024 / 1024:.2f} MB')

# Check if all required properties are present
if features:
    sample = features[0]
    print(f'\nSample feature structure:')
    print(f'  Has geometry: {bool(sample.get("geometry"))}')
    print(f'  Has properties: {bool(sample.get("properties"))}')
    
    props = sample.get('properties', {})
    print(f'\nSample properties:')
    for key in ['rajoitustyyppi', 'suuruus', 'nimisijainti']:
        print(f'  {key}: {props.get(key, "N/A")}')
