clear all; close all;

strDataFold = './data/';

%vecName = {'078'; '085'; '089'; '090'; '091'; '092'; '097'; '098'; '100'; ...
%    '033'; '035'; '036'; '053'; '055'; '056'; '057'; '059'; '060'; ...
%    '001'; '020'; '021'; '022'; '023'; '024'; '025'; '083'; '084'; ...
%    '160'; '118'; '044'; '045'; '013'; '012'; '027'; '026'; '125'};
vecName = {'089'; '090'; '091'; '092'; '097'; '098'; '100'; ...
    '033'; '035'; '036'; '053'; '055'; '056'; '057'; '059'; '060'; ...
    '001'; '020'; '021'; '022'; '023'; '024'; '025'; '083'; '084'; ...
    '160'; '118'; '044'; '045'; '013'; '012'; '027'; '026'; '125'};

nNameLength = length(vecName);
matError = zeros(nNameLength);

for i = 1:nNameLength - 1
    for j = i + 1:nNameLength
        
close all;

strRefere = [vecName{i}, '_nose'];
strSource = [vecName{j}, '_nose'];

strRefereShort = vecName{i};
strSourceShort = vecName{j};

strRefereFile = [strDataFold, 'matX_', strRefere, '.mat'];
strSourceFile = [strDataFold, 'matX_', strSource, '.mat'];

structRefere = load(strRefereFile);
strFiledName = fieldnames(structRefere);
cellRefere = struct2cell(structRefere);
matXRefere = cell2mat(cellRefere);

structSource = load(strSourceFile);
strFiledName = fieldnames(structSource);
cellSource = struct2cell(structSource);
matXSource = cell2mat(cellSource);

nNumRefere = size(matXRefere, 2);
nNumSource = size(matXSource, 2);

%% Run ICP (standard settings)
nIter = 50;
dRatio = 3;

vecXRefereMean = mean(matXRefere, 2);
vecXSourceMean = mean(matXSource, 2);

matXRefereCenter = matXRefere - vecXRefereMean;
matXSourceCenter = matXSource - vecXSourceMean;
matXSourceCenterScale = eye(3)*dRatio*matXSourceCenter;

[matSIcp, matRIcp, vecTIcp, vecError, dTime] = ssicp(matXRefereCenter, matXSourceCenterScale, nIter);

matXSourceCenterTrans = matSIcp*matRIcp*matXSourceCenterScale + repmat(vecTIcp, 1, nNumSource);
matError(i,j) = vecError(end);

set(0, 'defaultAXesFontSize', 11);
set(0, 'defaultAxesFontName', 'times');
set(0, 'defaultTextFontSize', 11);
set(0, 'defaultTextFontName', 'times');

figure(1); hold on; grid on; 
%axis vis3d equal; camlight; grid on; lighting phong;
%vecColor = linspecer(10);
plot3(matXRefereCenter(1,:), matXRefereCenter(2,:), matXRefereCenter(3,:), ...
    'LineStyle', 'none', 'Marker', '.', 'MarkerFaceColor', 'b');
plot3(matXSourceCenter(1,:), matXSourceCenter(2,:), matXSourceCenter(3,:), ...
    'LineStyle', 'none', 'Marker', '.', 'MarkerFaceColor', 'r');
%view(15, 70); 
view(-75, 35); 
cellTypes = {['Reference [', strRefereShort, ']']; ['Source [', strSourceShort, ']']};
legend(cellTypes, 'Location', 'northeast');
title('(a) Before sICP [Nose]');

figure(2); hold on; grid on; 
%axis vis3d equal; camlight; grid on; lighting phong;
%vecColor = linspecer(10);
plot3(matXRefereCenter(1,:), matXRefereCenter(2,:), matXRefereCenter(3,:), ...
    'LineStyle', 'none', 'Marker', '.', 'MarkerFaceColor', 'b');
plot3(matXSourceCenterTrans(1,:), matXSourceCenterTrans(2,:), matXSourceCenterTrans(3,:), ...
    'LineStyle', 'none', 'Marker', '.', 'MarkerFaceColor', 'r');
%view(15, 70); 
view(-75, 35); 
cellTypes = {['Reference [', strRefereShort, ']']; ['Source [', strSourceShort, ']']};
legend(cellTypes, 'Location', 'northeast');
strError = num2str(vecError(end));
title('(b) After sICP [Nose], RMSE = ', strError);

strFileNameEps = [strDataFold, 'sicp_nose_before_', strRefereShort, '_', strSourceShort, '.eps'];
strFileNameBmp = [strDataFold, 'sicp_nose_before_', strRefereShort, '_', strSourceShort, '.bmp'];
print('-f1', '-dpsc', strFileNameEps);
saveas(1, strFileNameBmp);
strFileNameEps = [strDataFold, 'sicp_nose_after_', strRefereShort, '_', strSourceShort, '.eps'];
strFileNameBmp = [strDataFold, 'sicp_nose_after_', strRefereShort, '_', strSourceShort, '.bmp'];
print('-f2', '-dpsc', strFileNameEps);
saveas(2, strFileNameBmp);

    end
end

strFileName = [strDataFold, 'data_RMSE_036810111213.mat'];
save(strFileName, 'matError');
