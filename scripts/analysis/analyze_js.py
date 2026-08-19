import re

def analyze_js():
    try:
        with open('external_main.js', 'r', encoding='utf-8') as f:
            content = f.read()
            
        bbox_count = len(re.findall(r'bbox', content, re.IGNORECASE))
        getfeature_count = len(re.findall(r'GetFeature', content, re.IGNORECASE))
        strategy_count = len(re.findall(r'strategy', content, re.IGNORECASE))
        loading_count = len(re.findall(r'bboxStrategy', content, re.IGNORECASE))
        
        print(f"bbox matches: {bbox_count}")
        print(f"GetFeature matches: {getfeature_count}")
        print(f"strategy matches: {strategy_count}")
        print(f"bboxStrategy matches: {loading_count}")

        # Look for specific OpenLayers/Leaflet patterns
        if "ol.loadingstrategy.bbox" in content or "loadingstrategy:e.bbox" in content:
            print("Found OpenLayers BBOX strategy")
        
    except Exception as e:
        print(f"Error: {e}")

analyze_js()
