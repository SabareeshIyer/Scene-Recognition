%driver
%to change working dir, comment out when submitting
%cd 'F:\UB CSE\CSE 573 CVIP\HWs\hw1\hw1\release\code'
%transpose dictionary and change code everywhere accordingly (needed for evaluation)

[filterBank] = createFilterBank();
load('../data/traintest.mat'); 
interval = 1;
imgCount = 10;

%to load training images (change imgCoun/endt value to load all images)
imagePaths = train_imagenames(1:interval:end);
imagePaths = (strcat(['../data/'], imagePaths));

testPaths = test_imagenames(1:interval:end);
%testPaths = (strcat(['../data/'], testPaths)); - redundant

%1.1 - redundant
I = imread(char(imagePaths(1)));
lab = rgb2lab(I);
I = lab;
%filterResponses = extractFilterResponses(I,filterBank);
%1.1 done


%{ 
- redundant
%for applying filters to all images
for i=1:imgCount
    imgArray{i} = imread(char(imagePaths(i)));
    lab = rgb2lab(imgArray{i});
    imgArray{i} = lab;
end
filterResponses = extractFilterResponses(I,filterBank);
%}


%1.2
%imagePaths = (char(imagePaths)); - redundant
[filterBank, dictionary] = getFilterBankAndDictionary(imagePaths);
save('dictionary.mat')
%1.2 done

load('../code/dictionary.mat');

%1.3
%[wordMap] = getVisualWords(imread(char(imagePaths(1))), filterBank, dictionary); - redundant
batchToVisualWords(2);
%save('wordMap.mat') - redundant
%imagesc(wordMap) - redundant
%1.3 done

%2.1
dictionarySize = size(dictionary,1);%300;
%[h] = getImageFeatures(wordMap, dictionarySize);
%2.1 done

%2.2
L = 2;
layerNum = L+1;
%[h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
%bar(h)
%2.2 done

%code to store variable wordMapPaths which has paths to wordMaps like
%imagePaths

load('dictionary.mat');
load('../data/traintest.mat');
wordMapPaths = train_imagenames(1:interval:end);
wordMapPaths = (strcat(['../data/'], wordMapPaths));
expression = '.jpg$';
replace = '.mat';    
wordMapPaths = regexprep(wordMapPaths, expression, replace);
save('wordMapPaths')



%2.3
%[histograms] = buildHistograms(wordMapPaths);
%load('histograms');
% - redundant
for i = 1:1 %length(testPaths)
    %[wordMap] = getVisualWords(imread(char(strcat(['../data/'],testPaths(i)))), filterBank, dictionary);
    %[wordHist] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
    %[histInter] = distanceToSet(wordHist, histograms);
end
%2.3 done (for one image - can use for any number of images, change loop length above)    

%2.4
%buildRecognitionSystem(wordMapPaths);
for i = 1:12
    %tPath = strcat(['F:/UB CSE/CSE 573 CVIP/HWs/hw1/hw1/release/data/'],testPaths(i));
    %guessImage(char(tPath));
    %guessImage('F:/UB CSE/CSE 573 CVIP/HWs/hw1/hw1/release/data/art_gallery/sun_avotltgulsjcbbtl.jpg')
    % - redundant^
end
%2.4 done

%2.5
[conf]  = evaluateRecognitionSystem();
conf
accuracy = trace(conf) / sum(conf(:))
%2.5 done but unacceptable accuracy