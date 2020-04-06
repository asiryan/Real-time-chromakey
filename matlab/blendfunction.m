%% Real-time chroma key filter
% Returns blended pixel.
% 
%% Input data
% a - foreground,
% b - background,
% m - mask.
%% Output data
% z - blended.
function [ z ] = blendfunction(a, b, m)
z = a.*m + b.*(1 - m);
end

