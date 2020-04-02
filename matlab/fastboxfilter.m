%% Real-time chroma key filter
% One-dimensional box filter.
% 
%% Input data
% input - one-dimensional array,
% r - radius.
%% Output data
% output - one-dimensional array.
function [ output ] = fastboxfilter( input, r )
% params
l = length(input);
output = zeros(1, l);
v = fix(r./2);
dl = l - v;

% box filter
s = sum(input(1,1:r));
output(1,1:v)=s./r;
for i=v+1:dl
    s=s-output(1,i-v)+input(1,i+v);
    output(1,i)=s./r;
end
for i=dl:l
    s=s-output(1,i-v)+input(1,i);
    output(1,i)=s./r;
end
end