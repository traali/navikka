
import requests
import json

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=WFS&version=2.0.0&request=GetFeature&typeNames=vesivaylatiedot:rajoitusalue_a_uusi&count=1&outputFormat=json"
print("Fetching URL:", url)
try:
    response = requests.get(url)
    response.raise_for_status() # Check for HTTP errors
    data = response.json()
    print(json.dumps(data, indent=2))
except Exception as e:
    print(f"Error: {e}")
    # Try text if json fails
    try:
        print(response.text[:1000])
    except:
        pass
