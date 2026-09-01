import torch
from torch import nn


torch.manual_seed(20260907)
x = torch.linspace(-1, 1, 101).reshape(-1, 1)
y = 3 * x - 1
model = nn.Linear(1, 1)
loss_fn = nn.MSELoss()
opt = torch.optim.SGD(model.parameters(), lr=0.1)

model.train()
for _ in range(200):
    pred = model(x)
    loss = loss_fn(pred, y)
    opt.zero_grad()
    loss.backward()
    opt.step()

model.eval()
with torch.no_grad():
    final_loss = loss_fn(model(x), y).item()
    weight = model.weight.item()
    bias = model.bias.item()
    print(f"final_loss={final_loss:.10f}")
    print(f"weight={weight:.6f}")
    print(f"bias={bias:.6f}")

if final_loss >= 0.001:
    raise SystemExit("final loss did not meet the requirement")

