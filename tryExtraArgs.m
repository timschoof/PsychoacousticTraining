clear
OriginalArgs = {'XX','outputAllWavs', 1, 'starting_SNR',6 , 'IAD', 'ILD'};
ExtraArgsArray = {'usePlayrec', 0, 'RMEslider', 'FALSE'};
AugmentedArgs = [OriginalArgs, ExtraArgsArray ];
p=TransposedIADsParseArgs(AugmentedArgs{1:length(AugmentedArgs)});
return

    