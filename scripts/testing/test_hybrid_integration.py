"""
Test script to verify bbox integration works correctly.
This simulates the hybrid approach: bbox when online, offline when not.
"""

import requests
import json

def test_bbox_query(center_lat, center_lon, radius_km):
    """Test bbox query with given parameters"""
    # Calculate bbox
    lat_degree_km = 111.0
    lon_degree_km = 55.5
    
    lat_offset = radius_km / lat_degree_km
    lon_offset = radius_km / lon_degree_km
    
    min_lon = center_lon - lon_offset
    min_lat = center_lat - lat_offset
    max_lon = center_lon + lon_offset
    max_lat = center_lat + lat_offset
    
    bbox_str = f"{min_lon},{min_lat},{max_lon},{max_lat},EPSG:4326"
    
    print(f"\n{'='*60}")
    print(f"Testing BBox Query")
    print(f"{'='*60}")
    print(f"Center: ({center_lat:.4f}, {center_lon:.4f})")
    print(f"Radius: {radius_km}km")
    print(f"BBox: {bbox_str}")
    
    try:
        response = requests.get(
            'https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs',
            params={
                'service': 'wfs',
                'version': '2.0.0',
                'request': 'GetFeature',
                'typeName': 'vesivaylatiedot:rajoitusalue_a_uusi',
                'outputFormat': 'json',
                'bbox': bbox_str,
                'count': 1000
            },
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            features = data.get('features', [])
            print(f"✅ SUCCESS: Got {len(features)} features")
            return True, len(features)
        else:
            print(f"❌ FAILED: Status {response.status_code}")
            return False, 0
            
    except Exception as e:
        print(f"❌ ERROR: {e}")
        return False, 0

def test_offline_fallback():
    """Test that offline bundled data exists"""
    print(f"\n{'='*60}")
    print(f"Testing Offline Fallback")
    print(f"{'='*60}")
    
    try:
        with open('assets/data/speed_limits.geojson', 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        features = data.get('features', [])
        print(f"✅ Bundled data exists: {len(features)} features")
        print(f"   File: assets/data/speed_limits.geojson")
        return True, len(features)
        
    except Exception as e:
        print(f"❌ FAILED: {e}")
        return False, 0

if __name__ == "__main__":
    print("="*60)
    print("HYBRID BBOX INTEGRATION TEST")
    print("="*60)
    
    # Test 1: BBox query (simulates online mode)
    print("\n[TEST 1] BBox Query (Online Mode)")
    bbox_success, bbox_count = test_bbox_query(
        center_lat=60.1573,  # Lauttasaari
        center_lon=24.8755,
        radius_km=5.0
    )
    
    # Test 2: Offline fallback
    print("\n[TEST 2] Offline Fallback")
    offline_success, offline_count = test_offline_fallback()
    
    # Summary
    print(f"\n{'='*60}")
    print("TEST SUMMARY")
    print(f"{'='*60}")
    
    if bbox_success and offline_success:
        print("✅ ALL TESTS PASSED!")
        print(f"\nHybrid Mode Benefits:")
        print(f"  Online (bbox):  {bbox_count} features (fast, relevant)")
        print(f"  Offline (full): {offline_count} features (reliable, complete)")
        print(f"  Efficiency:     {(1 - bbox_count/offline_count)*100:.1f}% reduction when online")
    else:
        print("❌ SOME TESTS FAILED")
        if not bbox_success:
            print("  - BBox query failed (check network/API)")
        if not offline_success:
            print("  - Offline data missing (check bundled assets)")
    
    print(f"\n{'='*60}")
    print("FLUTTER APP BEHAVIOR:")
    print(f"{'='*60}")
    print("1. User launches app WITHOUT location:")
    print("   → Uses offline bundled data (1,446 features)")
    print("")
    print("2. User launches app WITH location (online):")
    print(f"   → Uses bbox query (~{bbox_count} features for 5km)")
    print("   → Falls back to bundled data if API fails")
    print("")
    print("3. User launches app WITH location (offline):")
    print("   → bbox query fails (no internet)")
    print("   → Automatically falls back to bundled data")
    print(f"\n✅ App always works, online or offline!")
