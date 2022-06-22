clc
clear
close all

% generate data
number_of_records = 415;
number_of_dimentions = 2;
data = 10*rand(number_of_records, number_of_dimentions);

% generate data weigth in range of 0 to 1
data_weigth = rand(size(data,1), 1);

disp_results = 1;
number_of_clusters = 15;
[data_index, cluster_center] = weighted_kmeans(data, data_weigth, number_of_clusters, disp_results);

disp(cluster_center)
