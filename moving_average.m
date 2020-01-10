function [x] = moving_average(x,aa)

n= length(x);
del = (aa-1)/2;


for i = del+1 : n-del
    
x(i)  =  mean( x(i-del  : i+del)  ) ;   
end
