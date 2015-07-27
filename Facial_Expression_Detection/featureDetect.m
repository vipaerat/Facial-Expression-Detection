function [ lbpHist ] = featureDetect( Im )

addpath('Viola_Jones');

[X,Y,height,width] = violaJones(Im);
cropI = imcrop(Im,[X,Y,height,width]);

cropI = imresize(cropI,[40,40]);

I1 = cropI(10:20,10:30);
I2 = cropI(20:30,10:30);
I3 = cropI(30:40,10:30);

lbpHist1 = lbp(I1);
lbpHist2 = lbp(I2);
lbpHist3 = lbp(I3);

lbpHist = [lbpHist1,lbpHist2,lbpHist3];

end

