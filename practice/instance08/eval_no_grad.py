import torch
from torch import nn

torch.manual_seed(20260907)
model=nn.Sequential(nn.Linear(4,4),nn.Dropout(p=0.5),nn.Linear(4,1)); x=torch.ones(1,4)
model.train(); train_a=model(x); train_b=model(x)
model.eval()
with torch.no_grad(): eval_a=model(x); eval_b=model(x)
print(f"train_outputs_equal={torch.equal(train_a,train_b)}")
print(f"eval_outputs_equal={torch.equal(eval_a,eval_b)}")
print(f"eval_requires_grad={eval_a.requires_grad}")
print(f"model_training_flag={model.training}")
assert not torch.equal(train_a,train_b)
assert torch.equal(eval_a,eval_b) and not eval_a.requires_grad and not model.training
print("evaluation_contract=passed")

