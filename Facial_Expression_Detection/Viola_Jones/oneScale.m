function [x,y]=oneScale( InImages, TrainData,x, y, scale, w,h)

% area of the window
area=w*h;

%calculating mean and varience of the images
mean=sumRectangle(InImages.ii,x,y,w,h)/area;
var=sumRectangle(InImages.ii2,x,y,w,h)/area - mean.^2;

for i=1:size(var,1)
    if(var(i,1)<1)
        var(i,1)=1;
    end
end

% standard deviation
std=sqrt(var);


maxitr=length(TrainData.stages);
% loop for different classifiers
for i= 1:maxitr
    
    classifiers = TrainData.stages(i).trees;
    sum = zeros(size(x));
    
    for j=1:length(classifiers)
       sum = sum + calcInstances(InImages.ii,classifiers(j).value,zeros(size(x)),scale,x,y,std,area);
    end
    
    % checking for threshold and removing wrong instances
    flag= sum >= TrainData.stages(i).stage_threshold;
    x=x(flag);  
    y=y(flag);
    std=std(flag);
    
    % if no faces left in the image then break
    if(isempty(x))
        break; 
    end

end


end