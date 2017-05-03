function varargout = Model_fitting(varargin)
% MODEL_FITTING MATLAB code for Model_fitting.fig
%      MODEL_FITTING, by itself, creates a new MODEL_FITTING or raises the existing
%      singleton*.
%
%      H = MODEL_FITTING returns the handle to a new MODEL_FITTING or the handle to
%      the existing singleton*.
%
%      MODEL_FITTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODEL_FITTING.M with the given input arguments.
%
%      MODEL_FITTING('Property','Value',...) creates a new MODEL_FITTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Model_fitting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Model_fitting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Model_fitting

% Last Modified by GUIDE v2.5 03-May-2017 15:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Model_fitting_OpeningFcn, ...
                   'gui_OutputFcn',  @Model_fitting_OutputFcn, ...
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


% --- Executes just before Model_fitting is made visible.
function Model_fitting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Model_fitting (see VARARGIN)

% Choose default command line output for Model_fitting
handles.output = hObject;
handles.f_range(1) = str2double(get(handles.edit_freq_range1,'String'));
handles.f_range(2) = str2double(get(handles.edit_freq_range2,'String'));
set( handles.figure1, 'toolbar', 'figure' );
if ~isempty(varargin)   % varargin is a 5-columns matrix passed from the Reflection_calculation/Transmission_calculation 
    handles.f=varargin(:,1); % frequency
    handles.refractive_ind=varargin(:,2); % refractive index
    handles.absoption_coef=varargin(:,3); % absorption coefficient
    handles.complex_permittivity = varargin(:,4) + 1j*varargin(:,5); % varargin(:,4) is the real part, varargin(:,5) is the true(negative) imaginary part (not absolute values)
    f_range = find(handles.f>handles.f_range(1) & handles.f<=handles.f_range(2));
    UWA_plot(handles.axes1,handles.f,real(handles.complex_permittivity),'normal','b');
    xlim(handles.f_range);
    ylabel('\epsilon^,');
    UWA_plot(handles.axes2,handles.f,-imag(handles.complex_permittivity),'normal','b');
    xlabel('Frequency (THz)');ylabel('\epsilon^,^,');
    xlim(handles.f_range);
    UWA_plot(handles.axes3,real(handles.complex_permittivity(f_range)),...
        -imag(handles.complex_permittivity(f_range)),'normal','.b');
    xlabel('\epsilon^,');ylabel('\epsilon^,^,');
    set(handles.edit_log, 'String', strcat('Data displayed in the complex space ranges from ',...
    num2str(handles.f_range(1)),' to ',num2str(handles.f_range(2)),' THz'))
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Model_fitting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Model_fitting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_log_Callback(hObject, eventdata, handles)
% hObject    handle to edit_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_log as text
%        str2double(get(hObject,'String')) returns contents of edit_log as a double


% --- Executes during object creation, after setting all properties.
function edit_log_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_processfit.
function pushbutton_processfit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_processfit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
model = handles.selected_model;
alg = handles.selected_algorithm;
e_sample = handles.complex_permittivity;
f_range = find(handles.f>handles.f_range(1) & handles.f<=handles.f_range(2));
fit_data = horzcat(handles.f(f_range),e_sample(f_range));

% Check if the sample is water
quest1 = questdlg('Is the sample water ?', 'Yes','No');
switch quest1
    case 'Yes'
        answer = inputdlg('Enter the measured temperature:','Input',[1 20]);
        temperature = str2double(answer{1});        
    case 'No'
        temperature = [];
end
eval(['[ parameters, goodness, fit_value ] = UWA_' model '_fit( fit_data, temperature );']);
parameters
goodness
UWA_disp_fit_result(handles.edit_log,model,parameters,goodness)
handles.extracted_parameters = parameters;
handles.goodness_of_fit = goodness;
handles.estimated_values = fit_value;
guidata(hObject, handles);

% --- Executes on selection change in popupmenu_model.
function popupmenu_model_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_model contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_model
contents = cellstr(get(hObject,'String'));
switch contents{get(hObject,'Value')}
    case 'Double Debye'
        model = 'DoubleDebye';
    case 'Havriliak Negami'
        model = 'HavriliakNegami';
end
handles.selected_model = model;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_algorithm.
function popupmenu_algorithm_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_algorithm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_algorithm
contents = cellstr(get(hObject,'String'));
handles.selected_algorithm = contents{get(hObject,'Value')};
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_algorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_range1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq_range1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq_range1 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq_range1 as a double
handles.f_range(1) = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_freq_range1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq_range1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_range2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq_range2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq_range2 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq_range2 as a double
handles.f_range(2) = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_freq_range2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq_range2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to export_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_fitted_values_Callback(hObject, eventdata, handles)
% hObject    handle to export_fitted_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_figures_Callback(hObject, eventdata, handles)
% hObject    handle to export_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function import_optical_properties_Callback(hObject, eventdata, handles)
% hObject    handle to import_optical_properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the reference material');
file_selected=horzcat(PathName,FileName);
file_imported=dlmread(file_selected,',');
handles.f=file_imported(:,1); % frequency
handles.refractive_ind=file_imported(:,2); % refractive index
handles.absoption_coef=file_imported(:,3); % absorption coefficient
f_range = find(handles.f>handles.f_range(1) & handles.f<=handles.f_range(2));
if size(file_imported,2) == 5 % when the file includes both optical and dielectric properties
    handles.complex_permittivity = file_imported(:,4) - 1j*file_imported(:,5); % complex permittivity
else % when the file only include optical properties
    c = 299792458;
    w = 2*pi*handles.f*1e12;
    handles.complex_permittivity = (file_imported(:,2) - 1j*file_imported(:,3)./(2.*w/c/100)).^2; % calculate the complex permittivity from the optical properties
end
UWA_plot(handles.axes1,handles.f,real(handles.complex_permittivity),'normal','b');
xlim(handles.f_range);
ylabel('\epsilon^,');
UWA_plot(handles.axes2,handles.f,-imag(handles.complex_permittivity),'normal','b');
xlabel('Frequency (THz)');ylabel('\epsilon^,^,');
xlim(handles.f_range);
UWA_plot(handles.axes3,real(handles.complex_permittivity(f_range)),...
    -imag(handles.complex_permittivity(f_range)),'normal','.b');
xlabel('\epsilon^,');ylabel('\epsilon^,^,');
set(handles.edit_log, 'String', strcat('Data displayed in the complex space ranges from',{' '},...
    num2str(handles.f_range(1)),{' '},'to',{' '},num2str(handles.f_range(2)),{' '},'THz'))
guidata(hObject,handles);
