function [data_index, cluster_center] = weighted_kmeans(data, data_weigth, number_of_clusters, disp_results)
% data: [number_of_records, number_of_dimentions];
% data weigth in range of 0 to 1
% disp_results: only when number_of_dimentions = 2

number_of_records = size(data, 1);

% generate data repetition based on data weigth in range of 0 to 100
data_repetition = round(data_weigth*100);

number_of_repeated_data = sum(data_repetition);

repeated_data = zeros(number_of_repeated_data, size(data,2));
data_index_in_repeated_data = zeros(1, number_of_records);
indx = 0;
for k = 1:numel(data_weigth)

    data_index_in_repeated_data(k) = indx+1;

    repeated_data(indx+1 : indx+data_repetition(k), :) = repmat(data(k, :), [data_repetition(k), 1]);
    indx = indx + data_repetition(k);
end

% apply kmeans
% number_of_clusters = 15;
[repeated_data_index, cluster_center] = kmeans(repeated_data, number_of_clusters);

cluster_index = 1:number_of_clusters;
data_index = repeated_data_index(data_index_in_repeated_data);
data_index = cluster_index(data_index);

if disp_results
    % visualize results
    color_palette = jet(number_of_clusters);
    color_index = repeated_data_index(data_index_in_repeated_data);
    data_colors = color_palette(color_index, :);

    point_size = data_repetition + 1;

    figure(disp_results);
    hold on;
    scatter(data(:, 1), data(:, 2), point_size , data_colors, 'filled');
    scatter(cluster_center(:, 1), cluster_center(:, 2), 200, color_palette, '*', 'LineWidth', 2);
    legend('data points', 'centers','Location','bestoutside');
    axis square
end
