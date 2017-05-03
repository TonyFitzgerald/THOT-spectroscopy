function [ sse,rsquare,dfe,adjrsquare,rmse ] = gofstatistics( fo,fp,n )
% Goodness-of-fit statistics, returned as the gof structure including the fields in the output.
% fo: observed values.
% fp: predicted values from the observed.
% n: the number of the model parameters
sse = sum(abs(fp-fo).^2); % Total Sum of squares due to error
sst = sum(abs(fp-mean(fo)).^2); % Total sum of squares
rsquare = 1-sse/sst;    % R-squared (coefficient of determination)
adjrsquare = 1 - (1-rsquare)*(length(fo)-1)/(length(fo)-n);%Degree-of-freedom adjusted coefficient of determination
dfe = length(fo)-n;                % Degrees of freedom in the error
rmse = sqrt(sse)/length(fo); % Root mean squared error (standard error)
end

