clc
clear
close all


img = imread('cameraman.tif');
img = imresize(img, 0.25);

h = fspecial('gaussian', 5, 2);
img_blured = imfilter(img, h);

img_edges = edge(img_blured, 'canny');

img_dist = bwdist(img_edges, 'euclidean');

subplot(2, 2, 1); imshow(img); title('image');
subplot(2, 2, 2); imshow(img_blured); title('blur');
subplot(2, 2, 3); imshow(img_edges, []); title('edge');
subplot(2, 2, 4); imshow(img_dist, []); title('dist');



data = double(img(:));
data_weigth = img_dist(:);



disp_results = 0;
number_of_clusters = 2;
[data_index, cluster_center] = weighted_kmeans(data, data_weigth, number_of_clusters, disp_results);

disp(cluster_center)
