%% Data processing of the previously measured cross-sectional area of the 
% Achilles tendon of 29 patients before and after treatment. MRI images
% and the software Image J were used to get the cross-sectional area in 
% three different spots: 25%, 50% and 75% of the length of the tendon.

% The data was not added to github due to ethical reasons.

clc
clear
close all

%% Load all required data
load('Group.mat') % which group the subject belong to: with or without treatment
load('Results_MRI_task.mat') % measurements of the cross sectional area of the
% Achiles tendon before and after treatment
load Randomization_key.mat % randomizing the subjects so that when the cross
% sectional area was measured I did not know which one went under treatment
load Randomization_key_ID.mat % same explanation as the previous file

for i = 1:length(randomization_key_ID)
    % Check which one is post (2) and pre (1) treatment
    tf = strcmp(cell2mat(randomization_key(i,2)),'Post');
    if tf == 1
        results.folder_1(i,1) = 2;
        results.folder_2(i,1) = 1;
    else
        results.folder_1(i,1) = 1;
        results.folder_2(i,1) = 2;
    end
    % Get the ID
    results.randomized_ID(i,1) = cell2mat(randomization_key_ID(i,2));
    % Get which group the subject belongs to
    results.group(i,1) = Group(i);
end

clear tf Group

% Get the areas knowing which one is pre and post
for i = 1:length(randomization_key_ID)
    info = find(results.randomized_ID(i,1) == MRIachilestendonDec1(:,1));
    if results.folder_1(i,1) == 1 % means folder 1 has the pre values
        results.pre_area25(i,1) = MRIachilestendonDec1(info(1,1),3);
        results.pre_area50(i,1) = MRIachilestendonDec1(info(1,1),4);
        results.pre_area75(i,1) = MRIachilestendonDec1(info(1,1),5);
        results.post_area25(i,1) = MRIachilestendonDec1(info(2,1),3);
        results.post_area50(i,1) = MRIachilestendonDec1(info(2,1),4);
        results.post_area75(i,1) = MRIachilestendonDec1(info(2,1),5);
    end
    if results.folder_1(i,1) == 2 % means folder 1 has the post values
        results.post_area25(i,1) = MRIachilestendonDec1(info(1,1),3);
        results.post_area50(i,1) = MRIachilestendonDec1(info(1,1),4);
        results.post_area75(i,1) = MRIachilestendonDec1(info(1,1),5);
        results.pre_area25(i,1) = MRIachilestendonDec1(info(2,1),3);
        results.pre_area50(i,1) = MRIachilestendonDec1(info(2,1),4);
        results.pre_area75(i,1) = MRIachilestendonDec1(info(2,1),5);
    end
end

clear info

% Calculate the area difference between post and pre in percent changes
for i = 1:length(randomization_key_ID)
    results.diff_area25(i,1) = ((results.post_area25(i,1) - results.pre_area25(i,1))/results.pre_area25(i,1))*100;
    results.diff_area50(i,1) = ((results.post_area50(i,1) - results.pre_area50(i,1))/results.pre_area50(i,1))*100;
    results.diff_area75(i,1) = ((results.post_area75(i,1) - results.pre_area75(i,1))/results.pre_area75(i,1))*100;
end

% Separate the results into 2 groups
for i = 1:29
    if results.group(i,1) == 0
        results.group1_diff_area25(i,1) = results.diff_area25(i,1);
        results.group1_diff_area50(i,1) = results.diff_area50(i,1);
        results.group1_diff_area75(i,1) = results.diff_area75(i,1);
    end
    if results.group(i,1) == 1
        results.group2_diff_area25(i,1) = results.diff_area25(i,1);
        results.group2_diff_area50(i,1) = results.diff_area50(i,1);
        results.group2_diff_area75(i,1) = results.diff_area75(i,1);
    end
end

save('CSA_results.mat','results')