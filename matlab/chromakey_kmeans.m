%% Real-time chroma key filter
% Chroma key filter based on k-means clustering.
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
background = 'images/background/PANA0701_a.jpg'; % foreground image,
foreground = 'images/foreground/PANA0701_b.jpg'; % background image,
rmask      = 4;                                  % mask radius,
iterations = 4;                                  % number of iterations.
disp('Chromakeing')

%% Calculating matrices
bg = double(imread(background));
fg = double(imread(foreground));

%% Segmentation and creating mask
lab_he = rgb2lab(fg);
ab = lab_he(:,:,2:3);
ab = im2single(ab);
nColors = 2; % constant
mask = normalize(mat2gray(rgb2gray(label2rgb(imsegkmeans(ab, nColors, 'NumAttempts', iterations)))), 'range');
mask = fastboxfilter2d(mask, rmask);

figure(1);
imshow(mask);
title('Foreground object mask');

%% Blending images
final(:,:,1) = blendfunction(fg(:,:,1), bg(:,:,1), mask);
final(:,:,2) = blendfunction(fg(:,:,2), bg(:,:,2), mask);
final(:,:,3) = blendfunction(fg(:,:,3), bg(:,:,3), mask);

figure(2);
imshow(mat2gray(final));
title('Blended image');
disp('Done')