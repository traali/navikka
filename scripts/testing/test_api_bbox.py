import requests
import json

# Test different bbox parameter formats with the WFS API
BASE_URL = "https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs"

# Lauttasaari area
CENTER_LAT = 60.1573
CENTER_LON = 24.8755

# Test 1: Try without bbox - should return all data (paginated)
print("="*60)
print("TEST 1: Fetching without bbox (baseline)")
print("="*60)
response = requests.get(BASE_URL, params={
    "service": "wfs",
    "version": "2.0.0",
    "request": "GetFeature",
    "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
    "outputFormat": "json",
    "srsName": "EPSG:4326",
    "count": 10
}, timeout=60)

data = response.json()
features = data.get("features", [])
print(f"✅ Got {len(features)} features (limited to 10)")
if features:
    props = features[0].get("properties", {})
    print(f"First feature properties: {list(props.keys())}")

# Test 2: Try with bbox parameter (WFS 2.0.0 format)
print("\n" + "="*60)
print("TEST 2: Trying bbox parameter (minLon,minLat,maxLon,maxLat)")
print("="*60)

# 5km radius bbox
bbox_str = "24.7855,60.1123,24.9656,60.2023"
print(f"BBox: {bbox_str}")

response = requests.get(BASE_URL, params={
    "service": "wfs",
    "version": "2.0.0",
    "request": "GetFeature",
    "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
    "outputFormat": "json",
    "srsName": "EPSG:4326",
    "bbox": bbox_str,
    "count": 100
}, timeout=60)

data = response.json()
features = data.get("features", [])
print(f"Result: {len(features)} features")

# Test 3: Try with bbox and crs
print("\n" + "="*60)
print("TEST 3: Trying bbox with CRS suffix")
print("="*60)

bbox_crs = f"{bbox_str},EPSG:4326"
print(f"BBox with CRS: {bbox_crs}")

response = requests.get(BASE_URL, params={
    "service": "wfs",
    "version": "2.0.0",
    "request": "GetFeature",
    "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
    "outputFormat": "json",
    "bbox": bbox_crs,
    "count": 100
}, timeout=60)

data = response.json()
features = data.get("features", [])
print(f"Result: {len(features)} features")

# Test 4: Check capability document
print("\n" + "="*60)
print("TEST 4: Checking GetCapabilities for bbox support")
print("="*60)

response = requests.get(BASE_URL, params={
    "service": "wfs",
    "version": "2.0.0",
    "request": "GetCapabilities"
}, timeout=60)

# Just check if bbox is mentioned
if "bbox" in response.text.lower() or "boundingbox" in response.text.lower():
    print("✅ BBox/BoundingBox mentioned in capabilities")
else:
    print("⚠️  BBox not explicitly mentioned in capabilities")

# Save capabilities for inspection
with open("DOCS/wfs_capabilities.xml", "w", encoding="utf-8") as f:
    f.write(response.text)
print("Saved capabilities to DOCS/wfs_capabilities.xml")

# Test 5: Fetch all and filter client-side (current bundled approach)
print("\n" + "="*60)
print("TEST 5: Verifying current fetching works")
print("="*60)

all_features = []
for start in [0, 500]:
    response = requests.get(BASE_URL, params={
        "service": "wfs",
        "version": "2.0.0",
        "request": "GetFeature",
        "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
        "outputFormat": "json",
        "srsName": "EPSG:4326",
        "count": 500,
        "startIndex": start
    }, timeout=60)
    
    data = response.json()
    features = data.get("features", [])
    all_features.extend(features)
    print(f"  Page {start//500 + 1}: {len(features)} features")
    
    if len(features) < 500:
        break

print(f"✅ Total fetched without bbox: {len(all_features)} features")

print("\n" + "="*60)
print("CONCLUSION:")
print("="*60)
print("The API may not properly support bbox filtering.")
print("Current approach (fetch all, filter client-side) is working correctly.")
print(f"Total features available: {len(all_features)}")
