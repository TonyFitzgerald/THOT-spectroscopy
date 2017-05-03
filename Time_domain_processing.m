function varargout = Time_domain_processing(varargin)
% TIME_DOMAIN_PROCESSING MATLAB code for Time_domain_processing.fig
%      TIME_DOMAIN_PROCESSING, by itself, creates a new TIME_DOMAIN_PROCESSING or raises the existing
%      singleton*.
%
%      H = TIME_DOMAIN_PROCESSING returns the handle to a new TIME_DOMAIN_PROCESSING or the handle to
%      the existing singleton*.
%
%      TIME_DOMAIN_PROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIME_DOMAIN_PROCESSING.M with the given input arguments.
%
%      TIME_DOMAIN_PROCESSING('Property','Value',...) creates a new TIME_DOMAIN_PROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Time_domain_processing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Time_domain_processing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Time_domain_processing

% Last Modified by GUIDE v2.5 03-May-2017 11:46:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Time_domain_processing_OpeningFcn, ...
                   'gui_OutputFcn',  @Time_domain_processing_OutputFcn, ...
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


% --- Executes just before Time_domain_processing is made visible.
function Time_domain_processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Time_domain_processing (see VARARGIN)

% Choose default command line output for Time_domain_processing
handles.output = hObject;
% initiallize axes labels
% xlabel(handles.axes1,'time (ps)');
% xlabel(handles.axes4,'time (ps)');
% xlabel(handles.axes2,'frequency (THz)');
% xlabel(handles.axes3,'frequency (THz)');
% xlabel(handles.axes5,'frequency (THz)');
% xlabel(handles.axes6,'frequency (THz)');
% 
% ylabel(handles.axes1,'signal (a.u.)');
% ylabel(handles.axes4,'signal (a.u.)');
% ylabel(handles.axes2,'amplitude (a.u.)');
% ylabel(handles.axes3,'phase (^o)');
% ylabel(handles.axes5,'amplitude (a.u.)');
% ylabel(handles.axes6,'phase (^o)');

% initiallize popupmenus
Window_option={'None','Gaussian','Double Gaussian Filter'};
set(handles.Window_ref,'string',Window_option);
set(handles.Window_sam,'string',Window_option);
%initiallize sliders
set(handles.slider1,'Min',1);
set(handles.slider1,'Max',100);
set(handles.slider1,'Value',1);

set(handles.slider3,'Min',1);
set(handles.slider3,'Max',100);
set(handles.slider3,'Value',1);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Time_domain_processing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Time_domain_processing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Import_Reference_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the reference');
file_selected=horzcat(PathName,FileName);
[handles.td.t, handles.td.ref]=UWA_csvread(file_selected);
[handles.fd.f,handles.fd.ref_amp,handles.fd.ref_phase]=UWA_FFT(handles.td.t,handles.td.ref);
set(handles.ref_start1,'String',num2str(handles.td.t(1)));
set(handles.ref_end1,'String',num2str(handles.td.t(end)));
UWA_plot(handles.axes1,handles.td.t,handles.td.ref);xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');

UWA_plot(handles.axes2,handles.fd.f,handles.fd.ref_amp,'semilogy');xlabel(handles.axes2,'frequency (THz)');ylabel(handles.axes2,'amplitude (a.u.)');
UWA_plot(handles.axes3,handles.fd.f,handles.fd.ref_phase);xlabel(handles.axes3,'frequency (THz)');ylabel(handles.axes3,'phase (^o)');

guidata(hObject, handles);




% --------------------------------------------------------------------
function Import_Sample_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('.csv','All Files (*.*)','Select the sample');
file_selected=horzcat(PathName,FileName);
[handles.td.t, handles.td.sam]=UWA_csvread(file_selected);
[handles.fd.f,handles.fd.sam_amp,handles.fd.sam_phase]=UWA_FFT(handles.td.t,handles.td.sam);
set(handles.sam_start1,'String',num2str(handles.td.t(1)));
set(handles.sam_end1,'String',num2str(handles.td.t(end)));
UWA_plot(handles.axes4,handles.td.t,handles.td.sam);xlabel(handles.axes4,'time (ps)');ylabel(handles.axes4,'signal (a.u.)');
UWA_plot(handles.axes5,handles.fd.f,handles.fd.sam_amp,'semilogy');xlabel(handles.axes5,'frequency (THz)');ylabel(handles.axes5,'amplitude (a.u.)');
UWA_plot(handles.axes6,handles.fd.f,handles.fd.sam_phase);xlabel(handles.axes6,'frequency (THz)');ylabel(handles.axes6,'phase (^o)');

guidata(hObject, handles);

% --------------------------------------------------------------------
function Export_Time_Domain_Callback(hObject, eventdata, handles)
% hObject    handle to Export_Time_Domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Export_Frequency_Domain_Callback(hObject, eventdata, handles)
% hObject    handle to Export_Frequency_Domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Raw_Reference_freq_Callback(hObject, eventdata, handles)
% hObject    handle to Raw_Reference_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data_export=[handles.fd.f,handles.fd.ref_amp,handles.fd.ref_phase];
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');


% --------------------------------------------------------------------
function Raw_Sample_freq_Callback(hObject, eventdata, handles)
% hObject    handle to Raw_Sample_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Data_export=[handles.fd.f,handles.fd.sam_amp,handles.fd.sam_phase];
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');

% --------------------------------------------------------------------
function Processed_Reference_freq_Callback(hObject, eventdata, handles)
% hObject    handle to Processed_Reference_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.checkbox1,'Value')
    case 0
Data_export=[handles.fd_proc.f,handles.fd_proc.ref_amp1,handles.fd_proc.ref_phase1];
    case 1
        Data_export=[handles.fd_proc.f,handles.fd_proc.ref_amp1,handles.fd_proc.ref_phase1,...
            handles.fd_proc.ref_amp2,handles.fd_proc.ref_phase2];
end
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');

% --------------------------------------------------------------------
function Processed_Sample_freq_Callback(hObject, eventdata, handles)
% hObject    handle to Processed_Sample_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.checkbox2,'Value')
    case 0
Data_export=[handles.fd_proc.f,handles.fd_proc.sam_amp1,handles.fd_proc.sam_phase1];
    case 1
        Data_export=[handles.fd_proc.f,handles.fd_proc.sam_amp1,handles.fd_proc.sam_phase1,...
            handles.fd_proc.sam_amp2,handles.fd_proc.sam_phase2];
end
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Window_sam_Callback(handles.slider3,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Import_Sample.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function sam_start1_Callback(hObject, eventdata, handles)
% hObject    handle to sam_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sam_start1 as text
%        str2double(get(hObject,'String')) returns contents of sam_start1 as a double
Window_sam_Callback(handles.sam_start1,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sam_start1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sam_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sam_end1_Callback(hObject, eventdata, handles)
% hObject    handle to sam_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sam_end1 as text
%        str2double(get(hObject,'String')) returns contents of sam_end1 as a double
Window_sam_Callback(handles.sam_end1,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sam_end1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sam_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sam_start2_Callback(hObject, eventdata, handles)
% hObject    handle to sam_start2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sam_start2 as text
%        str2double(get(hObject,'String')) returns contents of sam_start2 as a double

Window_sam_Callback(handles.sam_start2,eventdata,handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sam_start2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sam_start2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sam_end2_Callback(hObject, eventdata, handles)
% hObject    handle to sam_end2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sam_end2 as text
%        str2double(get(hObject,'String')) returns contents of sam_end2 as a double
Window_sam_Callback(handles.sam_end2,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sam_end2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sam_end2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Window_sam.
function Window_sam_Callback(hObject, eventdata, handles)
% hObject    handle to Window_sam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Window_sam contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Window_sam
win.sam_start1=str2double(get(handles.sam_start1,'String'));
win.sam_end1=str2double(get(handles.sam_end1,'String'));
if get(handles.checkbox2,'Value')==1;
    win.sam_start2=str2double(get(handles.sam_start2,'String'));
    win.sam_end2=str2double(get(handles.sam_end2,'String'));
end

filter_selection=get(handles.Window_sam,'Value');
switch filter_selection
    case 1
        set(handles.text9,'Enable','off');
        set(handles.slider3,'Enable','off');
        handles.td_proc.t=handles.td.t;
        filt_func1=rectwin(length(handles.td_proc.t));
        handles.td_proc.sam1=UWA_window_filter([win.sam_start1, win.sam_end1],filt_func1,handles.td.t,handles.td.sam);
        [handles.fd_proc.f,handles.fd_proc.sam_amp1,handles.fd_proc.sam_phase1]=UWA_FFT(handles.td_proc.t,handles.td_proc.sam1);
       
        if get(handles.checkbox2,'Value')==0;
            UWA_plot(handles.axes4,handles.td_proc.t,handles.td_proc.sam1,'normal','b');xlabel(handles.axes4,'time (ps)');ylabel(handles.axes4,'signal (a.u.)');
            UWA_plot(handles.axes5,handles.fd_proc.f,handles.fd_proc.sam_amp1,'semilogy','b');xlabel(handles.axes5,'frequency (THz)');ylabel(handles.axes5,'amplitude (a.u.)');
            UWA_plot(handles.axes6,handles.fd_proc.f,handles.fd_proc.sam_phase1,'normal','b');xlabel(handles.axes6,'frequency (THz)');ylabel(handles.axes6,'phase (^o)');
            
        else
            handles.td_proc.sam2=UWA_window_filter([win.sam_start2, win.sam_end2],filt_func1,handles.td.t,handles.td.sam);
            [handles.fd_proc.f,handles.fd_proc.sam_amp2,handles.fd_proc.sam_phase2]=UWA_FFT(handles.td_proc.t,handles.td_proc.sam2);
            sam_pulse1_range=handles.td_proc.t>=win.sam_start1&handles.td_proc.t<=win.sam_end1;
            sam_pulse2_range=handles.td_proc.t>=win.sam_start2&handles.td_proc.t<=win.sam_end2;
            UWA_plot(handles.axes4,handles.td_proc.t(sam_pulse1_range),handles.td_proc.sam1(sam_pulse1_range),'normal','b');
            hold on
            UWA_plot(handles.axes4,handles.td_proc.t(sam_pulse2_range),handles.td_proc.sam2(sam_pulse2_range),'normal','r');xlabel(handles.axes4,'time (ps)');ylabel(handles.axes4,'signal (a.u.)');
            hold off
            UWA_plot(handles.axes5,handles.fd_proc.f,handles.fd_proc.sam_amp1,'semilogy','b');xlabel(handles.axes5,'frequency (THz)');ylabel(handles.axes5,'amplitude (a.u.)');
            hold on
            UWA_plot(handles.axes5,handles.fd_proc.f,handles.fd_proc.sam_amp2,'semilogy','r');
            hold off
            UWA_plot(handles.axes6,handles.fd_proc.f,handles.fd_proc.sam_phase1,'normal','b');xlabel(handles.axes6,'frequency (THz)');ylabel(handles.axes6,'phase (^o)');
            hold on
            UWA_plot(handles.axes6,handles.fd_proc.f,handles.fd_proc.sam_phase2,'normal','r');
            hold off
        end
    case 2
        set(handles.text9,'Enable','on');
        set(handles.slider3,'Enable','on');
        handles.td_proc.t=handles.td.t;
        filt_func1=rectwin(length(handles.td_proc.t));
        handles.td_proc.sam1=UWA_window_filter([win.sam_start1, win.sam_end1],filt_func1,handles.td.t,handles.td.sam);
        alpha=get(handles.slider3,'Value');
        filt_temp=gausswin(length(handles.td_proc.t),alpha);
        
            [~,peak_filter1]=max(filt_temp);
            [~,peak_signal1]=max(abs(handles.td_proc.sam1));
            filter_move1=peak_signal1-peak_filter1;
            filt_func1=zeros(size(filt_temp));
            if filter_move1>=0
                filt_func1(filter_move1+1:end)=filt_temp(1:end-filter_move1);
            else
                filt_func1(1:end+filter_move1)=filt_temp(-filter_move1+1:end);
            end
            handles.td_proc.sam1=UWA_window_filter([win.sam_start1, win.sam_end1],filt_func1,handles.td.t,handles.td.sam);
            [handles.fd_proc.f,handles.fd_proc.sam_amp1,handles.fd_proc.sam_phase1]=UWA_FFT(handles.td_proc.t,handles.td_proc.sam1);
        if get(handles.checkbox2,'Value')==0
            UWA_plot(handles.axes4,handles.td_proc.t,handles.td_proc.sam1,'normal','b');
            axes(handles.axes4);
            hold on
            %          UWA_plot(handles.axes1,handles.td_proc.t,handles.td.sam,'normal','b');
            UWA_plot(handles.axes4,handles.td_proc.t(filt_func1~=0),filt_func1(filt_func1~=0),'normal','k--');xlabel(handles.axes4,'time (ps)');ylabel(handles.axes4,'signal (a.u.)');
            hold off
            UWA_plot(handles.axes5,handles.fd_proc.f,handles.fd_proc.sam_amp1,'semilogy','b');xlabel(handles.axes5,'frequency (THz)');ylabel(handles.axes5,'amplitude (a.u.)');
            UWA_plot(handles.axes6,handles.fd_proc.f,handles.fd_proc.sam_phase1,'normal','b');xlabel(handles.axes6,'frequency (THz)');ylabel(handles.axes6,'phase (^o)');
        else
           
        filt_func2=rectwin(length(handles.td_proc.t));
        handles.td_proc.sam2=UWA_window_filter([win.sam_start2, win.sam_end2],filt_func2,handles.td.t,handles.td.sam);
            [~,peak_filter2]=max(filt_temp);
            [~,peak_signal2]=max(abs(handles.td_proc.sam2));
            filter_move2=peak_signal2-peak_filter2;
            filt_func2=zeros(size(filt_temp));
            if filter_move2>=0
                filt_func2(filter_move2+1:end)=filt_temp(1:end-filter_move2);
            else
                filt_func2(1:end+filter_move2)=filt_temp(-filter_move2+1:end);
            end
            handles.td_proc.sam2=UWA_window_filter([win.sam_start2, win.sam_end2],filt_func2,handles.td.t,handles.td.sam);
            [handles.fd_proc.f,handles.fd_proc.sam_amp2,handles.fd_proc.sam_phase2]=UWA_FFT(handles.td_proc.t,handles.td_proc.sam2);
            sam_pulse1_range=handles.td_proc.t>=win.sam_start1&handles.td_proc.t<=win.sam_end1;
            sam_pulse2_range=handles.td_proc.t>=win.sam_start2&handles.td_proc.t<=win.sam_end2;
            UWA_plot(handles.axes4,handles.td_proc.t(sam_pulse1_range),handles.td_proc.sam1(sam_pulse1_range),'normal','b');
            hold on
            UWA_plot(handles.axes4,handles.td_proc.t(sam_pulse2_range),handles.td_proc.sam2(sam_pulse2_range),'normal','r');
            UWA_plot(handles.axes4,handles.td_proc.t(filt_func1~=0),filt_func1(filt_func1~=0),'normal','k--');
             UWA_plot(handles.axes4,handles.td_proc.t(filt_func2~=0),filt_func2(filt_func2~=0),'normal','k--');xlabel(handles.axes4,'time (ps)');ylabel(handles.axes4,'signal (a.u.)');
            hold off
            UWA_plot(handles.axes5,handles.fd_proc.f,handles.fd_proc.sam_amp1,'semilogy','b');
            hold on
            UWA_plot(handles.axes5,handles.fd_proc.f,handles.fd_proc.sam_amp2,'semilogy','r');xlabel(handles.axes5,'frequency (THz)');ylabel(handles.axes5,'amplitude (a.u.)');
            hold off
            UWA_plot(handles.axes6,handles.fd_proc.f,handles.fd_proc.sam_phase1,'normal','b');
            hold on
            UWA_plot(handles.axes6,handles.fd_proc.f,handles.fd_proc.sam_phase2,'normal','r');xlabel(handles.axes6,'frequency (THz)');ylabel(handles.axes6,'phase (^o)');
            hold off
        end
        
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Window_sam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_sam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Window_ref.
function Window_ref_Callback(hObject, eventdata, handles)
% hObject    handle to Window_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Window_ref contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Window_ref

win.ref_start1=str2double(get(handles.ref_start1,'String'));
win.ref_end1=str2double(get(handles.ref_end1,'String'));
if get(handles.checkbox1,'Value')==1;
    win.ref_start2=str2double(get(handles.ref_start2,'String'));
    win.ref_end2=str2double(get(handles.ref_end2,'String'));
end
filter_selection=get(handles.Window_ref,'Value');
switch filter_selection
    case 1
         set(handles.text8,'Enable','off');
        set(handles.slider1,'Enable','off');
        
        
        handles.td_proc.t=handles.td.t;
        filt_func1=rectwin(length(handles.td_proc.t));
        handles.td_proc.ref1=UWA_window_filter([win.ref_start1, win.ref_end1],filt_func1,handles.td.t,handles.td.ref);
        [handles.fd_proc.f,handles.fd_proc.ref_amp1,handles.fd_proc.ref_phase1]=UWA_FFT(handles.td_proc.t,handles.td_proc.ref1);
        if get(handles.checkbox1,'Value')==0;
            UWA_plot(handles.axes1,handles.td_proc.t,handles.td_proc.ref1,'normal','b');xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');
            UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.ref_amp1,'semilogy','b');xlabel(handles.axes2,'frequency (THz)');ylabel(handles.axes2,'amplitude (a.u.)');
            UWA_plot(handles.axes3,handles.fd_proc.f,handles.fd_proc.ref_phase1,'normal','b');
            
        else
            handles.td_proc.ref2=UWA_window_filter([win.ref_start2, win.ref_end2],filt_func1,handles.td.t,handles.td.ref);
            [handles.fd_proc.f,handles.fd_proc.ref_amp2,handles.fd_proc.ref_phase2]=UWA_FFT(handles.td_proc.t,handles.td_proc.ref2);
            ref_pulse1_range=handles.td_proc.t>=win.ref_start1&handles.td_proc.t<=win.ref_end1;
            ref_pulse2_range=handles.td_proc.t>=win.ref_start2&handles.td_proc.t<=win.ref_end2;
            UWA_plot(handles.axes1,handles.td_proc.t(ref_pulse1_range),handles.td_proc.ref1(ref_pulse1_range),'normal','b');xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');
            hold on
            UWA_plot(handles.axes1,handles.td_proc.t(ref_pulse2_range),handles.td_proc.ref2(ref_pulse2_range),'normal','r');xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');
             
            hold off
            UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.ref_amp1,'semilogy','b');
            hold on
            UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.ref_amp2,'semilogy','r');xlabel(handles.axes2,'frequency (THz)');ylabel(handles.axes2,'amplitude (a.u.)');
            hold off
            UWA_plot(handles.axes3,handles.fd_proc.f,handles.fd_proc.ref_phase1,'normal','b');xlabel(handles.axes3,'frequency (THz)');ylabel(handles.axes3,'phase (^o)');
            hold on
            UWA_plot(handles.axes3,handles.fd_proc.f,handles.fd_proc.ref_phase2,'normal','r');
            hold off
        end
    case 2
        set(handles.text8,'Enable','on');
        set(handles.slider1,'Enable','on');
        handles.td_proc.t=handles.td.t;
        filt_func1=rectwin(length(handles.td_proc.t));
        handles.td_proc.ref1=UWA_window_filter([win.ref_start1, win.ref_end1],filt_func1,handles.td.t,handles.td.ref);
        alpha=get(handles.slider1,'Value');
        filt_temp=gausswin(length(handles.td_proc.t),alpha);
        [~,peak_filter]=max(filt_temp);
        [~,peak_signal]=max(abs(handles.td_proc.ref1));
        filter_move=peak_signal-peak_filter;
        filt_func1=zeros(size(filt_temp));
        if filter_move>=0
            filt_func1(filter_move+1:end)=filt_temp(1:end-filter_move);
        else
            filt_func1(1:end+filter_move)=filt_temp(-filter_move+1:end);
        end
        handles.td_proc.ref1=UWA_window_filter([win.ref_start1, win.ref_end1],filt_func1,handles.td.t,handles.td.ref);
        [handles.fd_proc.f,handles.fd_proc.ref_amp1,handles.fd_proc.ref_phase1]=UWA_FFT(handles.td_proc.t,handles.td_proc.ref1);
        if get(handles.checkbox1,'Value')==0
            UWA_plot(handles.axes1,handles.td_proc.t,handles.td_proc.ref1,'normal','b');xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');
            axes(handles.axes1);
            hold on
            %          UWA_plot(handles.axes1,handles.td_proc.t,handles.td.ref,'normal','b');
            UWA_plot(handles.axes1,handles.td_proc.t(filt_func1~=0),filt_func1(filt_func1~=0),'normal','k--');xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');
            hold off
            UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.ref_amp1,'semilogy','b');xlabel(handles.axes2,'frequency (THz)');ylabel(handles.axes2,'amplitude (a.u.)');
            UWA_plot(handles.axes3,handles.fd_proc.f,handles.fd_proc.ref_phase1,'normal','b');xlabel(handles.axes3,'frequency (THz)');ylabel(handles.axes3,'phase (^o)');
        else
            
            filt_func2=rectwin(length(handles.td_proc.t));
            handles.td_proc.ref2=UWA_window_filter([win.ref_start2, win.ref_end2],filt_func2,handles.td.t,handles.td.ref);
            [~,peak_filter2]=max(filt_temp);
            [~,peak_signal2]=max(abs(handles.td_proc.ref2));
            filter_move2=peak_signal2-peak_filter2;
            filt_func2=zeros(size(filt_temp));
            if filter_move2>=0
                filt_func2(filter_move2+1:end)=filt_temp(1:end-filter_move2);
            else
                filt_func2(1:end+filter_move2)=filt_temp(-filter_move2+1:end);
            end
            handles.td_proc.ref2=UWA_window_filter([win.ref_start2, win.ref_end2],filt_func2,handles.td.t,handles.td.ref);
            [handles.fd_proc.f,handles.fd_proc.ref_amp2,handles.fd_proc.ref_phase2]=UWA_FFT(handles.td_proc.t,handles.td_proc.ref2);
            ref_pulse1_range=handles.td_proc.t>=win.ref_start1&handles.td_proc.t<=win.ref_end1;
            ref_pulse2_range=handles.td_proc.t>=win.ref_start2&handles.td_proc.t<=win.ref_end2;
            UWA_plot(handles.axes1,handles.td_proc.t(ref_pulse1_range),handles.td_proc.ref1(ref_pulse1_range),'normal','b');
            hold on
            UWA_plot(handles.axes1,handles.td_proc.t(ref_pulse2_range),handles.td_proc.ref2(ref_pulse2_range),'normal','r');
             UWA_plot(handles.axes1,handles.td_proc.t(filt_func1~=0),filt_func1(filt_func1~=0),'normal','k--');
              UWA_plot(handles.axes1,handles.td_proc.t(filt_func2~=0),filt_func2(filt_func2~=0),'normal','k--');xlabel(handles.axes1,'time (ps)');ylabel(handles.axes1,'signal (a.u.)');
            hold off
            UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.ref_amp1,'semilogy','b');
            hold on
            UWA_plot(handles.axes2,handles.fd_proc.f,handles.fd_proc.ref_amp2,'semilogy','r');xlabel(handles.axes2,'frequency (THz)');ylabel(handles.axes2,'amplitude (a.u.)');
            hold off
            UWA_plot(handles.axes3,handles.fd_proc.f,handles.fd_proc.ref_phase1,'normal','b');
            hold on
            UWA_plot(handles.axes3,handles.fd_proc.f,handles.fd_proc.ref_phase2,'normal','r');xlabel(handles.axes3,'frequency (THz)');ylabel(handles.axes3,'phase (^o)');
            hold off
        end
end
% output=handles;
guidata(hObject, handles);


 

% --- Executes during object creation, after setting all properties.
function Window_ref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_end2_Callback(hObject, eventdata, handles)
% hObject    handle to ref_end2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_end2 as text
%        str2double(get(hObject,'String')) returns contents of ref_end2 as a double
Window_ref_Callback(handles.ref_end2,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ref_end2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_end2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_start2_Callback(hObject, eventdata, handles)
% hObject    handle to ref_start2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_start2 as text
%        str2double(get(hObject,'String')) returns contents of ref_start2 as a double
Window_ref_Callback(handles.ref_start2,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ref_start2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_start2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_end1_Callback(hObject, eventdata, handles)
% hObject    handle to ref_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_end1 as text
%        str2double(get(hObject,'String')) returns contents of ref_end1 as a double
Window_ref_Callback(handles.ref_end1,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ref_end1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_end1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_start1_Callback(hObject, eventdata, handles)
% hObject    handle to ref_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_start1 as text
%        str2double(get(hObject,'String')) returns contents of ref_start1 as a double
Window_ref_Callback(handles.ref_start1,eventdata,handles);
% guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ref_start1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_start1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Import_Reference.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Window_ref_Callback(handles.slider1,eventdata,handles);
% guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function Calculation_Callback(hObject, eventdata, handles)
% hObject    handle to Calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Transmission_Callback(hObject, eventdata, handles)
% hObject    handle to Transmission (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Transmision_calculation(handles.td_proc,handles.fd_proc);


% --------------------------------------------------------------------
function Reflection_Callback(hObject, eventdata, handles)
% hObject    handle to Reflection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Reflection_calculation(handles.td_proc,handles.fd_proc);
% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
Ref_Range2_enable=get(handles.checkbox1,'Value');
switch Ref_Range2_enable
    case 0
        set(handles.text4,'Enable','off');
        set(handles.text5,'Enable','off');
        set(handles.text6,'Enable','off');
        set(handles.ref_start2,'Enable','off');
        set(handles.ref_end2,'Enable','off');
        clear handles.td_proc.ref2 handles.td_proc.sam2 handles.fd_proc.ref_amp2 handles.fd_proc.ref_phase2...
            handles.fd_proc.sam_amp2 handles.fd_proc.sam_phase2;
        
    case 1
        set(handles.text4,'Enable','on');
        set(handles.text5,'Enable','on');
        set(handles.text6,'Enable','on');
        set(handles.ref_start2,'Enable','on');
        set(handles.ref_end2,'Enable','on');
        
end
Window_ref_Callback(handles.uipanel2, eventdata, handles);
% guidata(hObject, handles);


% --- Executes when selected object is changed in uipanel5.
function uipanel5_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel5 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
Sam_Range2_enable=get(handles.checkbox2,'Value');
switch Sam_Range2_enable
    case 0
        set(handles.text14,'Enable','off');
        set(handles.text15,'Enable','off');
        set(handles.text16,'Enable','off');
        set(handles.sam_start2,'Enable','off');
        set(handles.sam_end2,'Enable','off');
        clear handles.td_proc.ref2 handles.td_proc.sam2 handles.fd_proc.ref_amp2 handles.fd_proc.ref_phase2...
            handles.fd_proc.sam_amp2 handles.fd_proc.sam_phase2;
        
    case 1
        set(handles.text14,'Enable','on');
        set(handles.text15,'Enable','on');
        set(handles.text16,'Enable','on');
        set(handles.sam_start2,'Enable','on');
        set(handles.sam_end2,'Enable','on');
        
end
Window_sam_Callback(handles.uipanel5, eventdata, handles);
% guidata(hObject, handles);


% --------------------------------------------------------------------
function Processed_Sample_Callback(hObject, eventdata, handles)
% hObject    handle to Processed_Sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.checkbox2,'Value')
    case 0
Data_export=[handles.td_proc.t,handles.td_proc.sam1];
    case 1
Data_export=[handles.td_proc.t,handles.td_proc.sam1,handles.td_proc.sam2];

end
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');

% --------------------------------------------------------------------
function Processed_Reference_Callback(hObject, eventdata, handles)
% hObject    handle to Processed_Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.checkbox1,'Value')
    case 0
Data_export=[handles.td_proc.t,handles.td_proc.ref1];
    case 1
Data_export=[handles.td_proc.t,handles.td_proc.ref1,handles.td_proc.ref2];

end
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');

% --------------------------------------------------------------------
function Raw_Reference_Callback(hObject, eventdata, handles)
% hObject    handle to Raw_Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data_export=[handles.td.t,handles.td.ref];
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');

% --------------------------------------------------------------------
function Raw_Sample_Callback(hObject, eventdata, handles)
% hObject    handle to Raw_Sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data_export=[handles.td.t,handles.td.sam];
[FileName,Path] = uiputfile('*.csv','Save file name'); %see the doc for uisave
dlmwrite(horzcat(Path,FileName),Data_export,',');


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
Ref_Range2_enable=get(handles.checkbox1,'Value');
switch Ref_Range2_enable
    case 0
        set(handles.text4,'Enable','off');
        set(handles.text5,'Enable','off');
        set(handles.text6,'Enable','off');
        set(handles.ref_start2,'Enable','off');
        set(handles.ref_end2,'Enable','off');
        clear handles.td_proc.ref2 handles.td_proc.sam2 handles.fd_proc.ref_amp2 handles.fd_proc.ref_phase2...
            handles.fd_proc.sam_amp2 handles.fd_proc.sam_phase2;
        
    case 1
        set(handles.text4,'Enable','on');
        set(handles.text5,'Enable','on');
        set(handles.text6,'Enable','on');
        set(handles.ref_start2,'Enable','on');
        set(handles.ref_end2,'Enable','on');
        
end
Window_ref_Callback(handles.uipanel2, eventdata, handles);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
Sam_Range2_enable=get(handles.checkbox2,'Value');
switch Sam_Range2_enable
    case 0
        set(handles.text14,'Enable','off');
        set(handles.text15,'Enable','off');
        set(handles.text16,'Enable','off');
        set(handles.sam_start2,'Enable','off');
        set(handles.sam_end2,'Enable','off');
        clear handles.td_proc.ref2 handles.td_proc.sam2 handles.fd_proc.ref_amp2 handles.fd_proc.ref_phase2...
            handles.fd_proc.sam_amp2 handles.fd_proc.sam_phase2;
        
    case 1
        set(handles.text14,'Enable','on');
        set(handles.text15,'Enable','on');
        set(handles.text16,'Enable','on');
        set(handles.sam_start2,'Enable','on');
        set(handles.sam_end2,'Enable','on');
        
end
Window_sam_Callback(handles.uipanel5, eventdata, handles);
