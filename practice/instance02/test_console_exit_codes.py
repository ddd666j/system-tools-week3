from pathlib import Path
import subprocess


command = Path("../../q09/clean-venv/bin/sdt-greet").resolve()
normal = subprocess.run([command, "--name", "25020007021"], text=True, capture_output=True)
blank = subprocess.run([command, "--name", "   "], text=True, capture_output=True)

print(f"normal_exit={normal.returncode}")
print(f"normal_stdout={normal.stdout.strip()}")
print(f"blank_exit_before_fix={blank.returncode}")
print(f"blank_stdout_before_fix={blank.stdout.strip()}")
assert normal.returncode == 0
assert normal.stdout.strip() == "Hello, 25020007021!"
assert blank.returncode == 0
print("baseline_behavior_confirmed=True")

