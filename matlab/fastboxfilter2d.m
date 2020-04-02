%% Real-time chroma key filter
% Two-dimensional box filter.
% 
%% Input data
% input - two-dimensional array,
% r - radius.
%% Output data
% output - two-dimensional array.
function [ output ] = fastboxfilter2d( input, r )
% params
h = size(input,1);
w = size(input,2);
output = zeros(h,w);
row = zeros(1,w);
col = zeros(1,h);

% applying to rows
for i=1:h
    for j=1:w
        row(1,j)=input(i,j);
    end
    output(i,:)=fastboxfilter(row, r);
end

% applying to columns
for i=1:w
    for j=1:h
        col(1,j)=output(j,i);
    end
    output(:,i)=fastboxfilter(col, r);
end
end