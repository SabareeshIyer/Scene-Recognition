function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    testPaths = test_imagenames(1:end);
    tLabels = test_labels(1:end);
    
    conf = zeros(8,8);
    miniMap = containers.Map;
    for i = 1:8
        miniMap(mapping{i}) = i;
    end
    for i = 1:length(testPaths)
        tPath = strcat(['F:/UB CSE/CSE 573 CVIP/HWs/hw1/hw1/release/data/'],testPaths(i));
        g = guessImage(char(tPath));
        g = miniMap(g);
        x = conf(g,tLabels(i)) + 1;
        conf(g,tLabels(i)) = x;
        fprintf("On image %d\n",i);
    end
    
end