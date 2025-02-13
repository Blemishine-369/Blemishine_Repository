% 加载顶点坐标文件和面的定义信息文件
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\matX_089_nose.mat');
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\tri_089_nose.mat');

% 获取三角形的数量
num_triangles = size(tri03, 1);
disp(['该模型总共有 ' num2str(num_triangles) ' 个三角形']);

% 初始化输出数据
output_data = zeros(num_triangles, 6);

% 遍历每个三角形
for i = 1:num_triangles
    current_triangle = tri03(i, :);
    adjacent_triangles = zeros(1, 3);
    counter = 1;

    % 检查当前三角形与所有三角形的相邻关系
    for j = 1:num_triangles
        if j==i
            continue;
        end

        candidate_triangle = tri03(j, :);
        
        % 检查是否有共享顶点
        shared_vertices = sum(ismember(current_triangle, candidate_triangle));
        
        if shared_vertices >= 2
            % 找到相邻三角形，将其添加到相邻三角形数组中
            adjacent_triangles(counter) = j;
            counter = counter + 1;
            
            % 找到相邻三角形后跳出循环
            %break;
        end
    end

    % 将结果添加到输出数据中
    output_data(i, 1:3) = current_triangle;
    output_data(i, 4:6) = adjacent_triangles;
end

% 保存为.mat格式文件
save('output_data.mat', 'output_data');
