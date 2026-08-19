import requests
import json

# Lauttasaari center coordinates
CENTER_LAT = 60.1573
CENTER_LON = 24.8755

def calculate_bbox(lat, lon, radius_km):
    """Calculate bounding box from center point and radius in kilometers."""
    lat_degree_km = 111.0
    lon_degree_km = 55.5
    
    lat_offset = radius_km / lat_degree_km
    lon_offset = radius_km / lon_degree_km
    
    min_lon = lon - lon_offset
    min_lat = lat - lat_offset
    max_lon = lon + lon_offset
    max_lat = lat + lat_offset
    
    return (min_lon, min_lat, max_lon, max_lat)

def fetch_with_bbox(bbox, radius_km):
    """Fetch speed limit zones within a bounding box with proper CRS suffix"""
    BASE_URL = "https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs"
    
    # IMPORTANT: Must include CRS suffix for bbox to work!
    bbox_str = f"{bbox[0]},{bbox[1]},{bbox[2]},{bbox[3]},EPSG:4326"
    
    params = {
        "service": "wfs",
        "version": "2.0.0",
        "request": "GetFeature",
        "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
        "outputFormat": "json",
        "bbox": bbox_str,  # With CRS suffix
        "count": 1000
    }
    
    print(f"\n{'='*60}")
    print(f"Fetching with {radius_km}km radius bounding box")
    print(f"{'='*60}")
    print(f"Center: Lauttasaari ({CENTER_LAT:.4f}, {CENTER_LON:.4f})")
    print(f"BBox: {bbox_str}")
    
    response = requests.get(BASE_URL, params=params, timeout=60)
    response.raise_for_status()
    data = response.json()
    features = data.get("features", [])
    
    print(f"✅ Features found: {len(features)}")
    
    # Analyze the features
    if features:
        speed_zones = {}
        for feature in features:
            props = feature.get("properties", {})
            zone_type = props.get("rajoitusalue_laji_fi", "Unknown")
            speed = props.get("nopeusrajoitus_arvo")
            
            if zone_type not in speed_zones:
                speed_zones[zone_type] = []
            speed_zones[zone_type].append(speed)
        
        print("\n   Zone types found:")
        for zone_type, speeds in speed_zones.items():
            unique_speeds = set(s for s in speeds if s is not None)
            print(f"   - {zone_type}: {len(speeds)} zones (speeds: {unique_speeds})")
        
        # Show first 5 features
        print(f"\n   Sample features:")
        for i, feature in enumerate(features[:5]):
            props = feature.get("properties", {})
            zone_type = props.get("rajoitusalue_laji_fi", "Unknown")
            speed = props.get("nopeusrajoitus_arvo", "N/A")
            name = props.get("rajoitusalue_nimi_fi", "Unnamed")
            size = props.get("suuruus", "Unknown")
            print(f"   {i+1}. {name} - Type: {zone_type}, Speed: {speed}, Size: {size}")
    
    return data

if __name__ == "__main__":
    print("="*60)
    print("TESTING SPEED LIMIT API WITH BBOX (WITH CRS SUFFIX)")
    print("Center: Lauttasaari, Helsinki")
    print("="*60)
    
    # Test different radii: 5km, 2.5km, 1km, 0.5km
    test_radii = [5.0, 2.5, 1.0, 0.5]
    
    results = {}
    for radius in test_radii:
        bbox = calculate_bbox(CENTER_LAT, CENTER_LON, radius)
        try:
            data = fetch_with_bbox(bbox, radius)
            results[radius] = data
            
            # Save to file
            output_path = f"DOCS/lauttasaari_{int(radius*1000)}m.json"
            with open(output_path, "w", encoding="utf-8") as f:
                json.dump(data, f, indent=2)
            print(f"   💾 Saved to: {output_path}")
            
        except Exception as e:
            print(f"❌ Error with {radius}km: {e}")
            results[radius] = None
    
    # Summary
    print(f"\n{'='*60}")
    print("SUMMARY - Features per bbox size:")
    print(f"{'='*60}")
    for radius, data in results.items():
        if data:
            count = len(data.get("features", []))
            size_desc = f"{radius}km radius (~{radius*2}km x {radius*2}km box)"
            print(f"  {size_desc:30} → {count:3} features")
            
            # Calculate data size
            import sys
            size_kb = sys.getsizeof(json.dumps(data)) / 1024
            print(f"     {'':30}   (~{size_kb:.1f} KB)")
        else:
            print(f"  {radius}km radius: ❌ Failed")
    
    print(f"\n{'='*60}")
    print("RECOMMENDATION:")
    print(f"{'='*60}")
    
    # Recommend based on feature count
    recommended = None
    for radius in sorted(test_radii, reverse=True):
        if results.get(radius):
            count = len(results[radius].get("features", []))
            if count > 0 and count < 100:  # Sweet spot
                recommended = radius
                break
    
    if recommended:
        print(f"✅ Use {recommended}km radius for optimal balance")
        print(f"   (Provides good coverage without excessive data)")
    else:
        print("⚠️  Consider adjusting bbox size based on needs")
    
    print("\n✅ Testing complete!")
