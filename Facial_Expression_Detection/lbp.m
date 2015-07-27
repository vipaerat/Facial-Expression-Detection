% result = lbp(I) returns the LBP histogram of the image I

function result = lbp(image) 

d_image=double(image);
radius=1;
neighbours=8;
neighbour_points=zeros(neighbours,2);

% Angle step.
a = 2*pi/neighbours;
for i = 1:neighbours
    neighbour_points(i,1) = -radius*sin((i-1)*a);
    neighbour_points(i,2) = radius*cos((i-1)*a);
end

% Determine the dimensions of the input image.
[m1,n1]=size(image);

miny=min(neighbour_points(:,1));
maxy=max(neighbour_points(:,1));
minx=min(neighbour_points(:,2));
maxx=max(neighbour_points(:,2));

blocksizey=ceil(max(maxy,0))-floor(min(miny,0))+1;
blocksizex=ceil(max(maxx,0))-floor(min(minx,0))+1;

% Coordinates of origin (0,0) in the block
origy=1-floor(min(miny,0));
origx=1-floor(min(minx,0));

% Minimum allowed size for the input image depends
% on the radius of the used LBP operator.
if(n1 < blocksizex || m1 < blocksizey)
    error('Small input image. Must be at least (2*radius+1) x (2*radius+1)');
end

% Calculate dx and dy;
dx = n1 - blocksizex;
dy = m1 - blocksizey;

% Fill the center pixel matrix C.
C = image(origy:origy+dy,origx:origx+dx);
d_C = double(C);

% Initialize the result matrix with zeros.
result=zeros(dy+1,dx+1);

%Computing the LBP code image

for i = 1:neighbours
    y = neighbour_points(i,1)+origy;
    x = neighbour_points(i,2)+origx;
    % Calculate floors, ceils and rounds for the x and y.
    fy = floor(y); cy = ceil(y); ry = round(y);
    fx = floor(x); cx = ceil(x); rx = round(x);
    % Check if interpolation is needed.
    if (abs(x - rx) < 1e-6) && (abs(y - ry) < 1e-6)
        % Interpolation is not needed, use original datatypes
        N = image(ry:ry+dy,rx:rx+dx);
        D = N >= C;
    else
        % Interpolation needed, use double type images
        ty = y - fy;
        tx = x - fx;        
        % Calculate the interpolation weights.
        w1 = roundn((1 - tx) * (1 - ty),-6);
        w2 = roundn(tx * (1 - ty),-6);
        w3 = roundn((1 - tx) * ty,-6) ;
        % w4 = roundn(tx * ty,-6) ;
        w4 = roundn(1 - w1 - w2 - w3, -6);        
        % Compute interpolated pixel values
        N = w1*d_image(fy:fy+dy,fx:fx+dx) + w2*d_image(fy:fy+dy,cx:cx+dx) + w3*d_image(cy:cy+dy,fx:fx+dx) + w4*d_image(cy:cy+dy,cx:cx+dx);
        N = roundn(N,-4);
        D = N >= d_C;
    end
    % Update the result matrix.
    v = 2^(i-1);
    result = result + v*D;
end

load('binvector.mat');
bins = 59;
for i = 1:size(result,1)
    for j = 1:size(result,2)
        result(i,j)=table(result(i,j)+1);
    end
end

% calculating histogram
result=hist(result(:),0:(bins-1));
%result=result/sum(result); % uncomment for normalized histogram

end

function x = roundn(x, n)
if n<0
    p=10 ^ -n;
    x=round(p*x)/p;
elseif n>0
    p=10^n;
    x=p*round(x/p);
else
    x=round(x);
end
end