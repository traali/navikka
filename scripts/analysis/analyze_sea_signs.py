
import requests
import json
import sys

sys.stdout.reconfigure(encoding='utf-8')

def fetch_sea_signs():
    url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:vesiliikennemerkit_uusi&outputFormat=json&count=1000"
    
    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()
        features = data.get('features', [])
        
        matches = []
        for f in features:
            p = f.get('properties', {})
            val = p.get('rajoitusarvo')
            name = str(p.get('nimifi') or '')
            
            # Check for speed limit value or name match
            is_speed = False
            if val is not None and str(val).strip() != '':
                is_speed = True
            if 'nopeus' in name.lower():
                is_speed = True
                
            if is_speed:
                matches.append({
                    'id': f.get('id'),
                    'nimifi': name,
                    'vlmtyyppi': p.get('vlmtyyppi'),
                    'lajifi': p.get('lajifi'),
                    'rajoitusarvo': val,
                    'teksti': p.get('lisakilventeksti1')
                })

        print(f"Found {len(matches)} speed related signs out of {len(features)}")
        for m in matches[:20]: # Print top 20
            print(json.dumps(m, ensure_ascii=False))

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    fetch_sea_signs()
