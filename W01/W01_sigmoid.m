function W01_sigmoid()
  % Octave 4.2.1
  % Author: AlvinYC Chen
  % Date: 2017/03/17
  % Decription: 1. practice Octave 'plot' function(hold/grid/handler...)
  %             2. practice Octave subfunction
  %             3. show curve for activate function 'sigmoid' 
  close all;  clc;
  x   = linspace(-10,10,1000);
  rt  = sigmoid(x);
  plot_sigmoid(x,rt)
end

function rt = sigmoid(x)
  rt = 1.0 ./ (1.0 + exp(-x));
end

function plot_sigmoid(x,y)
  hold on;
  grid on;
  box on;
  plot(x,y,'linewidth',2);
  plot(0,0.5,'marker','square','markersize',10,'color','r');
  axis([x(1) x(end) -0.05 1.05])

  ylabel('sigmoid output','fontsize',12);
  title('activate function SIGMOID','fontsize',15);
  h = legend('sigmoid g(x)= 1 / ( 1 + e^{-x})','location','northwest');
  set(h,'fontsize',14)
  text(0.2,0.45, 'activate threshold 0.5','fontsize',12); 
end  

