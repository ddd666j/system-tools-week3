import sys

import pytest

from greetlab import cli


def test_blank_name_exits_with_code_2(monkeypatch):
    monkeypatch.setattr(sys, "argv", ["sdt-greet", "--name", "   "])
    with pytest.raises(SystemExit) as exc_info:
        cli.main()
    assert exc_info.value.code == 2

