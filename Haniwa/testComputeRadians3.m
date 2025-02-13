% 指定文件夹路径
checkAdjacentAll_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\checkAdjacentAll';
outputVectors_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\outputVectors';
angleResults_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\angleResults';

% 循环处理每个文件
for i = 1:36
    % 跳过文件名中代号为30的文件
    if i == 30
        disp('跳过文件：tri30_checkAdjacent.mat');
        continue;
    end
    
    % 构建当前文件名
    tri_file_name = ['tri', sprintf('%02d', i), '_checkAdjacent.mat'];
    output_file_name = ['tri', sprintf('%02d', i), '_OutputVectors.mat'];
    disp(['当前处理的文件名是：', tri_file_name]);
    
    % 读取 output_data.mat 文件
    tri_mat_file = load(fullfile(checkAdjacentAll_path, tri_file_name));
    
    % 提取变量名
    tri_var_name = fieldnames(tri_mat_file);
    
    % 确定变量名是否存在且不为空
    if isempty(tri_var_name)
        disp(['错误：未找到tri变量名：', tri_file_name]);
        continue;
    end
    
    % 获取当前文件的数据
    output_data = tri_mat_file.(tri_var_name{1}); 
    
    % 读取 normal_vectors.mat 文件
    vectors_mat_file = load(fullfile(outputVectors_path, output_file_name));
    
    % 提取变量名
    vectors_var_name = fieldnames(vectors_mat_file);
    
    % 确定变量名是否存在且不为空
    if isempty(vectors_var_name)
        disp(['错误：未找到normal_vectors变量名：', output_file_name]);
        continue;
    end
    
    % 获取当前文件的数据
    normal_vectors = vectors_mat_file.(vectors_var_name{1}); 
    
% 执行操作
% 获取数据行数（即三角形的数量）
num_triangles = size(output_data, 1);

% 初始化存储结果的结构数组
result_data = zeros(num_triangles, 1);

% 循环处理每个三角形
for j = 1:num_triangles
    % 获取当前三角形的索引信息
    current_indices = output_data(j, 4:6);

    % 初始化当前三角形的夹角列表
    angles = zeros(1, 3);

    % 循环处理当前三角形的相邻三角形
    for k = 1:3
        % 获取当前相邻三角形的索引
        neighbor_index = current_indices(k);

        if neighbor_index == 0
            % 如果相邻三角形索引为0，说明没有相邻三角形
            continue;  % 跳过当前相邻三角形的处理
        end

        % 读取对应的法向量数据
        vector1 = [normal_vectors(j).U, normal_vectors(j).V, normal_vectors(j).W];
        vector2 = [normal_vectors(neighbor_index).U, normal_vectors(neighbor_index).V, normal_vectors(neighbor_index).W];

        % 计算夹角（以弧度为单位）
        angle = acos(dot(vector1, vector2) / (norm(vector1) * norm(vector2)));

        % 将弧度转换为角度
        angle_degrees = rad2deg(angle);

        % 将夹角存储到当前三角形的夹角列表中
        angles(k) = angle_degrees;
    end

    % 计算夹角的平均值
    average_angle = mean(angles(angles ~= 0));  % 排除夹角为0的情况

    % 存储结果到结构数组中
    result_data(j) = average_angle;
end


    % 构建输出文件名
    output_file_path = fullfile(angleResults_path, ['angle_results_tri', sprintf('%02d', i), '.mat']);

    % 保存为单独的.mat格式文件，文件名为 angle_results_XX.mat
    save(output_file_path, 'result_data');

    disp(['文件处理完成：', tri_file_name, '，结果已保存为：', output_file_path]);
end







% % 从工作区读入 output_data.mat 文件
% load('output_data.mat');
% 
% % 从工作区读入 normal_vectors.mat 文件
% load('normal_vectors.mat');
% 
% % 获取数据行数（即三角形的数量）
% num_triangles = size(output_data, 1);
% 
% 
% % 初始化存储结果的结构数组
% result_data(num_triangles).triangle_index = [];
% result_data(num_triangles).neighbor_angles = [];
% result_data(num_triangles).average_angle = [];
% 
% % 循环处理每个三角形
% for i = 1:num_triangles
%     % 获取当前三角形的索引信息
%     current_indices = output_data(i, 4:6);
% 
%     % 初始化当前三角形的夹角列表
%     angles = zeros(1, 3);
% 
%     % 循环处理当前三角形的相邻三角形
%     for j = 1:3
%         % 获取当前相邻三角形的索引
%         neighbor_index = current_indices(j);
% 
%         if neighbor_index == 0
%             % 如果相邻三角形索引为0，说明没有相邻三角形
%             disp(['三角形 ' num2str(i) ' 没有第 ' num2str(j) ' 个相邻三角形']);
%             continue;  % 跳过当前相邻三角形的处理
%         end
% 
%         % 读取对应的法向量数据
%         vector1 = [normal_vectors(i).U, normal_vectors(i).V, normal_vectors(i).W];
%         vector2 = [normal_vectors(neighbor_index).U, normal_vectors(neighbor_index).V, normal_vectors(neighbor_index).W];
% 
%         % 计算夹角（以弧度为单位）
%         angle = acos(dot(vector1, vector2) / (norm(vector1) * norm(vector2)));
% 
%         % 将弧度转换为角度
%         angle_degrees = rad2deg(angle);
% 
%         % 将夹角存储到当前三角形的夹角列表中
%         angles(j) = angle_degrees;
%     end
% 
%     % 计算夹角的平均值
%     average_angle = mean(angles(angles ~= 0));  % 排除夹角为0的情况
% 
%     % 存储结果到结构数组中
%     result_data(i).triangle_index = i;
%     result_data(i).neighbor_angles = angles(angles ~= 0);  % 排除夹角为0的情况
%     result_data(i).average_angle = average_angle;
% end
% 
% % 保存为 .mat 格式文件
% save('angle_results.mat', 'result_data');
