import requests

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs"
params = {
    "service": "wfs",
    "version": "2.0.0",
    "request": "DescribeFeatureType",
    "typeName": "vesivaylatiedot:rajoitusalue_a_uusi",
    "outputFormat": "application/json" # Request JSON if possible, otherwise XML
}

try:
    response = requests.get(url, params=params)
    print(response.text)
except Exception as e:
    print(e)
