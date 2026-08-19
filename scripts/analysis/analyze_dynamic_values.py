import gzip
import json

with gzip.open('assets/data/navigation_aids/traffic_signs.json.gz', 'rt', encoding='utf-8') as f:
    data = json.load(f)
    
# Analyze which codes have rajoitusarvo values
codes_with_values = {}
for feature in data.get('features', []):
    props = feature.get('properties', {})
    code = str(props.get('vlmlajityyppi', 'None'))
    value = props.get('rajoitusarvo')
    text1 = props.get('lisakilventeksti1', '')
    text2 = props.get('lisakilventeksti2', '')
    name = props.get('nimifi', '')
    
    if code not in codes_with_values:
        codes_with_values[code] = {'count': 0, 'with_value': 0, 'values': set(), 'samples': []}
    codes_with_values[code]['count'] += 1
    if value:
        codes_with_values[code]['with_value'] += 1
        codes_with_values[code]['values'].add(str(value))
        if len(codes_with_values[code]['samples']) < 3:
            codes_with_values[code]['samples'].append({'v': value, 't': text1 or text2, 'n': name})

print('=== Sign Types with rajoitusarvo (dynamic values) ===')
print()
for code, info in sorted(codes_with_values.items(), key=lambda x: -x[1]['with_value']):
    if info['with_value'] > 0:
        vals = list(sorted(info['values']))[:10]
        print(f"Code {code}: {info['with_value']}/{info['count']} have values")
        print(f"  Values: {vals}")
        for s in info['samples']:
            print(f"  Sample: value={s['v']}, text='{s['t']}', name='{s['n']}'")
        print()
