% 加载顶点坐标文件和面的定义信息文件
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\matX_089_nose.mat');
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\tri_089_nose.mat');

% 获取三角形的数量
num_triangles = size(tri03, 1);
disp(['该模型总共有 ' num2str(num_triangles) ' 个三角形']);

% 计算相邻组的数量
num_adjacent_groups = ceil(num_triangles / 4);

% 初始化输出数据
output_data = zeros(num_adjacent_groups * 4, 12); % 每组四个三角形，每个三角形6个数字

% 遍历每个相邻组
for i = 1:num_adjacent_groups
    % 获取当前相邻组的索引范围
    start_index = (i - 1) * 4 + 1;
    end_index = min(i * 4, num_triangles);
    
    % 获取当前相邻组的三角形索引
    current_group = tri03(start_index:end_index, :);
    
    % 将当前相邻组的详细信息写入输出数据
    for j = 1:size(current_group, 1)
        current_triangle = current_group(j, :);
        adjacent_triangles = zeros(1, 3);
        counter = 1;  % 计数器，用于记录相邻三角形的数量

        % 检查当前三角形与其他所有三角形的相邻关系
        for k = 1:num_triangles
            if k >= start_index && k <= end_index
                continue;  % 跳过同一组内的三角形
            end

            candidate_triangle = tri03(k, :);

            % 检查是否有共享顶点
            shared_vertices = sum(ismember(current_triangle, candidate_triangle));

            if shared_vertices >= 2
                % 找到相邻三角形，将其添加到相邻三角形数组中
                adjacent_triangles(counter) = k;
                counter = counter + 1;
            end
        end

        % 将结果添加到输出数据中
        row_index = (i - 1) * 4 + j;
        output_data(row_index, 1:3) = current_triangle;
        output_data(row_index, 7:9) = adjacent_triangles;
    end
end

% 将输出数据写入文件
fid = fopen('output2.txt', 'w');
fprintf(fid, '%d %d %d %d %d %d %d %d %d %d %d %d\n', output_data');
fclose(fid);
