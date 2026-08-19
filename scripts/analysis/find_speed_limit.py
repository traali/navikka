
import requests
import json

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&count=100&outputFormat=json&srsName=EPSG:4326"

try:
    response = requests.get(url)
    data = response.json()
    
    found = False
    if 'features' in data:
        for f in data['features']:
            props = f.get('properties', {})
            # normalizing keys just in case
            if props.get('rajoitustyyppi') == 'Nopeusrajoitus':
                print("FOUND SPEED LIMIT:")
                print(json.dumps(props, indent=2, ensure_ascii=False))
                found = True
                break
    
    if not found:
        print("No speed limit feature found in first 100.")
        # Print unique types found
        types = set()
        for f in data['features']:
            types.add(f['properties'].get('rajoitustyyppi'))
        print("Types found:", types)

except Exception as e:
    print(f"Error: {e}")
