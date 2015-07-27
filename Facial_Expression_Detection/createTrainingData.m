% this code creates the Training_data folder which contains the expression
% categorised files in respective folders from extended cohn-kanade and jaffe
% databases
% For extended cohn-kanade database, make sure Emotion_labels and
% extended-cohn-kanade-images folder are in the same directory
% For jaffe database, jaffeimages folder must be in the same directory

mkdir('Training_data\0');
mkdir('Training_data\1');
mkdir('Training_data\2');
mkdir('Training_data\3');
mkdir('Training_data\4');
mkdir('Training_data\5');
mkdir('Training_data\6');
mkdir('Training_data\7');

% code for adding cohn-kanade files
emotion_files=getAllFiles('Emotion_labels');
for i=1:size(emotion_files)
    file_path=emotion_files{i};
    file_name=file_path(23:49);
    peak_image_path=strcat('extended-cohn-kanade-images\cohn-kanade-images',file_name,'.png');
    neutral_image_path=strcat('extended-cohn-kanade-images\cohn-kanade-images',file_name(1:19),'00000001.png');
    fileID=fopen(file_path,'r');
    emotion=fscanf(fileID,'%d');
    fclose(fileID);
    
    I = imread(peak_image_path);
    %     bboxes = step(facedetector,I);
    %
    %     IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
    %     bboxes=bboxes(1,:);
    %     cropI = imcrop(IFaces,bboxes);
    %     clear bboxes;
    %     cropI = rgb2gray(imresize(cropI,[30 30]));
    
    emotion=int2str(emotion);
    f=strcat('Training_data\',emotion,'\',file_name(11:27),'.png');
    fid=fopen(f,'w+');
    imwrite(I,f);
    fclose(fid);
    
    %adding the neutral image
    I = imread(neutral_image_path);
    f=strcat('Training_data\0\',neutral_image_path(57:77));
    fid=fopen(f,'w+');
    imwrite(I,f);
    fclose(fid);
end

%Code for adding jaffe database images to the training set

image_files=getAllFiles('jaffeimages/jaffe/');

for i=1:size(image_files)
    file_path=image_files{i};
    if file_path(size(file_path,2)-3:size(file_path,2))=='tiff'
        emotion=file_path(22:23);
        switch emotion
            case 'NE'
                emotion='0';
            case 'AN'
                emotion='1';
            case 'DI'
                emotion='3';
            case 'FE'
                emotion='4';
            case 'HA'
                emotion='5';
            case 'SA'
                emotion='6';
            case 'SU'
                emotion='7';
            otherwise
                'error'
        end
        I = imread(file_path);
        f=strcat('Training_data\',emotion,'\',file_path(19:size(file_path,2)));
        fid=fopen(f,'w+');
        imwrite(I,f);
        fclose(fid);
        
    end
end
