function [trainX,trainY] = preprocess(type)

if strcmp(type,'jaffe')~=0
    files = getAllFiles('jaffe_train');
end

if strcmp(type,'cohn')~=0
    files = getAllFiles('cohn_kanade_train');
end

no_files = length(files);

trainX = zeros(no_files,177);
trainY = zeros(no_files,7);

disp('Training_data')
for i=1:no_files
    filename = files{i};
    Im = imread(filename);
    
    hist = featureDetect(Im);
    
    trainX(i,:) = hist;
    
    if strcmp(type,'jaffe')~=0
        trainY(i,str2double(filename(13))+1) = 1;
    else
        trainY(i,str2double(filename(19))+1) = 1;
    end
    i
end

if strcmp(type,'jaffe')~=0
    files = getAllFiles('jaffe_test');
else
    files = getAllFiles('cohn_kanade_test');
end

no_files = length(files);

testX = zeros(no_files,177);
testY = zeros(no_files,7);

disp('Test Data');
for i=1:no_files
    filename = files{i};
    
    Im = imread(filename);
    
    hist = featureDetect(Im);
    
    testX(i,:) = hist;
    
    if strcmp(type,'jaffe')~=0
        testY(i,str2double(filename(12))+1) = 1;
    else
        testY(i,str2double(filename(18))+1) = 1;
    end
    
    i
end

if strcmp(type,'jaffe')~=0
    save('jaffe.mat','trainX','trainY','testX','testY');
else
    save('cohnkanade.mat','trainX','trainY','testX','testY');
end

end