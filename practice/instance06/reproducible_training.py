import torch
from torch import nn


def train(seed: int) -> tuple[float, float, float]:
    torch.manual_seed(seed)
    x = torch.linspace(-1, 1, 101).reshape(-1, 1)
    y = 3 * x - 1
    model = nn.Linear(1, 1)
    loss_fn = nn.MSELoss()
    opt = torch.optim.SGD(model.parameters(), lr=0.1)
    for _ in range(200):
        opt.zero_grad()
        loss = loss_fn(model(x), y)
        loss.backward()
        opt.step()
    model.eval()
    with torch.no_grad():
        final_loss = loss_fn(model(x), y).item()
        return final_loss, model.weight.item(), model.bias.item()


first = train(20260907)
second = train(20260907)
third = train(7)
print("seed_20260907_run1=", tuple(f"{x:.10f}" for x in first))
print("seed_20260907_run2=", tuple(f"{x:.10f}" for x in second))
print("seed_7_run=", tuple(f"{x:.10f}" for x in third))
print(f"same_seed_identical={first == second}")
print(f"all_losses_below_0.001={all(result[0] < 0.001 for result in (first, second, third))}")
assert first == second
assert all(result[0] < 0.001 for result in (first, second, third))
print("reproducibility_verification=passed")

