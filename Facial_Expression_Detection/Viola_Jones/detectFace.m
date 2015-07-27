function faces= detectFace(InImages,TrainData)

% calculating scales for face detection
scaleWidth = InImages.width/TrainData.size(1);
scaleHeight = InImages.height/TrainData.size(2);

if(scaleHeight < scaleWidth )
    Startscale =  scaleHeight;
else
    Startscale = scaleWidth;
end

scaleUpdateRatio = 1/1.2;

% Calculate maximum of search scale itterations
maxitr=ceil(log(1/Startscale)/log(scaleUpdateRatio));

faces = [];

for i=1:maxitr
    scale = Startscale*scaleUpdateRatio^(i-1);
    
    %width and height of window
    w = floor(TrainData.size(1)*scale);
    h = floor(TrainData.size(2)*scale);
    
    stepsize = floor(max( scale, 2 ));
    [x,y]=ndgrid(0:stepsize:(InImages.width-w-1),0:stepsize:(InImages.height-h-1));
    x=x(:); y=y(:);
    
    if(~isempty(x))
        % coordinates of detected faces
        [x,y] = oneScale( InImages, TrainData, x, y, scale, w, h);
       
        % saving cordinates of detcted faces
        for k=1:length(x);
            faces = [faces;[x(k) y(k) w h]];
        end
        
        %     breaking when one face is detected
        
        %     if ~isempty(x) && ~isempty(y)
        %         break;
        %     end
        
    end
end
