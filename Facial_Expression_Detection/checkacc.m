function checkacc( X,Y,W,V,flag )

predicted = mlptest(X,W,V);
n = size(X,1);
accuracy = 0;

for i=1:n
    [~,prindx] = max(predicted(i,:));
    [~,orindx] = max(Y(i,:));
    
    if prindx == orindx
        accuracy = accuracy + 1;
    end
end

accuracy = accuracy/n;

if flag == 1
    fprintf('Test Accuracy - %.2f %%\n',accuracy*100);
else
    fprintf('Train Accuracy - %.2f %%\n',accuracy*100);
end

end

