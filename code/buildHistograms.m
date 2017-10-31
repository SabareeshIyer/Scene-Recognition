function [histograms] = buildHistograms(wordMapPaths)
% Creates vision.mat. Generates training features for all of the training images.
    %load('dictionary.mat');
    %load('../data/traintest.mat');
    fprintf("..In function buildHistograms()..");
    load('dictionary');
    dictionarySize = size(dictionary,1);%300;
    h = waitbar(0,'Please wait...');
    len = length(wordMapPaths);
    %histograms = zeros(len,6300);
    %size(histograms)
    histograms = cell.empty()
    for i = 1:len
        S = load((wordMapPaths{i}));
        C = struct2cell(S);
        
        rix = cell2mat(C);
        histograms{i} = getImageFeaturesSPM(2, rix, dictionarySize);
        waitbar(i / len)
        fprintf('Running on image %d\n', i);
    end
    close(h);
    
    histograms = cell2mat(histograms);

    save ('histograms');
    %load('histograms');
	%save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end