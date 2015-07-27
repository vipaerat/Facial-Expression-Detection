function sum= sumRectangle(InImage,x,y,w,h)

width=size(InImage,1);
a = InImage((x+w)* width+ y+ h+ 1) ;
b = InImage(x* width+ y+ 1);
c = InImage((x+w)* width+ y+ 1);
d = InImage(x* width+ y+ h+ 1);

sum=a+b-c-d;

end