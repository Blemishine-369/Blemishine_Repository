load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\matX_089_nose.mat');  % 包含顶点坐标的文件
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\tri_089_nose.mat');   % 包含面的定义信息的文件


% 创建一个新的图形窗口
figure;

% 使用 patch 函数创建三角形网格模型
trisurf(tri03, matX03(1,:), matX03(2,:), matX03(3,:));


% 计算每个三角形的重心坐标
num_triangles = size(tri03, 1);  % 获取三角形的数量
disp(['该模型总共有 ' num2str(num_triangles) ' 个三角形']);
triangle_centroids = zeros(3, num_triangles);  % 存储每个三角形的重心坐标

for i = 1:num_triangles
    % 获取当前三角形的顶点索引
    vertex_indices = tri03(i,:);
    
    % 获取当前三角形的顶点坐标
    vertices = matX03(:, vertex_indices);
    
    % 计算当前三角形的重心坐标
    centroid = (1/3) * sum(vertices, 2);
    
    % 存储重心坐标
    triangle_centroids(:, i) = centroid;

    % 计算两个边向量
    AB = vertices(:,2) - vertices(:,1);
    AC = vertices(:,3) - vertices(:,1);
    
    % 计算法线向量
    N(:,i) = cross(AB, AC);
    
    % 归一化法线向量
    N(:,i) = N(:,i) / norm(N(:,i));
end


% 设置图形属性
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
title('三维模型展示');

% 在三维模型上标出每个三角形的重心点
hold on;
%scatter3(triangle_centroids(1,:), triangle_centroids(2,:), triangle_centroids(3,:), 'r', 'filled');
% 可视化法线向量
quiver3(triangle_centroids(1,:), triangle_centroids(2,:), triangle_centroids(3,:), ...
        N(1,:), N(2,:), N(3,:), 'Color', 'b');
hold off;

% 设置视角
view(3);

% 设置光照
light;
lighting gouraud;

% 调整图形比例
axis equal;