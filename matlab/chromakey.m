%% Real-time chroma key filter
% Accurate real-time histogram based chroma key filter.
% 
% The aim of this code example is to extract the green background, also 
% called chroma key, and replace it with the background from a different 
% image. In fact what we're doing is keying out a black and white mask 
% from the green component of the foreground image and using it to mask 
% any other background image.
% 
%% Set params
close all;
clear all;
background = 'images/background/PANA0701_a.jpg';
foreground = 'images/foreground/PANA0701_b.jpg';
threshold1 = 150/255;   % object threshold
threshold2 = 200/255;   % shadow threshold
radius1 = 4;            % object blur radius
radius2 = 120;          % shadow blur radius
disp('Chromakeing')

%% Calculating matrices
bg = double(imread(background));
fg = double(imread(foreground));
fgR = fg(:,:,1); % red   channel
fgG = fg(:,:,2); % green channel
fgB = fg(:,:,3); % blue  channel

%% Grayscale model
% PAL/NTC fgY = 0.299 * fgR + 0.587 * fgG + 0.114 * fgB;
% AVG     fgY = 0.333 * fgR + 0.333 * fgG + 0.333 * fgB;
% HDTV    fgY = 0.213 * fgR + 0.715 * fgG + 0.072 * fgB;
% RYY     fgY = 0.500 * fgR + 0.419 * fgG + 0.081 * fgB;
fgY = 0.299 * fgR + 0.587 * fgG + 0.114 * fgB;
fgG_Y = mat2gray(fgG-fgY);

%% Plotting histogram
figure(1);
histo = hist(fgG_Y(:), 256);
plot([0:255], histo);
title('Histogram');
grid on;

%% Creating masks
% Applying thresholds
mask1 =                         (fgG_Y <= threshold1);
mask2 = (threshold1 <= fgG_Y) & (fgG_Y <= threshold2);
% Applying box blur
mask1 = fastboxfilter2d(mask1, radius1);
mask2 = fastboxfilter2d(mask2, radius2);
% Applying MATLAB box filter
% mask1 = imfilter(double(mask1), fspecial('average', [radius1, radius1]));
 %mask2 = imfilter(double(mask2), fspecial('average', [radius2, radius2]));

figure(2);
imshow(mask1);
title('Foreground object mask');

figure(3);
imshow(mask2);
title('Foreground shadow mask');

%% Blending images
final(:,:,1)=fg(:,:,1).*mask1 + bg(:,:,1).*(1-mask1).*(mask2)*0.5 + bg(:,:,1).*(1-mask1).*(1-mask2);
final(:,:,2)=fg(:,:,2).*mask1 + bg(:,:,2).*(1-mask1).*(mask2)*0.5 + bg(:,:,2).*(1-mask1).*(1-mask2);
final(:,:,3)=fg(:,:,3).*mask1 + bg(:,:,3).*(1-mask1).*(mask2)*0.5 + bg(:,:,3).*(1-mask1).*(1-mask2);

figure(4);
imshow(mat2gray(final));
title('Blended image');
disp('Done')