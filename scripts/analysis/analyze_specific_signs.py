import json
import gzip

# Specific codes to look for
target_codes = [15, 17, 19, 22, 30, 32]
found_codes = set()

data = json.loads(gzip.open('assets/data/navigation_aids/traffic_signs.json.gz', 'rt', encoding='utf-8').read())

print(f"Searching for examples of codes: {target_codes}")

for f in data.get('features', []):
    props = f.get('properties', {})
    code = props.get('vlmlajityyppi')
    
    if code in target_codes and code not in found_codes:
        print(f"\n--- Example for vlmlajityyppi {code} ---")
        print(json.dumps(f, indent=2, ensure_ascii=False))
        found_codes.add(code)
    
    if len(found_codes) == len(target_codes):
        break

# Check if any were missed
missing = set(target_codes) - found_codes
if missing:
    print(f"\nCould not find examples for: {missing}")
