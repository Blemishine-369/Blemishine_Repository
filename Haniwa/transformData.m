% Import an STL mesh, returning a PATCH-compatible face-vertex structure

% 078, 085, 089, 090, 091, 092, 097, 098, 100, 033,
% 035, 036, 053, 055, 056, 057, 059, 060, 001, 020,
% 021, 022, 023, 024, 025, 083, 084, 160, 118, 044,
% 045, 013, 012, 027, 026, 125, 

obj01 = readObj('../data/078_nose.obj');
obj02 = readObj('../data/085_nose.obj');
% obj03 = readObj('../data/089_nose.obj');
% obj04 = readObj('../data/090_nose.obj');
% obj05 = readObj('../data/091_nose.obj');
% obj06 = readObj('../data/092_nose.obj');
% obj07 = readObj('../data/097_nose.obj');
% obj08 = readObj('../data/098_nose.obj');
% obj09 = readObj('../data/100_nose.obj');
% obj10 = readObj('../data/033_nose.obj');
% 
% obj11 = readObj('../data/035_nose.obj');
% obj12 = readObj('../data/036_nose.obj');
% obj13 = readObj('../data/053_nose.obj');
% obj14 = readObj('../data/055_nose.obj');
% obj15 = readObj('../data/056_nose.obj');
% obj16 = readObj('../data/057_nose.obj');
% obj17 = readObj('../data/059_nose.obj');
% obj18 = readObj('../data/060_nose.obj');
% obj19 = readObj('../data/001_nose.obj');
% obj20 = readObj('../data/020_nose.obj');
% 
% obj21 = readObj('../data/021_nose.obj');
% obj22 = readObj('../data/022_nose.obj');
% obj23 = readObj('../data/023_nose.obj');
% obj24 = readObj('../data/024_nose.obj');
% obj25 = readObj('../data/025_nose.obj');
% obj26 = readObj('../data/083_nose.obj');
% obj27 = readObj('../data/084_nose.obj');
% obj28 = readObj('../data/160_nose.obj');
% obj29 = readObj('../data/118_nose.obj');
% obj30 = readObj('../data/044_nose.obj');
% 
% obj31 = readObj('../data/045_nose.obj');
% obj32 = readObj('../data/013_nose.obj');
% obj33 = readObj('../data/012_nose.obj');
% obj34 = readObj('../data/027_nose.obj');
% obj35 = readObj('../data/026_nose.obj');
% obj36 = readObj('../data/125_nose.obj');

matX01 = obj01.v(:,1:3)';
matX02 = obj02.v(:,1:3)';
% matX03 = obj03.v(:,1:3)';
% matX04 = obj04.v(:,1:3)';
% matX05 = obj05.v(:,1:3)';
% matX06 = obj06.v(:,1:3)';
% matX07 = obj07.v(:,1:3)';
% matX08 = obj08.v(:,1:3)';
% matX09 = obj09.v(:,1:3)';
% matX10 = obj10.v(:,1:3)';
% 
% matX11 = obj11.v(:,1:3)';
% matX12 = obj12.v(:,1:3)';
% matX13 = obj13.v(:,1:3)';
% matX14 = obj14.v(:,1:3)';
% matX15 = obj15.v(:,1:3)';
% matX16 = obj16.v(:,1:3)';
% matX17 = obj17.v(:,1:3)';
% matX18 = obj18.v(:,1:3)';
% matX19 = obj19.v(:,1:3)';
% matX20 = obj20.v(:,1:3)';
% 
% matX21 = obj21.v(:,1:3)';
% matX22 = obj22.v(:,1:3)';
% matX23 = obj23.v(:,1:3)';
% matX24 = obj24.v(:,1:3)';
% matX25 = obj25.v(:,1:3)';
% matX26 = obj26.v(:,1:3)';
% matX27 = obj27.v(:,1:3)';
% matX28 = obj28.v(:,1:3)';
% matX29 = obj29.v(:,1:3)';
% matX30 = obj20.v(:,1:3)';
% 
% matX31 = obj31.v(:,1:3)';
% matX32 = obj32.v(:,1:3)';
% matX33 = obj33.v(:,1:3)';
% matX34 = obj34.v(:,1:3)';
% matX35 = obj35.v(:,1:3)';
% matX36 = obj36.v(:,1:3)';

tri01 = obj01.f.vt;
tri02 = obj02.f.vt;
% tri03 = obj03.f.vt;
% tri04 = obj04.f.vt;
% tri05 = obj05.f.vt;
% tri06 = obj06.f.vt;
% tri07 = obj07.f.vt;
% tri08 = obj08.f.vt;
% tri09 = obj09.f.vt;
% tri10 = obj10.f.vt;
% 
% tri11 = obj11.f.vt;
% tri12 = obj12.f.vt;
% tri13 = obj13.f.vt;
% tri14 = obj14.f.vt;
% tri15 = obj15.f.vt;
% tri16 = obj16.f.vt;
% tri17 = obj17.f.vt;
% tri18 = obj18.f.vt;
% tri19 = obj19.f.vt;
% tri20 = obj20.f.vt;
% 
% tri21 = obj21.f.vt;
% tri22 = obj22.f.vt;
% tri23 = obj23.f.vt;
% tri24 = obj24.f.vt;
% tri25 = obj25.f.vt;
% tri26 = obj26.f.vt;
% tri27 = obj27.f.vt;
% tri28 = obj28.f.vt;
% tri29 = obj29.f.vt;
% tri30 = obj30.f.vt;
% 
% tri31 = obj31.f.vt;
% tri32 = obj32.f.vt;
% tri33 = obj33.f.vt;
% tri34 = obj34.f.vt;
% tri35 = obj35.f.vt;
% tri36 = obj36.f.vt;

save('matX_078_nose.mat', 'matX01');
save('matX_085_nose.mat', 'matX02');
% save('matX_089_nose.mat', 'matX03');
% save('matX_090_nose.mat', 'matX04');
% save('matX_091_nose.mat', 'matX05');
% save('matX_092_nose.mat', 'matX06');
% save('matX_097_nose.mat', 'matX07');
% save('matX_098_nose.mat', 'matX08');
% save('matX_100_nose.mat', 'matX09');
% save('matX_033_nose.mat', 'matX10'); 
% 
% save('matX_035_nose.mat', 'matX11');
% save('matX_036_nose.mat', 'matX12');
% save('matX_053_nose.mat', 'matX13');
% save('matX_055_nose.mat', 'matX14');
% save('matX_056_nose.mat', 'matX15');
% save('matX_057_nose.mat', 'matX16');
% save('matX_059_nose.mat', 'matX17');
% save('matX_060_nose.mat', 'matX18');
% save('matX_001_nose.mat', 'matX19');
% save('matX_020_nose.mat', 'matX20');
% 
% save('matX_021_nose.mat', 'matX21');
% save('matX_022_nose.mat', 'matX22');
% save('matX_023_nose.mat', 'matX23');
% save('matX_024_nose.mat', 'matX24');
% save('matX_025_nose.mat', 'matX25');
% save('matX_083_nose.mat', 'matX26');
% save('matX_084_nose.mat', 'matX27');
% save('matX_160_nose.mat', 'matX28');
% save('matX_118_nose.mat', 'matX29');
% save('matX_044_nose.mat', 'matX30');
% 
% save('matX_045_nose.mat', 'matX31');
% save('matX_013_nose.mat', 'matX32');
% save('matX_012_nose.mat', 'matX33');
% save('matX_027_nose.mat', 'matX34');
% save('matX_026_nose.mat', 'matX35');
% save('matX_125_nose.mat', 'matX36');

save('tri_078_nose.mat', 'tri01');
save('tri_085_nose.mat', 'tri02');
% save('tri_089_nose.mat', 'tri03');
% save('tri_090_nose.mat', 'tri04');
% save('tri_091_nose.mat', 'tri05');
% save('tri_092_nose.mat', 'tri06');
% save('tri_097_nose.mat', 'tri07');
% save('tri_098_nose.mat', 'tri08');
% save('tri_100_nose.mat', 'tri09');
% save('tri_033_nose.mat', 'tri10');
% 
% save('tri_035_nose.mat', 'tri11');
% save('tri_036_nose.mat', 'tri12');
% save('tri_053_nose.mat', 'tri13');
% save('tri_055_nose.mat', 'tri14');
% save('tri_056_nose.mat', 'tri15');
% save('tri_057_nose.mat', 'tri16');
% save('tri_059_nose.mat', 'tri17');
% save('tri_060_nose.mat', 'tri18');
% save('tri_001_nose.mat', 'tri19');
% save('tri_020_nose.mat', 'tri20');
% 
% save('tri_021_nose.mat', 'tri21');
% save('tri_022_nose.mat', 'tri22');
% save('tri_023_nose.mat', 'tri23');
% save('tri_024_nose.mat', 'tri24');
% save('tri_025_nose.mat', 'tri25');
% save('tri_083_nose.mat', 'tri26');
% save('tri_084_nose.mat', 'tri27');
% save('tri_160_nose.mat', 'tri28');
% save('tri_118_nose.mat', 'tri29');
% save('tri_044_nose.mat', 'tri30');
% 
% save('tri_045_nose.mat', 'tri31');
% save('tri_013_nose.mat', 'tri32');
% save('tri_012_nose.mat', 'tri33');
% save('tri_027_nose.mat', 'tri34');
% save('tri_026_nose.mat', 'tri35');
% save('tri_125_nose.mat', 'tri36');
