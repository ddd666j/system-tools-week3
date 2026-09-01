from pathlib import Path
from zipfile import ZipFile


wheel = next(Path("../../q09/dist").glob("*.whl"))
with ZipFile(wheel) as archive:
    names = sorted(archive.namelist())
    metadata_name = next(name for name in names if name.endswith(".dist-info/METADATA"))
    entry_name = next(name for name in names if name.endswith(".dist-info/entry_points.txt"))
    metadata = archive.read(metadata_name).decode()
    entry_points = archive.read(entry_name).decode()

required = ["Name: greetlab-25020007021", "Version: 0.1.0"]
assert all(item in metadata for item in required)
assert "sdt-greet = greetlab.cli:main" in entry_points
assert "greetlab/cli.py" in names
print(f"wheel={wheel.name}")
print(f"file_count={len(names)}")
print("metadata_ok=True")
print("entry_point_ok=True")
print("package_code_ok=True")

