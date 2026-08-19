
import json
from collections import Counter

try:
    with open('scripts/analysis/speed_signs_found.txt', 'r', encoding='utf-8') as f:
        lines = f.readlines()

    signs = [json.loads(l) for l in lines if l.strip().startswith('{')]
    
    with open('scripts/analysis/sea_signs_summary.txt', 'w', encoding='utf-8') as out:
        out.write(f"Total Signs Processed: {len(signs)}\n")
        
        has_val = [s for s in signs if s.get('rajoitusarvo') is not None]
        out.write(f"Signs with rajoitusarvo: {len(has_val)}\n")
        
        names = Counter([s.get('nimifi', 'None') for s in signs])
        out.write("\nTop Names:\n")
        for n, c in names.most_common(5):
            out.write(f"{n}: {c}\n")
            
        types = Counter([s.get('vlmtyyppi', 'None') for s in signs])
        out.write("\nTop vlmtyyppi:\n")
        for t, c in types.most_common(5):
            out.write(f"{t}: {c}\n")

except Exception as e:
    print(e)
