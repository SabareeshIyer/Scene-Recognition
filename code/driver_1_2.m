%driver script

%LINE TO BE REMOVED BEFORE SUBMITTING
%cd 'F:\UB CSE\CSE 573 CVIP\HWs\hw1\hw1\release\code'
%creating filter bank
[filterBank] = createFilterBank();

load('../data/traintest.mat'); 

interval = 1;
imgCount = 10;
%to load training images (change last variable to 'end' to load full set of
%images
imagePaths = train_imagenames(1:interval:imgCount);
imagePaths = (strcat(['../data/'], imagePaths));

%1.1
%convert one image to L*a*b* and apply filters, store image for write-up
I = imread(char(imagePaths(1)));
lab = rgb2lab(I);
I = lab;
for i=1:20
    filtered{i} = imfilter (I, filterBank{i});
    imwrite(filtered{i}, sprintf('F:/imgsForMontage/%d.jpg',i))
end
montDir = 'F:/imgsForMontage/';
extract = '*.jpg';
a = dir ([montDir extract]);
%display = montage (montage(cat(4, filtered{:}), 'Size', [4 5]));
%imshow (display);
%imwrite (display, sprintf('F:/filtersApplied.jpg'));
%1.1 complete


for i=1:imgCount
    imgArray{i} = imread(char(imagePaths(i)));
    lab = rgb2lab(imgArray{i});
    imgArray{i} = lab;
    %model = imagemodel(image (I));    %str = getImageType(model)   
    %if str != 'truecolor'        %L = a = b = I(:,:,1);    
    %reading r, g, b channgels of current image     %r{i} = I(:,:,1);    %g{i} = I(:,:,2);    %b{i} = I(:,:,3);
end

%clear('filtered');
for i = 1:imgCount
    for j = 1:20
        %filtered {i,j} = imfilter (imgArray{i}, filterBank{j}, 'conv', 'replicate');
    end
end


%to display an image - below%imshow(char(imagePaths(1,1)))