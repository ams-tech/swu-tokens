import pathlib
import json

TARGET_DIR = pathlib.Path(__file__).parent.joinpath("target")


target_dirs = [f for f in TARGET_DIR.iterdir() if f.is_dir()]

targets = []

for t in target_dirs:
    components = [f.name for f in t.iterdir() if f.is_file()]
    targets.append({
        "target": t.name,
        "components": components
    })

manifest = {"include": targets}

print(f"manifest={json.dumps(manifest)}")