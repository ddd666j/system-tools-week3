核心提示：空白name必须触发SystemExit(2)，仅修改输入校验，并运行pytest。
智能体改动：在解析参数后使用strip检查，并调用parser.error。
测试命令：../.venv-dev/bin/python -m pytest -q。
人工检查：diff只含必要校验，无无关修改；再次测试通过。

