
import json
from collections import Counter
import sys

sys.stdout.reconfigure(encoding='utf-8')

try:
    with open('scripts/analysis/speed_signs_found.txt', 'r', encoding='utf-8') as f:
        lines = f.readlines()

    signs = [json.loads(l) for l in lines if l.strip().startswith('{')]
    
    with open('scripts/analysis/sea_signs_summary_v2.txt', 'w', encoding='utf-8') as out:
        out.write(f"Total Signs: {len(signs)}\n")
        
        # Check keys of first item
        if signs:
            out.write(f"\nKeys: {list(signs[0].keys())}\n")

        lajis = Counter([str(s.get('lajifi', 'None')) for s in signs])
        out.write("\nTop Lajifi:\n")
        for k, v in lajis.most_common(10):
            out.write(f"{k}: {v}\n")

        vals = Counter([str(s.get('rajoitusarvo', 'None')) for s in signs])
        out.write("\nValues:\n")
        for k, v in vals.most_common(10):
            out.write(f"{k}: {v}\n")

except Exception as e:
    print(e)
