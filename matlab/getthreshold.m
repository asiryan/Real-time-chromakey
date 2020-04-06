%% Real-time chroma key filter
% Returns threshold value.
% 
%% Input data
% input - two-dimensional array,
% r - radius.
%% Output data
% output - two-dimensional array.
function [ threshold ] = getthreshold( array )
% params
n = length(array);
z = floor(n/2);

% split histogram
left = array(1:z);
right = array(z:n);
% calculate maximums
[~, index1] = max(left);
[~, index2] = max(right);
index2 = z + index2;
disp('Left point: ' + string(index1));
disp('Right point: ' + string(index2));

% cut histogram
center = array(index1:index2);
[~, threshold] = min(center);
threshold = index1 + threshold - 1;
disp('Threshold: ' + string(threshold))
threshold = threshold./(n-1);
disp('Normalized threshold: ' + string(threshold));
end