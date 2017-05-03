function UWA_disp_fit_result( handles_edit_box, model, parameters, goodness )
% Display fitting results in the Edit Box
%   Detailed explanation goes here
switch model
    case 'DoubleDebye'
        line1 = 'Model:';
        line2 = 'epsilon_r = epsilon_infty+(epsilon_s-epsilon_2)/(1+j*omega*tau_1)+(epsilon_2-epsilon_infty)/(1+j*omega*tau_2)';
        line3 = 'Parameters:';
        line4 = sprintf('\\epsilon_s = %2.1f', parameters.epsilon_s);
        line5 = sprintf('\\epsilon_2 = %2.1f', parameters.epsilon_2);
        line6 = sprintf('\\epsilon_infty = %2.1f', parameters.epsilon_infty);
        line7 = sprintf('\\tau_1 = %2.1f', parameters.tau_1);
        line8 = sprintf('\\tau_2 = %2.1f', parameters.tau_2);
        line9 = 'Goodness-of-fit:';
        line10 = sprintf('sse: %2.2f',goodness.sse);
        line11 = sprintf('rsquare: %2.2f',goodness.rsquare);
        line12 = sprintf('dfe: %2.0f',goodness.dfe);
        line13 = sprintf('adjrsquare: %2.2f',goodness.adjrsquare);
        line14 = sprintf('rmse: %2.2f',goodness.rmse);
        all_lines = {'',line1,line2,'',line3,line4,line5,line6,line7,line8,'',...
            line9,line10,line11,line12,line13,line14};
        currString = get(handles_edit_box,'String');      
        currString(end+1:end+length(all_lines)) = all_lines;
        set(handles_edit_box,'String',currString)
end
end

