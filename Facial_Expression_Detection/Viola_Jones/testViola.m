function testViola(img)
img = imread(img);

[x1 y1 height width]=violaJones(img);

x2=x1+width;
y2=y1+height;

figure;
imshow(img);
hold on;
plot([x1 x1 x2 x2 x1],[y1 y2 y2 y1 y1]);
hold off;

end
  
