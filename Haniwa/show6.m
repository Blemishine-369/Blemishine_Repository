close all; clear all;

% 读入 LastProcess.mat 文件
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\RESULT\tri03_Result.mat');

load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\matX_089_nose.mat');  % 包含顶点坐标的文件
load('C:\Users\admin\Desktop\haniwa_nose_240320\source\data\tri_089_nose.mat');   % 包含面的定义信息的文件

% 创建一个新的图形窗口
figure;

% 使用 patch 函数创建三角形网格模型
trisurf(tri03, matX03(1,:), matX03(2,:), matX03(3,:));

hold on;

% 绘制加权法向量平均值
quiver3(matX03(1,:), matX03(2,:), matX03(3,:), Lastresult_data(:,1)', Lastresult_data(:,2)', Lastresult_data(:,3)', 'Color', 'r');

% 设置图形属性
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
title('三维模型展示');

% 设置视角
view(3);

% 设置光照
light;
lighting gouraud;

% 调整图形比例
axis equal;

hold off;

