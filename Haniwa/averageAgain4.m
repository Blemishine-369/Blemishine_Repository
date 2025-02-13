% 指定文件夹路径
folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\triDataRename';
save_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\triContain';

% 遍历tri01.mat到tri36.mat文件
for i = 1:36
    % 跳过缺失的文件tri30.mat
    if i == 30
        continue;
    end
    
    % 构建当前文件名
    file_name = ['tri', sprintf('%02d', i), '.mat'];
    disp(['当前处理的文件名是：', file_name]);
    
    % 读取.mat文件
    mat_file = load(fullfile(folder_path, file_name));
    
    % 提取变量名
    var_names = fieldnames(mat_file);
    
    % 确定变量名是否存在且不为空
    if isempty(var_names)
        disp('错误：未找到有效数据变量');
        continue;
    end
    
    % 获取当前文件的数据
    data_var = mat_file.(var_names{1}); 
    
    % 检查变量是否成功读取
    if isempty(data_var)
        disp('错误：未找到有效数据');
        continue;
    end
    
    % 计算顶点的数量
    num_vertices = max(data_var(:));

    % 初始化存储结果的单元格数组
    triangles_containing_vertex = cell(num_vertices, 1);

    % 遍历每个三角形
    for j = 1:size(data_var, 1)
        % 获取当前三角形的顶点索引
        vertex_indices = data_var(j, :);

        % 将当前三角形的索引添加到包含每个顶点的三角形列表中
        for k = 1:3
            vertex_index = vertex_indices(k);
            triangles_containing_vertex{vertex_index} = [triangles_containing_vertex{vertex_index}, j];
        end
    end

    % 保存为单独的.mat格式文件，命名规则为原文件名 + '_Contain'
    output_file_name = [file_name(1:end-4), '_Contain.mat'];
    output_file_path = fullfile(save_path, output_file_name);
    
    save(output_file_path, 'triangles_containing_vertex');
    
    disp(['文件处理完成：', file_name, '，结果已保存为：', output_file_path]);
end




% 
% % 计算顶点的数量
% num_vertices = max(tri03(:));
% 
% % 初始化存储结果的单元格数组
% triangles_containing_vertex = cell(num_vertices, 1);
% 
% % 遍历每个三角形
% for i = 1:size(tri03, 1)
%     % 获取当前三角形的顶点索引
%     vertex_indices = tri03(i, :);
% 
%     % 将当前三角形的索引添加到包含每个顶点的三角形列表中
%     for j = 1:3
%         vertex_index = vertex_indices(j);
%         triangles_containing_vertex{vertex_index} = [triangles_containing_vertex{vertex_index}, i];
%     end
% end
% 
% % 保存为 .mat 格式文件
% save('triangles_containing_vertex.mat', 'triangles_containing_vertex');
% 
% disp('结果已经保存到 triangles_containing_vertex.mat 文件中。');
