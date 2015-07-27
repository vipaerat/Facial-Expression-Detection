function [w,v,trainerror] = mlptrain(X, Y, H, eta, nEpochs)
% X - training data of size NxD
% Y - training labels of size NxK
% H - the number of hidden layer neurons
% eta - the learning rate
% nEpochs - the number of training epochs

% number of training data points
N = size(X,1);

% number of inputs
D = size(X,2); % excluding the bias term

% number of outputs
K = size(Y,2);

% weights for the connections between input and hidden layer
% w is a Hx(D+1) matrix
w = -0.3+(0.6)*rand(H,(D+1));

% weights for the connections between input and hidden layer
% v is a Kx(H+1) matrix
v = -0.3+(0.6)*rand(K,(H+1));

iporder = randperm(N);
% mlp training through stochastic gradient descent

for epoch = 1:nEpochs
    
    for n = 1:N
        % forward pass
        % --------------
        Z=w*([1 X(iporder(n),:)]');
        
        sigm= 1.0./(1+exp(-1*Z));
        
        z=[1;sigm];

        softmax=exp(v*z);
        
        ydash=softmax/sum(softmax);
        
        
        % backward pass
        % ---------------
        v=v+eta*(Y(iporder(n),:)'-ydash)*(z');
        
        % ---------
        w=[zeros(1,D+1);w]+eta*...
            (((v')*(Y(iporder(n),:)'-ydash)).*(z.*(ones(H+1,1)-z)))...
            *[1 X(iporder(n),:)];
        
        w=w(2:size(w,1),:);
        % ---------
        
    end
    
    ydash = mlptest(X, w, v);
    
    trainerror(epoch) = sum(sum(-(log(ydash).*Y),2))/N;

    disp(sprintf('training error after epoch %d: %f\n',epoch,...
        trainerror(epoch)));
end

end