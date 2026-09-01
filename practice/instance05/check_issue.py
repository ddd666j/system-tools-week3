from pathlib import Path
import sys


path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
required = ["环境", "复现", "期望", "实际", "待确认"]
missing = [field for field in required if field not in text]
print(f"file={path.name}")
print(f"character_count={len(text)}")
print(f"missing_fields={','.join(missing) if missing else 'none'}")
if len(text) > 400 or missing:
    print("quality_gate=failed")
    raise SystemExit(1)
print("quality_gate=passed")

