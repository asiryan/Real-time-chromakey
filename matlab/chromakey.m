%% Real-time chroma key filter
% Fast and accurate chroma key filter based on histogram.
% 
%% Description
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
foreground = 'images/foreground/PANA0702_b.jpg';
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
% R-color fgZ = mat2gray(fgR-fgY);
% G-color fgZ = mat2gray(fgG-fgY);
% B-color fgZ = mat2gray(fgB-fgY);
fgZ = mat2gray(fgG-fgY);
figure(1);
imshow(fgZ);
title('Difference');

%% Processing histogram
rhist = 4;
bins = 256;
histo = hist(fgZ(:),bins);
histo = fastboxfilter(histo,rhist);
threshold1 = getthreshold(histo);

figure(2);
plot(histo);
title('Logarithmic histogram');
grid on;

%% Creating masks
rmask = 4;
mask = (fgZ <= threshold1);
mask = fastboxfilter2d(mask, rmask);

figure(3);
imshow(mask);
title('Foreground object mask');

%% Blending images
final(:,:,1) = blendfunction(fg(:,:,1), bg(:,:,1), mask);
final(:,:,2) = blendfunction(fg(:,:,2), bg(:,:,2), mask);
final(:,:,3) = blendfunction(fg(:,:,3), bg(:,:,3), mask);

figure(4);
imshow(mat2gray(final));
title('Blended image');
disp('Done')