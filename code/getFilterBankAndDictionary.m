function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    K = 300;
    alpha = 200;
    responseArray = double.empty(0,60);
    for i = 1:length(imPaths)
        fprintf("Reading image %d\n", i);
        curImg = (imread(char(imPaths(i))));
        %checking for grayscale
        [~,~,dim] = size(curImg);
        if(dim == 1)
            curImg = repmat(curImg, [1 1 3]);
        end
        curImg = rgb2lab(curImg);
        
        %to create partial images that contain only alpha pixels of the
        %original image
        num = numel(curImg(:,:,1));
        chosenPixels = randperm(num, alpha); 
        [a,b,~] = size(curImg);
        [x,y] = ind2sub([a b], chosenPixels);
        
        for k = 1:alpha
            partialImg(k,1,:) = curImg(x(k),y(k),:);
        end
        
        size(partialImg);
        
        filtered = (extractFilterResponses(partialImg, filterBank));
        size(filtered);
        filtered = (reshape (filtered, [], 60));
        size(filtered);
        responseArray = vertcat(responseArray, filtered);
    end
    size(responseArray);
    fprintf("Applying kmeans");
    [~,dictionary] = kmeans(responseArray, K);
end
