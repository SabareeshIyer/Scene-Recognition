function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

%[filterBank] = createFilterBank();
%{
load('../data/traintest.mat'); 

%to load training images (change imgCount value to load all images)
imagePaths = train_imagenames(1:interval:imgCount);
imagePaths = (strcat(['../data/'], imagePaths));

I = imread(char(imagePaths(1)));
lab = rgb2lab(I);
I = lab;
%}

for i=1:20
    for j = 1:3
        filterResponses(:,:,j*i) = imfilter (img(:,:,j), filterBank{i}, 'conv');
    end
    %imwrite(filtered{i}, sprintf('F:/imgsForMontage/%d.jpg',i))    
end
%filterResponses = reshape(x, 1, []);

%{
montDir = 'F:/imgsForMontage/';
extract = '*.jpg';
a = dir ([montDir extract]);
display = montage (montage(cat(4, filtered{:}), 'Size', [4 5]));
imshow (display);
%imwrite (display, sprintf('F:/filtersApplied.jpg'));
%}

end
