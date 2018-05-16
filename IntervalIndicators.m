function IntervalIndicators(responseGUI, OneSoundDuration, ISI, initialDelay, correct)
%
% V 2.0 - allow the specification of the corect intervals with a different colour

if nargin<5
    correct=0;
end

OnColour='red';
CorrectColour='green';
pause(initialDelay/1000);
originalColour = get(responseGUI.Children(2),'BackgroundColor');
if correct==1
    set(responseGUI.Children(4),'BackgroundColor',CorrectColour)
else
    set(responseGUI.Children(4),'BackgroundColor',OnColour)
end
pause(OneSoundDuration/1000);
set(responseGUI.Children(4),'BackgroundColor',originalColour)
pause(ISI/1000);
if correct==2
    set(responseGUI.Children(3),'BackgroundColor',CorrectColour)
else
    set(responseGUI.Children(3),'BackgroundColor',OnColour)
end
pause(OneSoundDuration/1000);
set(responseGUI.Children(3),'BackgroundColor',originalColour)
pause(ISI/1000);
if correct==3
    set(responseGUI.Children(2),'BackgroundColor',CorrectColour)
else
    set(responseGUI.Children(2),'BackgroundColor',OnColour)
end
pause(OneSoundDuration/1000);
set(responseGUI.Children(2),'BackgroundColor',originalColour)
