
import requests
import json

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&outputFormat=json&srsName=EPSG:4326&count=5"

print(f"Testing download from {url}...")
try:
    response = requests.get(url)
    print(f"Status: {response.status_code}")
    print("Content preview:")
    print(response.text[:500])
except Exception as e:
    print(f"Error: {e}")
