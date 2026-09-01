from base64 import urlsafe_b64decode
from hashlib import sha256
from pathlib import Path
from zipfile import ZipFile
import csv, io
w=next(Path("../../q09/dist").glob("*.whl"))
with ZipFile(w) as z:
 r=next(n for n in z.namelist() if n.endswith("RECORD")); rows=list(csv.reader(io.StringIO(z.read(r).decode())))
 checked=0
 for name,digest,size in rows:
  if not digest: continue
  actual=sha256(z.read(name)).digest(); expected=urlsafe_b64decode(digest.split("=",1)[1]+"==")
  assert actual==expected and len(z.read(name))==int(size); checked+=1
print(f"wheel={w.name}\nrecord_rows={len(rows)}\nverified_hashes={checked}\nrecord_integrity=passed")
