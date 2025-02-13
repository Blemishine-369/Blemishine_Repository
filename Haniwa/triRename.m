% 指定.mat文件所在路径和目标保存路径
data_folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\data';
output_folder_path = 'C:\Users\admin\Desktop\haniwa_nose_240320\source\triDataRename';

% 获取.mat文件夹中所有文件名包含'matX'的文件
matX_files = dir(fullfile(data_folder_path, '*tri*.mat'));

% 遍历所有匹配的.mat文件
for i = 1:numel(matX_files)
    % 获取当前.mat文件名
    current_file_name = matX_files(i).name;
    disp(['当前处理的文件名是：', current_file_name]);
    
    % 加载.mat文件
    mat_file = load(fullfile(data_folder_path, current_file_name));
    
    % 获取.mat文件中的变量名
    var_names = fieldnames(mat_file);
    
    % 检查是否有变量
    if isempty(var_names)
        disp('警告：未找到有效变量名');
        continue;
    end
    
    % 取第一个变量名作为新的文件名
    new_file_name = var_names{1};
    
    % 构建输出文件路径
    output_file_path = fullfile(output_folder_path, [new_file_name, '.mat']);
    
    % 保存.mat文件中的变量为新文件名
    save(output_file_path, '-struct', 'mat_file', new_file_name);
    
    disp(['文件已保存为：', output_file_path]);
end
