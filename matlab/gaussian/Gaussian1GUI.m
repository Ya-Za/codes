function varargout = Gaussian1GUI(varargin)
% GAUSSIAN1GUI MATLAB code for Gaussian1GUI.fig
%      GAUSSIAN1GUI, by itself, creates a new GAUSSIAN1GUI or raises the existing
%      singleton*.
%
%      H = GAUSSIAN1GUI returns the handle to a new GAUSSIAN1GUI or the handle to
%      the existing singleton*.
%
%      GAUSSIAN1GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAUSSIAN1GUI.M with the given input arguments.
%
%      GAUSSIAN1GUI('Property','Value',...) creates a new GAUSSIAN1GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gaussian1GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gaussian1GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gaussian1GUI

% Last Modified by GUIDE v2.5 20-Sep-2016 14:43:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gaussian1GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Gaussian1GUI_OutputFcn, ...
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


% --- Executes just before Gaussian1GUI is made visible.
function Gaussian1GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gaussian1GUI (see VARARGIN)

% Choose default command line output for Gaussian1GUI
handles.output = hObject;
handles.g1 = Gaussian1();

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gaussian1GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gaussian1GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function mu_Callback(hObject, eventdata, handles)
% hObject    handle to mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

mu = get(hObject, 'Value');
set(handles.txt_mu, 'String', num2str(round(mu, 1)));

handles.g1.mu = mu;
handles.g1.update();


% --- Executes during object creation, after setting all properties.
function mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

sigma = get(hObject, 'Value');
set(handles.txt_sigma, 'String', num2str(round(sigma, 1)));

handles.g1.sigma = sigma;
handles.g1.update();


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
