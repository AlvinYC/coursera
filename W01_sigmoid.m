function W01_sigmoid()
  % Octave 4.2.1
  % Author: AlvinYC Chen
  % Date: 2017/03/17
  % Decription: 1. practice Octave 'plot' function(hold/grid/label/title/text)
  %             2. practice Octave subfunction
  %             3. show neural network activat function 'sigmoid'
  close all;  clc;
  x = linspace(-10,10,1000);
  rt = sigmoid(x);

  hold on;
  grid on;
  plot(x,rt,'linewidth',2);
  plot(0,0.5,'marker','square','markersize',10,'color','r');
  ylim([-0.05 1.05]);
  ylabel('sigmoid output');
  title('activate function SIGMOID','fontsize',15);
  text(0.2,0.45, 'activate threshold 0.5');
end

function rt = sigmoid(x)
  rt = 1.0 ./ (1.0 + exp(-x));
end

