
import requests
import json

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&count=10&outputFormat=json&srsName=EPSG:4326"
print("Fetching URL:", url)
try:
    response = requests.get(url)
    response.raise_for_status() 
    data = response.json()
    
    if 'features' in data:
        for f in data['features']:
            props = f.get('properties', {})
            print(json.dumps(props, indent=2, ensure_ascii=False))
            # Also print geometry type and first coordinate to check valid wgs84
            geom = f.get('geometry', {})
            print(f"Geometry Type: {geom.get('type')}")
            coords = geom.get('coordinates', [])
            if coords and len(coords) > 0:
                print(f"First Coord: {coords[0][0]}") 
            print("-" * 20)
    else:
        print("No features found")
        print(data)

except Exception as e:
    print(f"Error: {e}")
