function varargout = PsychoacousticTraining(varargin)
% PSYCHOACOUSTICTRAINING MATLAB code for PsychoacousticTraining.fig
%      PSYCHOACOUSTICTRAINING, by itself, creates a new PSYCHOACOUSTICTRAINING or raises the existing
%      singleton*.
%
%      H = PSYCHOACOUSTICTRAINING returns the handle to a new PSYCHOACOUSTICTRAINING or the handle to
%      the existing singleton*.
%
%      PSYCHOACOUSTICTRAINING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSYCHOACOUSTICTRAINING.M with the given input arguments.
%
%      PSYCHOACOUSTICTRAINING('Property','Value',...) creates a new PSYCHOACOUSTICTRAINING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PsychoacousticTraining_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PsychoacousticTraining_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PsychoacousticTraining

% Last Modified by GUIDE v2.5 14-May-2018 07:11:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PsychoacousticTraining_OpeningFcn, ...
                   'gui_OutputFcn',  @PsychoacousticTraining_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

addpath('..\TransposedIADs');

% --- Executes just before PsychoacousticTraining is made visible.
function PsychoacousticTraining_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PsychoacousticTraining (see VARARGIN)

% Choose default command line output for PsychoacousticTraining
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Move the GUI to the center of the screen.
movegui(handles.figure1,'center')
% put all conditions possibilities into box
[tasks, levels]=ReadConditions();
set(handles.Task, 'String', tasks);

contents = cellstr(get(handles.Task,'String')); 
handles.task=contents{1};
set(handles.Level,'String',levels(1));
handles.level=str2double(levels(1));
handles.numExamples=str2double(get(handles.nExamples,'String'));
handles.numTests=str2double(get(handles.nTests,'String'));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PsychoacousticTraining wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PsychoacousticTraining_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles)
    varargout{1}='quit';
else
    % Get default command line output from handles structure
    varargout{1} = handles.task;% handles.output;
    %varargout{2} = str2double(get(handles.Level,'String'));
    %varargout{3} = str2double(handles.initial);
end
% The figure can be deleted now
delete(handles.figure1);

% --- Executes on selection change in Task.
function Task_Callback(hObject, eventdata, handles)
% hObject    handle to Task (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Task contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Task
contents = cellstr(get(hObject,'String')); 
handles.task=contents{get(hObject,'Value')};
% guidata(hObject, handles); % Save the updated structure
% now set appropriate level
[tasks, levels]=ReadConditions();
% Hints: get(hObject,'String') returns contents of Level as text
%        str2double(get(hObject,'String')) returns contents of Level as a double
set(handles.Level, 'String', levels(hObject.Value));
handles.level=str2double(levels(hObject.Value));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Task_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Task (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GiveExamples.
function GiveExamples_Callback(hObject, eventdata, handles)
% hObject    handle to GiveExamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% randomise order
order=[];
while length(order)<handles.numExamples
    order=[order randperm(3)];
end
%% now to the task-specific sections
if strcmp(handles.task, 'TransposedITDs') ||  strcmp(handles.task, 'TransposedILDs')
    IAD = handles.task(11:13);
    if strcmp(IAD, 'ITD')
        starting_SNR=20*log10(handles.level/100);
    else
        starting_SNR=handles.level;
    end
    % set up necessary parameters
    p=TransposedIADsParseArgs('XX', 'usePlayrec', 0, ......
        'outputAllWavs', 1, ...
        'starting_SNR',starting_SNR , 'IAD', IAD);
    %% Set RME Slider if necessary
    if strcmp(p.RMEslider,'TRUE')
        if strcmp(handles.task, 'TransposedITDs') ||  strcmp(handles.task, 'TransposedILDs')
            RMEsettingsFile=fullfile('..\TransposedIADs', 'RMEsettings.csv');
        else
            RMEsettingsFile=fullfile(['..\' handles.task], 'RMEsettings.csv');
        end
        PrepareRMEslider(RMEsettingsFile,p.dBSPL);
    end
    for i= 1:handles.numExamples
        p.Order=order(i);
        %% generate the appropriate sounds
        [w, wInQuiet, wUntransposed]=GenerateIADtriple(p);
        %% ensure no overload
        % function [OutWave, flag] = NoClipStereo(InWave,message)
        [w, flag] = NoClipStereo(w);
        if p.outputAllWavs
            [wInQuiet, flag] = NoClipStereo(wInQuiet);
            audiowrite(fullfile(sprintf('Ex-o%d.wav', p.Order)),w,p.SampFreq);
            audiowrite(fullfile(sprintf('ExQT-o%d.wav', p.Order)),wInQuiet,p.SampFreq);
        end
        InfoToDisplay= sprintf('Interval %d is the ''odd one out''',p.Order);
        % function [response,p] = PlayAndReturnResponse3I3AFC(Wave2Play,trial,p)
        responseGUI = PlayAndReturnNoResponse3I3AFC(w,p,InfoToDisplay,order(i));
        % function responseGUI = PlayAndReturnNoResponse3I3AFC(Wave2Play,p,InfoToDisplay,correct)
    end
    delete(responseGUI);
else
    error('Not yet implemented');
end


% --- Executes on button press in TestExamples.
function TestExamples_Callback(hObject, eventdata, handles)
% hObject    handle to TestExamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% randomise order
order=[];
while length(order)<handles.numTests
    order=[order randperm(3)];
end
%% now to the task-specific sections
if strcmp(handles.task, 'TransposedITDs') ||  strcmp(handles.task, 'TransposedILDs')
    IAD = handles.task(11:13);
    if strcmp(IAD, 'ITD')
        starting_SNR=20*log10(handles.level/100);
    else
        starting_SNR=handles.level;
    end
    % set up necessary parameters
    p=TransposedIADsParseArgs('XX', 'outputAllWavs', 1, ...
        'starting_SNR',starting_SNR , 'IAD', IAD);
    if strcmp(p.RMEslider,'TRUE')
        if strcmp(handles.task, 'TransposedITDs') ||  strcmp(handles.task, 'TransposedILDs')
            RMEsettingsFile=fullfile('..\TransposedIADs', 'RMEsettings.csv');
        else
            RMEsettingsFile=fullfile(['..\' handles.task], 'RMEsettings.csv');
        end
        PrepareRMEslider(RMEsettingsFile,p.dBSPL);
    end
    correct=0;
    GoOrMessageButton('String', 'none')
    pause(1)
    for i= 1:handles.numTests
        p.Order=order(i);
        %% generate the appropriate sounds
        [w, wInQuiet, wUntransposed]=GenerateIADtriple(p);
        %% ensure no overload
        % function [OutWave, flag] = NoClipStereo(InWave,message)
        [w, flag] = NoClipStereo(w);
        if p.outputAllWavs
            [wInQuiet, flag] = NoClipStereo(wInQuiet);
            audiowrite(fullfile(sprintf('Tst-o%d.wav', p.Order)),w,p.SampFreq);
            audiowrite(fullfile(sprintf('TstQT-o%d.wav', p.Order)),wInQuiet,p.SampFreq);
        end
        InfoToDisplay= sprintf('Now you try',p.Order);
        %  function [response,p] = PlayAndReturnResponse3I3AFC(Wave2Play,trial,p,InfoToDisplay)
%         if i==1
%             [response,p] = PlayAndReturnResponse3I3AFC(w,0,p,InfoToDisplay);
%         end
        [response,p] = PlayAndReturnResponse3I3AFC(w,i,p,InfoToDisplay);
        if p.Order==response
            correct=correct+1;
        end
        % function responseGUI = PlayAndReturnNoResponse3I3AFC(Wave2Play,p,InfoToDisplay,correct)
    end
    delete(p.responseGUI);
    FeedbackTestResults(0, sprintf('You got %d/%d correct = %5.1f%%',correct,handles.numTests,100*correct/handles.numTests));
else
    error('Not yet implemented');
end



function nExamples_Callback(hObject, eventdata, handles)
% hObject    handle to nExamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nExamples as text
%        str2double(get(hObject,'String')) returns contents of nExamples as a double
handles.numExamples = str2double(get(hObject,'String'));
guidata(hObject, handles); % Save the updated structure

% --- Executes during object creation, after setting all properties.
function nExamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nExamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nTests_Callback(hObject, eventdata, handles)
% hObject    handle to nTests (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nTests as text
%        str2double(get(hObject,'String')) returns contents of nTests as a double
handles.numTests = str2double(get(hObject,'String'));
guidata(hObject, handles); % Save the updated structure

% --- Executes during object creation, after setting all properties.
function nTests_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nTests (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Finished.
function Finished_Callback(hObject, eventdata, handles)
% hObject    handle to Finished (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles); % Save the updated structure
uiresume(handles.figure1);

function Level_Callback(hObject, eventdata, handles)
% hObject    handle to Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Level as text
%        str2double(get(hObject,'String')) returns contents of Level as a double
handles.level = str2double(get(hObject,'String'));
guidata(hObject, handles); % Save the updated structure

% --- Executes during object creation, after setting all properties.
function Level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
