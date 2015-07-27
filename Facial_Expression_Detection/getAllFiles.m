% function to return list of all the files in the folder dirName, it
% searches for the files recursively. The fileList is a cell of file paths
% as elements
function fileList = getAllFiles(dirName)
  dirData = dir(dirName);      % Get data for current directory
  dirIndex = [dirData.isdir];  % Find index for directories
  fileList = {dirData(~dirIndex).name}';  % Get a list of the files
  if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(dirName,x),...  % Prepend path to files
                       fileList,'UniformOutput',false);
  end
  subDirs = {dirData(dirIndex).name};  % Get a list of the subdirectories
  validIndex = ~ismember(subDirs,{'.','..'});  % Find index of subdirectories that are not '.' or '..'
  for iDir = find(validIndex)                  % Loop over valid subdirectories
    nextDir = fullfile(dirName,subDirs{iDir});    % Get the subdirectory path
    fileList = [fileList; getAllFiles(nextDir)];  % Recursively call getAllFiles
  end
end