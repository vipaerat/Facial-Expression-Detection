function images = integralImage(img)
% this function will be used for fast calculations using integral images
img=im2double(img);

if(size(img,3)==3)
    img=rgb2gray(img);
end

images.ii=img;
% for fast calculating mean
for i=2:size(images.ii,1)
    images.ii(i,:)=images.ii(i,:)+images.ii(i-1,:);
end

for i=2:size(images.ii,2)
    images.ii(:,i)=images.ii(:,i)+images.ii(:,i-1);
end
images.ii=padarray(images.ii,[1 1],0,'pre');


images.ii2=img.^2;
% for fast calculatting variance
for i=2:size(images.ii2,1)
    images.ii2(i,:)=images.ii2(i,:)+images.ii2(i-1,:);
end

for i=2:size(images.ii2,2)
    images.ii2(:,i)=images.ii2(:,i)+images.ii2(:,i-1);
end
images.ii2=padarray(images.ii2,[1 1],0,'pre');

images.width = size(img,2);
images.height = size(img,1);

end

