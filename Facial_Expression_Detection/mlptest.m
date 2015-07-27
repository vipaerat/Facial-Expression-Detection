function ydash = mlptest(X, w, v)
% forward pass of the network

% number of inputs
N = size(X,1);

% number of outputs
K = size(v,1);
X=[ones(N,1) X];

Z=X*(w');

sigm = 1.0./(1+exp(-1*Z));

z=[ones(N,1) sigm];

temp=z*(v');

softmax = exp(temp);

s=sum(softmax,2);

ydash=softmax./repmat(s,1,K);

end

