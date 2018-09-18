function p=SetUpStructure(task, ExtraArgsArray, level)

if strcmp(task, 'TransposedITDs') ||  strcmp(task, 'TransposedILDs')
    IAD = task(11:13);
    if strcmp(IAD, 'ITD')
        starting_SNR=20*log10(level/100);
    else
        starting_SNR=level;
    end
    % set up necessary parameters
    OriginalArgs = {'XX','outputAllWavs', 1, 'starting_SNR',starting_SNR , 'IAD', IAD};
    AugmentedArgs = [OriginalArgs, ExtraArgsArray];
    p=TransposedIADsParseArgs(AugmentedArgs{1:length(AugmentedArgs)});
elseif strcmp(task, 'NoisySAM')
    % set up necessary parameters
    OriginalArgs = {'XX','outputAllWavs', 1, 'starting_SNR',level};
    AugmentedArgs = [OriginalArgs, ExtraArgsArray];
    p=NoisySAMParseArgs(AugmentedArgs{1:length(AugmentedArgs)});
elseif strcmp(task, 'Berniotis')
    % set up necessary parameters
    OriginalArgs = {'XX','outputAllWavs', 1, 'starting_SNR',level};
    AugmentedArgs = [OriginalArgs, ExtraArgsArray];
    p=BerniotisParseArgs(AugmentedArgs{1:length(AugmentedArgs)});
end