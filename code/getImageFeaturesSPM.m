function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    [height,w] = size(wordMap);
    
    %level 0
    hLev0 = getImageFeatures(wordMap, dictionarySize);
    hLev0 = 0.25 * hLev0;
    
    %level 1
    h4m = fix(height/2);
    w4m = fix(w/2);
    h5m = height - h4m;
    w5m = w - w4m;
    M = [h4m, h5m];
    N = [w4m, w5m];
    
    C = mat2cell (wordMap, M, N);    
    hLev1 = double.empty;
    
    for i = 1:2
        for j = 1:2
            hLev_1_primary{i,j} = getImageFeatures(C{i,j}, dictionarySize);
            hLev1 = cat(1,hLev1,hLev_1_primary{i,j});
        end
    end
    hLev1 = 0.25 * hLev1;
    
    
    %level 2
    newH = fix(height/4);
    hRem = height - 3*newH;
    newW = fix(w/4);
    wRem = w - 3*newW;
    M = [newH, newH, newH, hRem];
    N = [newW, newW, newW, wRem];
    C = mat2cell (wordMap, M, N);
    hLev2 = double.empty;
    
    %computing histograms for 16 matrices at level 2
    for i = 1:4
        for j = 1:4
            hLev_2_primary{i,j} = getImageFeatures(C{i,j}, dictionarySize);
            hLev2 = cat(1,hLev2,hLev_2_primary{i,j});
        end
    end
    hLev2 = 0.5 * hLev2;
    %level 2 done
    
    %{
    %level 1 - combining  histograms of 4 adjacent matrices at a time from 
    %          result of level 2 (4 assignment statements in the loop) and
    %          concatenating them in the last line of the loop
    k = 0;
    hLev1 = double.empty;
    for i = 1,3
        for j = 1,3
            k = k + 1;
            hLev_1_primary{k} = hLev_2_primary{i,j};
            hLev_1_primary{k} = cat(1,hLev_1_primary{k},hLev_2_primary{i,j+1});
            hLev_1_primary{k} = cat(1,hLev_1_primary{k},hLev_2_primary{i+1,j});
            hLev_1_primary{k} = cat(1,hLev_1_primary{k},hLev_2_primary{i+1,j+1});
            hLev1 = cat(1,hLev1,hLev_1_primary{k});
        end
    end
    hLev1 = 0.25 * hLev1;
    %level 1 done
    
    %level 0 - combining histograms of level 1
    hLev0 = double.empty;
    hLev0 = cat(1, hLev0, hLev_1_primary{1});
    hLev0 = cat(1, hLev0, hLev_1_primary{2});
    hLev0 = cat(1, hLev0, hLev_1_primary{3});
    hLev0 = cat(1, hLev0, hLev_1_primary{4});
    hLev0 = 0.25 * hLev0;
    %level 0 done
    %}
    
    h = double.empty;
    h = cat(1, h, hLev0);
    h = cat(1, h, hLev1);
    h = cat (1, h,hLev2);
    h = h/sum(h);
    %sum(h) gives 1
    %bar(h);
end