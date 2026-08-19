
import requests
import xml.etree.ElementTree as ET

url = "https://avoinapi.vaylapilvi.fi/vaylatiedot/ows?service=wfs&request=getCapabilities"
response = requests.get(url)
root = ET.fromstring(response.content)

# Namespace map (might need adjustment based on valid XML)
namespaces = {
    'wfs': 'http://www.opengis.net/wfs/2.0',
    'ows': 'http://www.opengis.net/ows/1.1',
    'fes': 'http://www.opengis.net/fes/2.0'
}

# Usually FeatureTypeList is in wfs:FeatureTypeList
# Iterate over all elements to find FeatureType -> Name
for elem in root.iter():
    if 'FeatureType' in elem.tag:
        for child in elem:
            if 'Name' in child.tag:
                print(child.text)
