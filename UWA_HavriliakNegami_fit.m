function [ pars, fit_values, stats ] = HavriliakNegami_fit( data,temp )
%BAO TRUONG 2016: Fit data to the double Debye model
%   The matrix of input data has the structure: [frequency, complex
%   permittivity]
e_mea = data(:,2); % the measured complex permittivity
w = 2*pi*data(:,1);
if isempty(temp)
    e_s = 80;
    lb = [1 1 1e-6 1e-6 1e-6]; ub = [inf inf inf 10 1];
else
    e_s = 87.91*exp(-4.58*1e-3*temp);
    lb = [e_s 1 1e-6 1e-6 1e-6]; ub = [e_s inf inf 10 1];
end
option = optimset('fmincon');
option = optimset(option,'Display','off','Algorithm','sqp');
ini = [e_s, 3.5, 8, 1, 1];  
A = [-1 1 0 0 0]; b = 0; Aeq = []; beq = []; nonlcon = [];
[pars,er2,~] = fmincon(@(x) obj_func(x),ini,A,b,Aeq,beq,lb,ub,nonlcon,option);
fit_values = fit2model(pars);
[sse,rsquare,dfe,adjrsquare,rmse] = gofstatistics(e_mea,fit_values,length(pars));
stats = [sse,rsquare,dfe,adjrsquare,rmse];
% Objective Function of the dielectric model
    function f = obj_func(x)        
        e_model = x(2)+(x(1)-x(2))./(1+(1j*w*x(3)).^(1-x(4))).^x(5);
        f = sum(abs(e_model-e_mea).^2);    
    end
    function e_model = fit2model(x)
        e_model = x(2)+(x(1)-x(2))./(1+(1j*w*x(3)).^(1-x(4))).^x(5);
    end
end

