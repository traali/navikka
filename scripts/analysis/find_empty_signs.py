import gzip
import json

with gzip.open('assets/data/navigation_aids/traffic_signs.json.gz', 'rt', encoding='utf-8') as f:
    data = json.load(f)

# Find signs WITHOUT rajoitusarvo
no_value = {}
for feat in data.get('features', []):
    props = feat.get('properties', {})
    code = str(props.get('vlmlajityyppi', 'None'))
    value = props.get('rajoitusarvo')
    coords = feat.get('geometry', {}).get('coordinates', [])
    name = props.get('nimifi', '')
    
    # Check if in Lauttasaari area (roughly 24.85-24.95 lon, 60.14-60.18 lat)
    if coords and len(coords) >= 2:
        lon, lat = coords[0], coords[1]
        if 24.85 < lon < 24.95 and 60.14 < lat < 60.18:
            if value is None:
                if code not in no_value:
                    no_value[code] = []
                no_value[code].append({'name': name, 'lon': lon, 'lat': lat})

print('Signs near Lauttasaari WITHOUT rajoitusarvo:')
print()
for code, signs in sorted(no_value.items()):
    print(f'Code {code}: {len(signs)} signs without value')
    for s in signs[:5]:
        print(f'  - {s["name"]}')
