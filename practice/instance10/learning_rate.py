import math
import torch
from torch import nn
def run(lr):
 torch.manual_seed(20260907);x=torch.linspace(-1,1,101).reshape(-1,1);y=3*x-1;m=nn.Linear(1,1);o=torch.optim.SGD(m.parameters(),lr=lr);f=nn.MSELoss();trace=[]
 for i in range(100):
  o.zero_grad();loss=f(m(x),y);loss.backward();o.step()
  if i in (0,9,99): trace.append(loss.item())
 return trace
good=run(.1);bad=run(2.0)
unstable = not math.isfinite(bad[-1]) or bad[-1] > good[-1]
print("lr_0.1_trace=",good);print("lr_2.0_trace=",bad);print("stable_convergence=",good[-1]<.001);print("large_lr_unstable=",unstable);assert good[-1]<.001 and unstable
