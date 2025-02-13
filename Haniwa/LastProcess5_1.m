% 指定文件夹路径
tri_contain_folder = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\triContain';
output_vectors_folder = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\outputVectors';
folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\triDataRename';
angle_folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\angleResults';
result_folder = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\RESULT';


% 遍历tri01_Contain.mat到tri36_Contain.mat文件
for i = 1:36
    % 构建当前文件名
    tri_contain_file_name = ['tri', sprintf('%02d', i), '_Contain.mat'];
    output_vectors_file_name = ['tri', sprintf('%02d', i), '_OutputVectors.mat'];
    file_name = ['tri', sprintf('%02d', i), '.mat'];
    angle_file_name = ['angle_results_tri',sprintf('%02d',i),'.mat'];
    result_file_name = ['tri', sprintf('%02d', i), '_Result.mat'];
    
    disp(['当前处理的文件名是：', tri_contain_file_name]);
    
    % 跳过缺失的文件
    if i == 30
        disp('跳过缺失的文件：tri30_Contain.mat');
        continue;
    end
    
    % 读取.mat文件
    tri_contain_mat_file = load(fullfile(tri_contain_folder, tri_contain_file_name));
    output_vectors_mat_file = load(fullfile(output_vectors_folder, output_vectors_file_name));
    angle_mat_file = load(fullfile(angle_folder_path, angle_file_name));
    mat_file = load(fullfile(folder_path, file_name));
    
    % 提取变量名
    tri_contain_var_name = fieldnames(tri_contain_mat_file);
    output_vectors_var_name = fieldnames(output_vectors_mat_file);
    angle_var_name = fieldnames(angle_mat_file);
    var_names = fieldnames(mat_file);
    
    % 获取当前文件的数据
    tri_contain_data = tri_contain_mat_file.(tri_contain_var_name{1}); 
    output_vectors_data = output_vectors_mat_file.(output_vectors_var_name{1});
    angle_data = angle_mat_file.(angle_var_name{1});
    data_var = mat_file.(var_names{1});
    % 计算顶点的数量
    num_vertices = max(data_var(:));

    % 初始化存储每个顶点平均法向量的数组
    Lastresult_data = zeros(num_vertices, 3);

    % 循环处理每个顶点
    for vertex_index = 1:num_vertices
        % 获取包含当前顶点的三角形索引列表
        triangle_indices = tri_contain_data{vertex_index};

        % 初始化当前顶点周围所有三角形的加权法向量总和
        weighted_normal_sum = zeros(1, 3);

        % 初始化当前顶点周围所有三角形的权重之和
        total_weight = 0;

        % 根据顶点包含的三角形的索引逐个计算加权法向量和权重之和
        for k = 1:numel(triangle_indices)
            triangle_index = triangle_indices(k);
            % 获取当前三角形的平均夹角作为权重
            weight = real(angle_data(triangle_index));

            % 获取当前三角形的法向量
            normal_vector = [output_vectors_data(triangle_index).U, output_vectors_data(triangle_index).V, output_vectors_data(triangle_index).W];

            % 将当前三角形的法向量乘以权重，并累加到总和中
            weighted_normal_sum = weighted_normal_sum + weight * normal_vector;

            % 累加权重
            total_weight = total_weight + weight;
        end

        % 计算当前顶点周围所有三角形的加权平均法向量
        if ~isempty(triangle_indices)
            num_triangles = numel(triangle_indices); % 获取三角形的个数
            vertex_average_normal = weighted_normal_sum / num_triangles; % 计算平均法向量
        else
            % 如果当前顶点周围没有三角形，则无法计算平均法向量
            vertex_average_normal = [0, 0, 0];
        end

        % 存储当前顶点的平均法向量到数组中
        Lastresult_data(vertex_index, :) = vertex_average_normal;
    end

    % 保存为单独的.mat格式文件，文件名为triXX_Result
    output_file_name = [file_name(1:end-4), '_Result.mat'];
    output_file_path = fullfile(result_folder, result_file_name);
    save(output_file_path, 'Lastresult_data');
    
    disp(['tri文件处理完成：', result_file_name, '，结果已保存为：', output_file_path]);
end







% % 读入 triangles_containing_vertex.mat 文件
% load('triangles_containing_vertex.mat');
% 
% % 读入 normal_vectors.mat 文件
% load('normal_vectors.mat');
% 
% % 计算顶点的数量
% num_vertices = max(tri03(:));
% 
% 
% % 初始化存储每个顶点平均法向量的数组
% LastProcess = zeros(num_vertices, 3);
% 
% 
% % 循环处理每个顶点
% for vertex_index = 1:num_vertices
%     % 获取包含当前顶点的三角形索引列表
%     triangle_indices = triangles_containing_vertex{vertex_index};
% 
%     % 初始化当前顶点周围所有三角形的加权法向量总和
%     weighted_normal_sum = zeros(1, 3);
% 
%     % 初始化当前顶点周围所有三角形的权重之和
%     total_weight = 0;
% 
%     % 根据顶点包含的三角形的索引逐个计算加权法向量和权重之和
%     for i = 1:numel(triangle_indices)
%         triangle_index = triangle_indices(i);
%         % 获取当前三角形的平均夹角作为权重
%         weight = result_data(triangle_index).average_angle;
% 
%         % 获取当前三角形的法向量
%         normal_vector = [normal_vectors(triangle_index).U, normal_vectors(triangle_index).V, normal_vectors(triangle_index).W];
% 
%         % 将当前三角形的法向量乘以权重，并累加到总和中
%         weighted_normal_sum = weighted_normal_sum + weight * normal_vector;
% 
%         % 累加权重
%         total_weight = total_weight + weight;
%     end
% 
% % 计算当前顶点周围所有三角形的加权平均法向量
% if ~isempty(triangle_indices)
%     num_triangles = numel(triangle_indices); % 获取三角形的个数
%     vertex_average_normal = weighted_normal_sum / num_triangles; % 计算平均法向量
% 
% else
%     % 如果当前顶点周围没有三角形，则无法计算平均法向量
%     vertex_average_normal = [0, 0, 0];
% end
% 
%     % 存储当前顶点的平均法向量到数组中
%     LastProcess(vertex_index, :) = vertex_average_normal;
% end
% 
% % 保存为 .mat 文件
% save('LastProcess1.mat', 'LastProcess');
% 
% disp('结果已经保存到LastProcess.mat文件中。');
