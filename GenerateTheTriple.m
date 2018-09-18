function [w, wInQuiet, wUntransposed] = GenerateTheTriple(task, ExOrTst, p)
%% generate the appropriate sounds
if strcmp(task, 'TransposedITDs') ||  strcmp(task, 'TransposedILDs')
    [w, wInQuiet, wUntransposed]=GenerateIADtriple(p);
elseif strcmp(task, 'NoisySAM')
    [w, wInQuiet, wUntransposed]=GenerateSAMtriple(p);
elseif strcmp(task, 'Berniotis')
    [w, wInQuiet, wUntransposed]=GenerateSxNxTonalTriple(p);
end
%% ensure no overload
% function [OutWave, flag] = NoClipStereo(InWave,message)
[w, flag] = NoClipStereo(w);
if p.outputAllWavs
    [wInQuiet, flag] = NoClipStereo(wInQuiet);
    audiowrite(fullfile(sprintf('%s-o%d.wav', ExOrTst, p.Order)),w,p.SampFreq);
    audiowrite(fullfile(sprintf('%sQT-o%d.wav', ExOrTst, p.Order)),wInQuiet,p.SampFreq);
end
