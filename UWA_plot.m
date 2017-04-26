function UWA_plot(axes_handle, x, y,plot_mode, linestyle)
axes(axes_handle);
% handles.x=x;
% handles.y=y;
if nargin<5
    linestyle='b';
end
if nargin<4
    plot_mode='normal';
end
switch plot_mode
    case 'normal'
        plot(x(10:end),y(10:end),linestyle);
%         set(axes_handle, 'buttondownFcn', {@UWA_plot_ButtonDownFcn, handles});
    case 'semilogy'
        semilogy(x(10:end),y(10:end),linestyle);
%         set(axes_handle, 'buttondownFcn', {@UWA_semilogy_ButtonDownFcn, handles});
end



axis tight

% function UWA_semilogy_ButtonDownFcn(hObject, eventdata,handles)
% % x = handles.x_axes4;
% % y = handles.y_axes4;
% if strcmp(get(gcf, 'selectiontype'), 'open')
%     figure,semilogy(handles.x,handles.y);
% %     xlabel('frequency/THz');
% %     ylabel('amptitude');
% end
% function UWA_plot_ButtonDownFcn(hObject, eventdata,handles)
% % x = handles.x_axes4;
% % y = handles.y_axes4;
% if strcmp(get(gcf, 'selectiontype'), 'open')
%     figure,plot(handles.x,handles.y);
% %     xlabel('frequency/THz');
% %     ylabel('amptitude');
% end