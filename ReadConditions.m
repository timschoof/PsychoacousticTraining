function [tasks, levels]=ReadConditions()
%% read in the list of masker conditions and associated parameters, 
%% and return appropriate values from the file
%% Also get (separate) list of target conditions 
TaskLists=robustcsvread('TaskList.csv');
nTargets=size(TaskLists,1);
tasks=cell(nTargets-1,1);
levels=cell(nTargets-1,1);
for c=2:nTargets
    tasks{c-1}=TaskLists{c,1};
    levels{c-1}=TaskLists{c,2};
end


