function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    %checking for grayscale
	[h,w,dim] = size(img);
	if(dim == 1)
        img= repmat(img, [1 1 3]);
    end
    
    x = extractFilterResponses(img, filterBank);
    x = reshape(x, [], 60);
    dist = pdist2(x, dictionary);
    minD = min(dist, [], 2);
    wordMap = reshape(minD, h, w);
    %figure, imagesc(wordMap)
end
