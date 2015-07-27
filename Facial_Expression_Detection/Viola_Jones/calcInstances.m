function classify_sum=calcInstances(InImages,Tree,node,scale,x,y,std,area)
%recursive function to remove wrong instances using diffrent classifiers

current= Tree(node+1,:);
sum = zeros(size(x));

% calculatting response for instances
for i = 1:3    
    rectangle = current(:,(1:5)+i*5);
    w = scale* rectangle(:,3);
    h = scale* rectangle(:,4);
    X = x + scale* rectangle(:,1);
    Y = y + scale* rectangle(:,2);    
    sum = sum + sumRectangle(InImages,floor(X),floor(Y),floor(w),floor(h)).*rectangle(:,5);
    % sumRectangle will be used for fast calculation using integral images.
end

sum = sum /area;
%comparing results with threshold and updating variables
flag=sum>=current(:,1).*std;

classify_sum(flag,1)=current(flag,3);
classify_sum(~flag,1)=current(~flag,2);

node(flag,1) =current(flag,5);
node(~flag,1)=current(~flag,4);

if(sum(node>-1)>=1)
    %recursively calling the function
    classify_sum(flag)=calcInstances(InImages,Tree,node(flag),scale,x(flag),y(flag),std(flag),area);
end

end

