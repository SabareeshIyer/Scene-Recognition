function histInter = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) − 1 / 3) × 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) − 1 / 3) × T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 × T vector

    [r, c] = size(histograms);
	for j = 1: c
       histInter(1, j) = sum(bsxfun(@min, wordHist, histograms(:,j)));
    end
	%max(histInter)
    
    
end