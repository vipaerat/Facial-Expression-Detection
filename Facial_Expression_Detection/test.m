function test()

% load('jaffeparam.mat');
load('cohnparam.mat');

folder = 'sample';
files = getAllFiles(folder);
no_files = length(files);

emotions = {'Neutral','Angry','Disgust','Fear','Happy','Sad','Suprise'};

results = fopen('Results.txt','wt');

for i=1:no_files
    
    filename = files{i};
    Im = imread(filename);
    x = featureDetect(Im);
    y = mlptest(x,w,v);
    
    [~,index]=max(y);
    
    imshow(Im);
    title(emotions{index});
    fprintf('Press enter to continue...\n');
    pause;
    
    fwrite(results,strcat(filename,' - ',emotions{index}));
    fwrite(results,sprintf('\n\n'));
    
end

fclose all;
end

