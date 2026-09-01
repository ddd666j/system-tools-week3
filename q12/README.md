# 第12题：修复可复现的线性回归训练循环

固定随机种子，在CPU上训练`nn.Linear`。每轮依次执行`zero_grad`、`backward`和`step`；训练后切换`eval`并在`no_grad`中计算损失、weight和bias。脚本验证最终损失小于0.001，参数由训练得到而非直接赋值。
