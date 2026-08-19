import json
import gzip

data = json.loads(gzip.open('assets/data/navigation_aids/traffic_signs.json.gz', 'rt', encoding='utf-8').read())

# Get one example for each vlmlajityyppi
examples = {}
for f in data.get('features', []):
    props = f.get('properties', {})
    code = props.get('vlmlajityyppi')
    if code not in examples:
        examples[code] = props

# Print sorted by code
for code in sorted(examples.keys(), key=lambda x: x if x is not None else 999):
    e = examples[code]
    print(f"=== vlmlajityyppi: {code} ===")
    print(f"  nimifi: {e.get('nimifi')}")
    print(f"  vlmtyyppi: {e.get('vlmtyyppi')}")
    print(f"  rajoitusarvo: {e.get('rajoitusarvo')}")
    print(f"  tklnumero: {e.get('tklnumero')}")
    print(f"  lisakilventeksti1: {e.get('lisakilventeksti1')}")
    print(f"  lisakilventeksti2: {e.get('lisakilventeksti2')}")
    print(f"  vaikutusalue: {e.get('vaikutusalue')}")
    print()
