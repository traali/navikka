import json

# Check the current bundled data
with open("assets/data/speed_limits.geojson", "r", encoding="utf-8") as f:
    data = json.load(f)

features = data.get("features", [])
print(f"Total features in bundled data: {len(features)}")

# Find features near Helsinki/Lauttasaari area
# Lauttasaari: ~60.157, 24.875
# Search within a larger area to see what's available
helsinki_features = []

for feature in features:
    props = feature.get("properties", {})
    geom = feature.get("geometry", {})
    
    # Get first coordinate to check location
    if geom.get("type") == "Polygon" and geom.get("coordinates"):
        coords = geom["coordinates"][0]  # First ring
        if coords:
            # Check if any coordinate is near Helsinki area (24-25 lon, 60-61 lat)
            for coord in coords[:5]:  # Check first few coords
                lon, lat = coord[0], coord[1]
                if 24.0 <= lon <= 25.5 and 59.8 <= lat <= 60.5:
                    helsinki_features.append(feature)
                    break

print(f"\nFeatures in greater Helsinki area (24-25.5°E, 59.8-60.5°N): {len(helsinki_features)}")

# Show some details
if helsinki_features:
    print("\nSample features in Helsinki area:")
    for i, feature in enumerate(helsinki_features[:10]):
        props = feature.get("properties", {})
        name = props.get("rajoitusalue_nimi_fi", "Unnamed")
        zone_type = props.get("rajoitusalue_laji_fi", "Unknown")
        speed = props.get("nopeusrajoitus_arvo", "N/A")
        
        # Get center coordinate
        geom = feature.get("geometry", {})
        if geom.get("coordinates"):
            coords = geom["coordinates"][0]
            if coords:
                lon, lat = coords[0][0], coords[0][1]
                print(f"{i+1}. {name} ({lat:.4f}, {lon:.4f}) - {zone_type}, Speed: {speed}")

# Find features closest to Lauttasaari
CENTER_LAT = 60.1573
CENTER_LON = 24.8755

closest_features = []
for feature in features:
    geom = feature.get("geometry", {})
    if geom.get("type") == "Polygon" and geom.get("coordinates"):
        coords = geom["coordinates"][0]
        if coords:
            # Calculate distance to first coordinate
            lon, lat = coords[0][0], coords[0][1]
            dist = ((lat - CENTER_LAT)**2 + (lon - CENTER_LON)**2)**0.5
            closest_features.append((dist, feature))

closest_features.sort(key=lambda x: x[0])

print(f"\n\nClosest 10 features to Lauttasaari ({CENTER_LAT}, {CENTER_LON}):")
for i, (dist, feature) in enumerate(closest_features[:10]):
    props = feature.get("properties", {})
    name = props.get("rajoitusalue_nimi_fi", "Unnamed")
    zone_type = props.get("rajoitusalue_laji_fi", "Unknown")
    speed = props.get("nopeusrajoitus_arvo", "N/A")
    
    geom = feature.get("geometry", {})
    coords = geom["coordinates"][0]
    lon, lat = coords[0][0], coords[0][1]
    
    dist_km = dist * 111  # Rough conversion to km
    print(f"{i+1}. {name} ({lat:.4f}, {lon:.4f}) - {zone_type}, Speed: {speed} - ~{dist_km:.1f}km away")
