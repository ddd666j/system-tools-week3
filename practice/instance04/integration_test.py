from pathlib import Path
import subprocess


command = Path("clean-venv/bin/sdt-greet").resolve()
normal = subprocess.run([command, "--name", "25020007021"], text=True, capture_output=True)
blank = subprocess.run([command, "--name", "   "], text=True, capture_output=True)
print(f"normal_exit={normal.returncode}")
print(f"normal_stdout={normal.stdout.strip()}")
print(f"blank_exit={blank.returncode}")
print(f"blank_stderr_contains_error={'error:' in blank.stderr}")
print(f"blank_stderr_contains_rule={'must not be blank' in blank.stderr}")
assert normal.returncode == 0
assert normal.stdout.strip() == "Hello, 25020007021!"
assert blank.returncode == 2
assert "must not be blank" in blank.stderr
print("integration_contract=passed")

