% 指定文件夹路径
folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\triDataRename';
output_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\outputVectors';
data_folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\matXdataRename';

% 遍历tri01_checkAdjacent.mat到tri36_checkAdjacent.mat文件
% 遍历matX01.mat到matX36.mat文件
for i = 31:36
    % 构建当前文件名
    tri_file_name = ['tri', sprintf('%02d', i), '.mat'];
    matX_file_name = ['matX', sprintf('%02d', i), '.mat'];
    disp(['当前处理的文件名是：', tri_file_name]);
    disp(['当前处理的文件名是：', matX_file_name]);
    % 读取.mat文件
    tri_mat_file = load(fullfile(folder_path, tri_file_name));
    matX_mat_file = load(fullfile(data_folder_path, matX_file_name));
    
    % 提取变量名
    tri_var_name = fieldnames(tri_mat_file);
    matX_var_name = fieldnames(matX_mat_file);
    disp(['当前处理的变量名是：', tri_var_name]);
    disp(['当前处理的变量名是：', matX_var_name]);
    % 确定变量名是否存在且不为空
    if isempty(tri_var_name)
        disp('错误：未找到tri变量名');
        continue;
    end
    
    if isempty(matX_var_name)
        disp('错误：未找到matX变量名');
        continue;
    end
    
    % 获取当前文件的数据
    tri_data_var = tri_mat_file.(tri_var_name{1}); 
    matX_data_var = matX_mat_file.(matX_var_name{1}); 
    
    % 检查变量是否成功读取
    if isempty(tri_data_var)
        disp('错误：未找到有效tri数据');
        continue;
    end
    
    if isempty(matX_data_var)
        disp('错误：未找到有效matX数据');
        continue;
    end
    % 获取当前三角形数据的数量
    num_triangles = size(tri_data_var, 1);
    % 创建一个结构数组，存储每个三角形的法线向量
    normal_vectors = struct('U', {}, 'V', {}, 'W', {});
    % 遍历每个三角形
    for j = 1:num_triangles
    % 获取当前三角形的顶点索引
    vertex_indices = tri_data_var(j,:);
    
    % 获取当前三角形的顶点坐标
    vertices = matX_data_var(:, vertex_indices);
    
    % 计算两个边向量
    AB = vertices(:,2) - vertices(:,1);
    AC = vertices(:,3) - vertices(:,1);
    
    % 计算法线向量
    normal_vector = cross(AB, AC);
    
    % 归一化法线向量
    normal_vector = normal_vector / norm(normal_vector);
    
    % 将法线向量存储到结构数组中
    normal_vectors(j).U = normal_vector(1);
    normal_vectors(j).V = normal_vector(2);
    normal_vectors(j).W = normal_vector(3);
    end
    
    
    
    
    % 构建输出文件名
    tri_output_file_name = [tri_var_name{1}, '_OutputVectors.mat'];
    % matX_output_file_name = [matX_var_name{1}, '_OutputVectors.mat'];
    
    % 保存为单独的.mat格式文件，文件名为变量名 + '_OutputVectors'
    tri_output_file_path = fullfile(output_path, tri_output_file_name);
    %matX_output_file_path = fullfile(output_path, matX_output_file_name);
    
    save(tri_output_file_path, 'normal_vectors');
    %save(matX_output_file_path, matX_var_name{1});
    
    disp(['tri文件处理完成：', tri_file_name, '，结果已保存为：', tri_output_file_path]);
    %disp(['matX文件处理完成：', matX_file_name, '，结果已保存为：', matX_output_file_path]);
end



% % 创建一个结构数组，存储每个三角形的法线向量
% normal_vectors = struct('U', {}, 'V', {}, 'W', {});
% % 遍历每个三角形
% for j = 1:num_triangles
%     % 获取当前三角形的顶点索引
%     vertex_indices = tri_data_var(j,:);
% 
%     % 获取当前三角形的顶点坐标
%     vertices = matX_data_var(:, vertex_indices);
% 
%     % 计算两个边向量
%     AB = vertices(:,2) - vertices(:,1);
%     AC = vertices(:,3) - vertices(:,1);
% 
%     % 计算法线向量
%     normal_vector = cross(AB, AC);
% 
%     % 归一化法线向量
%     normal_vector = normal_vector / norm(normal_vector);
% 
%     % 将法线向量存储到结构数组中
%     normal_vectors(j).U = normal_vector(1);
%     normal_vectors(j).V = normal_vector(2);
%     normal_vectors(j).W = normal_vector(3);
% end
% 
% % 保存为.mat格式文件
% save('normal_vectors.mat', 'normal_vectors');