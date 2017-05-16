function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

y_one_hot = eye(num_labels);
#Theta1: 25*401
#Theta2: 10x26
for i = 1:m,
  yt = y_one_hot(y(i),:);           # yt:1x10
  
  a1 = [1; X(i,:)'];                # a1:401x1
  a2 = [1; sigmoid(Theta1*a1)];     # 25x401 401x1 ==> 25x1 ==> 26x1
  a3 = [sigmoid(Theta2*a2)];        # 10x26  26x1  ==> 10x1 
  J  = J - ((yt*log(a3)) + (1-yt)*log(1-a3))/m;
  
  delta_l3 = a3 - yt';                          # delta_l3(10x1)
  SigGrad  = a2 .* (1-a2);                      # SigGrad 26x1
  delta_l2 = (Theta2'*delta_l3) .* SigGrad;    # Theta2'(26x10) x delta_l3(10x1) => 26x1

  Theta2_grad += (delta_l3 * a2')/m;            # detla_l3'(10x1) a2'(1x26)  ==> 10x26 size of theta2
  Theta1_grad += (delta_l2(2:end) * a1')/m;     # delta_l2(25x1)  a1'(1x401)    ==> 25x401
  
 
end
J = J + lambda * (sum(sumsq(Theta1(:,2:end))) + sum(sumsq(Theta2(:,2:end)))) / (2*m);
Theta2_grad += lambda*[zeros(num_labels,1) Theta2(:,2:end)]/m;
Theta1_grad += lambda*[zeros(hidden_layer_size,1) Theta1(:,2:end)]/m;

 





% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
