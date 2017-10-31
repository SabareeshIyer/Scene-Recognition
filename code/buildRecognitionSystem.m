function buildRecognitionSystem(wordMapPaths)
% Creates vision.mat. Generates training features for all of the training images.
    fprintf("..In function buildRecognitionSystem()..\n");

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    train_features = buildHistograms(wordMapPaths);
    %size(train_features)


	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end