import requests
import json

BASE_URL = "https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs"
PAGE_SIZE = 500  # Safe limit (under 700)

def fetch_all_zones():
    all_features = []
    start_index = 0
    
    while True:
        params = {
            "service": "wfs",
            "version": "2.0.0", 
            "request": "GetFeature",
            "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
            "outputFormat": "json",
            "srsName": "EPSG:4326",
            "count": PAGE_SIZE,
            "startIndex": start_index
        }
        
        print(f"Fetching from index {start_index}...")
        response = requests.get(BASE_URL, params=params, timeout=60)
        response.raise_for_status()
        data = response.json()
        features = data.get("features", [])
        
        all_features.extend(features)
        print(f"  Got {len(features)} features (total: {len(all_features)})")
        
        if len(features) < PAGE_SIZE:
            break
        start_index += PAGE_SIZE
    
    return {
        "type": "FeatureCollection",
        "features": all_features
    }

if __name__ == "__main__":
    print("Fetching all speed limit zones from Finnish WFS API...")
    result = fetch_all_zones()
    
    output_path = "assets/data/speed_limits.geojson"
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(result, f)
    
    print(f"\n✅ Saved {len(result['features'])} features to {output_path}")
