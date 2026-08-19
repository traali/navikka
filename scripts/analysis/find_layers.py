import requests
import re
import sys

url = "https://suomenvaylat.vayla.fi/static/js/main.923410e5.js"
try:
    response = requests.get(url)
    content = response.text
    # Search for pattern vesivaylatiedot:someting
    matches = re.findall(r'vesivaylatiedot:[a-zA-Z0-9_]*', content)
    unique_matches = sorted(list(set(matches)))
    print("Found layers:")
    for m in unique_matches:
        print(m)
except Exception as e:
    print(e)
