import requests
import json

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs"

def describe(typename):
    params = {
        "service": "wfs",
        "version": "2.0.0",
        "request": "DescribeFeatureType",
        "typeName": typename,
        "outputFormat": "application/json"
    }
    try:
        response = requests.get(url, params=params)
        data = response.json()
        print(f"--- {typename} ---")
        for ft in data['featureTypes']:
            for prop in ft['properties']:
                print(f"{prop['name']} ({prop['localType']})")
    except Exception as e:
        print(e)
        print(response.text[:200])

describe("vesivaylatiedot:rajoitusalue_a_uusi")
describe("vesivaylatiedot:vesiliikennemerkit_uusi")
