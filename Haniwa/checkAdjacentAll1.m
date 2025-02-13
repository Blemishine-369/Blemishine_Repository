
% 指定文件夹路径
folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\data';
save_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\checkAdjacentAll';

% 获取文件夹中所有的.mat文件
mat_files = dir(fullfile(folder_path, '*.mat'));

% 遍历所有.mat文件
for i = 1:numel(mat_files)
    % 获取当前文件名
    file_name = mat_files(i).name;
    disp(['当前处理的文件名是：', file_name]);
    
    % 跳过特定文件
    if strcmp(file_name, 'data_RMSE_036810111213.mat')
        disp(['跳过文件：', file_name]);
        continue;
    end
    
    % 如果文件名中包含 "tri"，则读取相应的变量
    if contains(file_name, 'tri')
        % 读取.mat文件
        mat_file = load(fullfile(folder_path, file_name));
        
        % 获取.mat文件中的所有变量名
        var_names = fieldnames(mat_file);
        
        % 寻找匹配的变量名，变量名包含 'tri'
        matching_var_name = '';
        for j = 1:numel(var_names)
            if contains(var_names{j}, 'tri')
                matching_var_name = var_names{j};
                break;
            end
        end
        
        % 如果找到匹配的变量名，则继续处理
        if ~isempty(matching_var_name)
            % 获取三角形的定义信息
            tri_var = mat_file.(matching_var_name);
            
            % 获取三角形的数量
            num_triangles = size(tri_var, 1);
            disp(['该模型总共有 ', num2str(num_triangles), ' 个三角形']);
            % 开始计时
            tic;
            
            % 初始化输出数据
            output_data = zeros(num_triangles, 6);
            
            % 遍历每个三角形
            for j = 1:num_triangles
                current_triangle = tri_var(j, :);
                adjacent_triangles = zeros(1, 3);
                counter = 1;
                
                % 检查当前三角形与所有三角形的相邻关系
                for k = 1:num_triangles
                    if k == j
                        continue;
                    end
                    
                    candidate_triangle = tri_var(k, :);
                    
                    % 检查是否有共享顶点
                    shared_vertices = sum(ismember(current_triangle, candidate_triangle));
                    
                    if shared_vertices >= 2
                        % 找到相邻三角形，将其添加到相邻三角形数组中
                        adjacent_triangles(counter) = k;
                        counter = counter + 1;
                        
                        % 找到相邻三角形后跳出循环
                        %break;
                    end
                end
                
                % 将结果添加到输出数据中
                output_data(j, 1:3) = current_triangle;
                output_data(j, 4:6) = adjacent_triangles;
            end
            
            % 保存为.mat格式文件，文件名与读取的文件相同
            save(fullfile(save_path, [matching_var_name, '_checkAdjacent.mat']), 'output_data');
            % 停止计时，并计算时间
            elapsed_time = toc;               
            % 显示所用时间
            disp(['处理文件耗时：', num2str(elapsed_time), ' 秒']);
        else
            disp('无法找到与 "tri" 匹配的变量名');
        end
    else
        disp(['文件名不包含 "tri"：', file_name]);
    end
end

