function varargout = FeedbackTestResults(varargin)
% FEEDBACKTESTRESULTS MATLAB code for FeedbackTestResults.fig
%      FEEDBACKTESTRESULTS, by itself, creates a new FEEDBACKTESTRESULTS or raises the existing
%      singleton*.
%
%      H = FEEDBACKTESTRESULTS returns the handle to a new FEEDBACKTESTRESULTS or the handle to
%      the existing singleton*.
%
%      FEEDBACKTESTRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEEDBACKTESTRESULTS.M with the given input arguments.
%
%      FEEDBACKTESTRESULTS('Property','Value',...) creates a new FEEDBACKTESTRESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FeedbackTestResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FeedbackTestResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FeedbackTestResults

% Last Modified by GUIDE v2.5 15-May-2018 17:26:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FeedbackTestResults_OpeningFcn, ...
                   'gui_OutputFcn',  @FeedbackTestResults_OutputFcn, ...
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


% --- Executes just before FeedbackTestResults is made visible.
function FeedbackTestResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FeedbackTestResults (see VARARGIN)

% Move the GUI to the center of the screen.
movegui(handles.figure1,'center')

% Choose default command line output for FeedbackTestResults
handles.output = hObject;
set(handles.message, 'String', varargin{2});

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes FeedbackTestResults wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FeedbackTestResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles); % Save the updated structure
uiresume(handles.figure1);

