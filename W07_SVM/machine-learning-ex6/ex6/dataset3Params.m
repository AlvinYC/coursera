function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
candi_C      = [0.01 0.03 0.1 0.3   1   3  10  30];
candi_sigma  = [0.1  0.2  0.3 0.4 0.5 0.6 0.7 0.8 0.9];

[p,q]        = meshgrid(candi_C,candi_sigma);
C_sigma_pair = [p(:) q(:)];

for i=1:size(C_sigma_pair,1),
  candi_C     = C_sigma_pair(i,1);
  candi_sigma = C_sigma_pair(i,2);
  
  model= svmTrain(X, y, candi_C, @(x1, x2) gaussianKernel(x1, x2, candi_sigma)); 
  predictions  = svmPredict(model, Xval);
  predacc(i)   = mean(double(predictions ~= yval));
end

[best_mode_val,best_mode_idx] = min(predacc);
C     = C_sigma_pair(best_mode_idx,1);
sigma = C_sigma_pair(best_mode_idx,2);
    





% =========================================================================

end
