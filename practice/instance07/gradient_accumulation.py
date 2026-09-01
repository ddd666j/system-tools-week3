import torch
from torch import nn

torch.manual_seed(20260907)
x=torch.tensor([[1.0]]); y=torch.tensor([[3.0]])
model=nn.Linear(1,1,bias=False); loss_fn=nn.MSELoss()
loss_fn(model(x),y).backward(); first=model.weight.grad.item()
loss_fn(model(x),y).backward(); accumulated=model.weight.grad.item()
model.zero_grad(); loss_fn(model(x),y).backward(); cleared=model.weight.grad.item()
print(f"first_gradient={first:.6f}")
print(f"without_zero_grad={accumulated:.6f}")
print(f"after_zero_grad={cleared:.6f}")
print(f"accumulation_ratio={accumulated/first:.2f}")
assert abs(accumulated-2*first)<1e-6 and abs(cleared-first)<1e-6
print("gradient_semantics=passed")

