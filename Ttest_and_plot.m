clc
clear
close all

load('CSA_results.mat')

%% T test: compare the two groups (one with subjects going under treatment 
% and other with patients not going under treatment, i.e., control group)
% regarding the cross-sectional area changes. The cross-sectional area was
% measured from MRI images in 3 different spots and in two different days,
% one day before the treatment started and one day after it ended..

[h_25,p_25,ci_25,stats_25] = ttest2(results.group1_diff_area25,results.group2_diff_area25);
[h_50,p_50,ci_50,stats_50] = ttest2(results.group1_diff_area50,results.group2_diff_area50);
[h_75,p_75,ci_75,stats_75] = ttest2(results.group1_diff_area75,results.group2_diff_area75);

%% Plot

subplot(1,3,1)
boxplot(results.diff_area25,results.group)
title('Area 25%')
subplot(1,3,2)
boxplot(results.diff_area50,results.group)
title('Area 50%')
subplot(1,3,3)
boxplot(results.diff_area75,results.group)
title('Area 75%')