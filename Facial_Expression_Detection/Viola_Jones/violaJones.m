function [X,Y,height,width] = violaJones(img)
% This function performs face detection using viola-jones

load('TrainData.mat')

faces = detectFace(integralImage(img),TrainData);

% [height,b] = min(Objects(:,4));
% X = Objects(b,1);
% Y =  Objects(b,2);
% width = Objects(b,4);
% dwidth = 0.1*width;
% X = X + 0.5*dwidth;
% Y = Y + 0.5*dwidth;
% width=width-dwidth;

% Taking average of faces
X = mean(faces(:,1));
Y = mean(faces(:,2));
height = mean(faces(:,3));
width = mean(faces(:,4));
dwidth = 0.25*width;
width = width - dwidth;
X = X + 0.5*dwidth;

dheight = 0.175*height;
height = height - dheight - 0.05*height;
Y = Y + dheight;

end




