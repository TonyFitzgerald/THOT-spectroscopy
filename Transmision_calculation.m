function varargout = Transmision_calculation(varargin)
% TRANSMISION_CALCULATION MATLAB code for Transmision_calculation.fig
%      TRANSMISION_CALCULATION, by itself, creates a new TRANSMISION_CALCULATION or raises the existing
%      singleton*.
%
%      H = TRANSMISION_CALCULATION returns the handle to a new TRANSMISION_CALCULATION or the handle to
%      the existing singleton*.
%
%      TRANSMISION_CALCULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSMISION_CALCULATION.M with the given input arguments.
%
%      TRANSMISION_CALCULATION('Property','Value',...) creates a new TRANSMISION_CALCULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Transmision_calculation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Transmision_calculation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Transmision_calculation

% Last Modified by GUIDE v2.5 26-Apr-2017 15:20:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Transmision_calculation_OpeningFcn, ...
                   'gui_OutputFcn',  @Transmision_calculation_OutputFcn, ...
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


% --- Executes just before Transmision_calculation is made visible.
function Transmision_calculation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Transmision_calculation (see VARARGIN)

% Choose default command line output for Transmision_calculation
handles.output = hObject;
set( handles.figure1, 'toolbar', 'figure' );
if ~isempty(varargin)
    
handles.td_proc=varargin{1,1};
handles.fd_proc=varargin{1,2};
% axes(handles.axes1);
UWA_plot(handles.axes1,handles.fd_proc.f,handles.fd_proc.sam_amp1./handles.fd_proc.ref_amp1,'normal','b');
ylim([0 1.1]);
xlabel('frequency (THz)');ylabel('transmission');
UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.sam_phase1-handles.fd_proc.ref_phase1,'normal','b');
xlabel('frequency (THz)');ylabel('phase difference');
end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Transmision_calculation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Transmision_calculation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=length(handles.td_proc.t);
tt=0:s-1;
HF=get(handles.slider1,'Value');
LF=get(handles.slider2,'Value');
% LF=1024;
up  = 1/HF.*exp(-((tt - (s/2)).^2)/(HF.^2) )';
down = 1/LF.*exp(-((tt - (s/2)).^2)/(LF.^2) )';
filter=up-down;
impulse=ifft(fft(filter).*fft(handles.td_proc.sam1)./fft(handles.td_proc.ref1));
UWA_plot(handles.axes3,handles.td_proc.t,impulse,'normal','b');



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
pushbutton4_Callback(handles.slider1,eventdata,handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
pushbutton4_Callback(handles.slider2,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in calculate_index.
function calculate_index_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ref_material=get(handles.ref_refractive_index,'Value');
switch ref_material
    case 1
        n_ref=2.12;
    case 2
        n_ref=1;
    case 3
       n_ref=handles.n_ref; 
end
switch get(handles.calculation_method,'Value')
    case 1
[n_sample,alpha_sample,e_sample]=UWA_transmission_analytical(handles.fd_proc,n_ref,str2double(get(handles.edit1,'String'))*10^-6);
UWA_plot(handles.axes4,handles.fd_proc.f,n_sample,'normal','b');
xlim([0.15 5]);
ylim([1 5]);
xlabel('frequency (THz)');ylabel('refractive index');
UWA_plot(handles.axes5,handles.fd_proc.f,alpha_sample,'normal','b');
xlim([0.15 5]);
xlabel('frequency (THz)');ylabel('absorption coefficient (cm^-^1)');
UWA_plot(handles.axes6,handles.fd_proc.f,real(e_sample),'normal','b');
xlim([0.15 5]);
xlabel('frequency (THz)');ylabel('\epsilon^,');
UWA_plot(handles.axes7,handles.fd_proc.f,imag(e_sample),'normal','b');
xlabel('frequency (THz)');ylabel('\epsilon^,^,');
xlim([0.15 5]);
handles.result=[handles.fd_proc.f, n_sample,alpha_sample,real(e_sample),imag(e_sample)];
    case 2
[f_range, n_sample, alpha_sample, e_sample]=UWA_transmission_optimization(handles.fd_proc,n_ref,str2double(get(handles.edit1,'String'))*10^-6);
UWA_plot(handles.axes4,handles.fd_proc.f(f_range),n_sample,'normal','b');
xlim([0.15 5]);
ylim([1 5]);
xlabel('frequency (THz)');ylabel('refractive index');
UWA_plot(handles.axes5,handles.fd_proc.f(f_range),alpha_sample,'normal','b');
xlim([0.15 5]);
xlabel('frequency (THz)');ylabel('absorption coefficient (cm^-^1)');
UWA_plot(handles.axes6,handles.fd_proc.f(f_range),real(e_sample),'normal','b');
xlim([0.15 5]);
xlabel('frequency (THz)');ylabel('\epsilon^,');
UWA_plot(handles.axes7,handles.fd_proc.f(f_range),imag(e_sample),'normal','b');
xlabel('frequency (THz)');ylabel('\epsilon^,^,');
xlim([0.15 5]);
handles.result=[handles.fd_proc.f(f_range), n_sample,alpha_sample,real(e_sample),imag(e_sample)];
end


guidata(hObject, handles);




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ref_refractive_index.
function ref_refractive_index_Callback(hObject, eventdata, handles)
% hObject    handle to ref_refractive_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ref_refractive_index contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ref_refractive_index
switch get(hObject,'Value')
    case 3
        Import_Reference_Refractive_Index_Callback(handles.ref_refractive_index,eventdata,handles);
end

% --- Executes during object creation, after setting all properties.
function ref_refractive_index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_refractive_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Import_Reference_Refractive_Index_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Reference_Refractive_Index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ref_refractive_index,'Value',3);
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the reference material');
file_selected=horzcat(PathName,FileName);
file_imported=dlmread(file_selected,',');
handles.n_ref=file_imported(:,2);
guidata(hObject,handles);


% --------------------------------------------------------------------
function Export_Result_Callback(hObject, eventdata, handles)
% hObject    handle to Export_Result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data_export=handles.result;
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');


% --------------------------------------------------------------------
function Fitting_Callback(hObject, eventdata, handles)
% hObject    handle to Fitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Model_fitting(handles.result);

% --- Executes on selection change in calculation_method.
function calculation_method_Callback(hObject, eventdata, handles)
% hObject    handle to calculation_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns calculation_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from calculation_method


% --- Executes during object creation, after setting all properties.
function calculation_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calculation_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Import_Reference_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the reference');
file_selected=horzcat(PathName,FileName);
[handles.fd_proc.f, handles.fd_proc.ref_amp1, handles.fd_proc.ref_phase1]=UWA_csvread_freq(file_selected);
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the sample');
file_selected=horzcat(PathName,FileName);
[handles.fd_proc.f, handles.fd_proc.sam_amp1, handles.fd_proc.sam_phase1]=UWA_csvread_freq(file_selected);
UWA_plot(handles.axes1,handles.fd_proc.f,handles.fd_proc.sam_amp1./handles.fd_proc.ref_amp1,'normal','b');
ylim([0 1.1]);
xlabel('frequency (THz)');ylabel('transmission');
UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.sam_phase1-handles.fd_proc.ref_phase1,'normal','b');
xlabel('frequency (THz)');ylabel('phase difference');
guidata(hObject,handles);

% --------------------------------------------------------------------
function Import_Sample_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the reference');
file_selected=horzcat(PathName,FileName);
[handles.fd.f, handles.fd.sam_amp1, handles.fd.sam_phase1]=UWA_csvread_freq(file_selected);
guidata(hObject,handles);
