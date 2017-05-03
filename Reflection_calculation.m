function varargout = Reflection_calculation(varargin)
% REFLECTION_CALCULATION MATLAB code for Reflection_calculation.fig
%      REFLECTION_CALCULATION, by itself, creates a new REFLECTION_CALCULATION or raises the existing
%      singleton*.
%
%      H = REFLECTION_CALCULATION returns the handle to a new REFLECTION_CALCULATION or the handle to
%      the existing singleton*.
%
%      REFLECTION_CALCULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REFLECTION_CALCULATION.M with the given input arguments.
%
%      REFLECTION_CALCULATION('Property','Value',...) creates a new REFLECTION_CALCULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Reflection_calculation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Reflection_calculation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Reflection_calculation

% Last Modified by GUIDE v2.5 26-Apr-2017 15:30:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Reflection_calculation_OpeningFcn, ...
                   'gui_OutputFcn',  @Reflection_calculation_OutputFcn, ...
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


% --- Executes just before Reflection_calculation is made visible.
function Reflection_calculation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Reflection_calculation (see VARARGIN)

% Choose default command line output for Reflection_calculation
handles.output = hObject;
set( handles.figure1, 'toolbar', 'figure' );
if ~isempty(varargin)
    
handles.td_proc=varargin{1,1};
handles.fd_proc=varargin{1,2};
% axes(handles.axes1);
UWA_plot(handles.axes1,handles.fd_proc.f,handles.fd_proc.sam_amp1./handles.fd_proc.ref_amp1,'normal','b');
ylim([0 1.1]);
xlabel('frequency (THz)');ylabel('reflection');
UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.sam_phase1-handles.fd_proc.ref_phase1,'normal','b');
xlabel('frequency (THz)');ylabel('phase difference');
end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Reflection_calculation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Reflection_calculation_OutputFcn(hObject, eventdata, handles) 
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
calculation_method=get(handles.calculation_method,'Value');
switch ref_material
    case 1
        n_1=2.12; % window 
        n_2=1; % ref
    case 2
        n_1=1; % window 
        n_2=999999; % mirror
    case 3
       n_1=handles.n_ref; % window 
       n_2=1; % ref
end

polarization= get(handles.polarization,'Value');
if polarization==1 % S/P mixed
    [f_range,n_sample,alpha_sample,e_sample]=UWA_reflection_jepsen(handles.fd_proc,n_1,n_2);
else if polarization==2 % S polarized
        switch calculation_method
            case 1 % S optimiaztion
%                 [f_range, n_sample, alpha_sample, e_sample]=UWA_reflection(handles.fd_proc,n_1,n_2);
            case 2 % S analytical
                [f_range, n_sample, alpha_sample, e_sample]=UWA_reflection_s_analytical(handles.fd_proc,n_1,n_2);
        end
    else % P polarized
        switch calculation_method
            case 1 % P optimiaztion
            case 2 % P analytical
                [f_range, n_sample, alpha_sample, e_sample]=UWA_reflection_p_analytical(handles.fd_proc,n_1,n_2);
        end
    end
    
end
    

    

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
UWA_plot(handles.axes7,handles.fd_proc.f(f_range),-imag(e_sample),'normal','b');
xlabel('frequency (THz)');ylabel('\epsilon^,^,');
xlim([0.15 5]);
handles.result=[handles.fd_proc.f(f_range), n_sample,alpha_sample,real(e_sample),imag(e_sample)];

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


% --- Executes on selection change in polarization.
function polarization_Callback(hObject, eventdata, handles)
% hObject    handle to polarization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns polarization contents as cell array
%        contents{get(hObject,'Value')} returns selected item from polarization


% --- Executes during object creation, after setting all properties.
function polarization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to polarization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate logo
% [i,map,alpha] = imread('C:\Users\00074118\Dropbox\UWA THz Group\Matlab Code\Spectroscopy\Picture1.png','BackgroundColor',[0.941,0.941,0.941]);
[i,map,alpha] = imread('THOT_logo.png','BackgroundColor',[0.941,0.941,0.941]);
axes(hObject);
imshow(i)
