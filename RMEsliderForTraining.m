function RMEsliderForTraining(p, task)
%% Set RME Slider if necessary -- appropriate for all tasks
if strcmp(p.RMEslider,'TRUE')
    if strcmp(task, 'TransposedITDs') ||  strcmp(task, 'TransposedILDs')
        RMEsettingsFile=fullfile('..\TransposedIADs', 'RMEsettings.csv');
    elseif strcmp(task, 'Berniotis') ||  strcmp(task,'LoBerniotis')
        RMEsettingsFile=fullfile(['..\Berniotis'], 'RMEsettings.csv');
    else 
        RMEsettingsFile=fullfile(['..\' task], 'RMEsettings.csv');
    end
    PrepareRMEslider(RMEsettingsFile,p.dBSPL);
end
