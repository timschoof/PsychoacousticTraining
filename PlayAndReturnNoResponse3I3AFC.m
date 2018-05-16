function responseGUI = PlayAndReturnNoResponse3I3AFC(Wave2Play,p,InfoToDisplay,correct)
%
% varargins
%
% 1 OneSoundDuration (ms)
% 2 ISI (ms)
% 3 CorrectAnswer
% 4 CorrectImage
% 5 IncorrectImage
% 6 trial

if nargin<4
    correct=0;
end

OneSoundDuration=max(p.SignalDuration);
p.responseGUI = ResponsePadXtra3I3AFC(OneSoundDuration,p.ISI,p.Order,p.CorrectImage,p.IncorrectImage,0,InfoToDisplay);
pause(0.5);
responseGUI = p.responseGUI;

% intialize playrec if necessary
if p.usePlayrec == 1 % if you're using playrec
    if playrec('isInitialised')
        playrec('reset');
    end
    playrec('init', p.SampFreq, p.playDeviceInd, p.recDeviceInd);
    playrec('play', Wave2Play, [3,4]);
else
    playEm = audioplayer(Wave2Play,p.SampFreq);
    play(playEm);
end

IntervalIndicators(p.responseGUI, OneSoundDuration,p.ISI,p.initialDelay,correct)
%trial=0; % ?????
% response = ResponsePadXtra3I3AFC(OneSoundDuration,p.ISI,p.Order,p.CorrectImage,p.IncorrectImage,trial,InfoToDisplay);

