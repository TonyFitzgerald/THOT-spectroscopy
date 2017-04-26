function f = Jepsen_error_function(x,R,n1,n2,config)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
phi = config(3);     % angle of incidence
alpha = config(2);   % polarisation angle of the incident wave
delta = config(1);   % elevation angle
n3 = x(1)-1j*x(2);

%% Reflection and transmission coefficients; 1 is air; 2 is quartz; 3 is sample.
%rp12 = (-n2^2*cos(phi)+sqrt(n2^2-sin(phi)^2))/(n2^2*cos(phi)+sqrt(n2^2-sin(phi)^2)); % reflection coeficient of the p-polarisation component at the interface of air and quartz
%rs12 = (cos(phi)-sqrt(n2^2-sin(phi)^2))/(cos(phi)+sqrt(n2^2-sin(phi)^2));   % reflection coeficient of the p-polarisation component at the interface of air and quartz
tp12 = (2*cos(phi))/(n2*cos(phi)+sqrt(1-sin(phi)^2/n2^2));
ts12 = (2*cos(phi))/(cos(phi)+n2*sqrt(1-sin(phi)^2/n2^2));
tp21 = (2*n2*sqrt(1-sin(phi)^2/n2^2))/(n2*cos(phi)+sqrt(1-sin(phi)^2/n2^2));
ts21 = (2*n2*sqrt(1-sin(phi)^2/n2^2))/(cos(phi)+n2*sqrt(1-sin(phi)^2/n2^2));
rp23_sam = (-n3.^2*sqrt(n2^2-sin(phi)^2)+n2^2*sqrt(n3.^2-sin(phi)^2))./...
    (n3.^2*sqrt(n2^2-sin(phi)^2)+n2^2*sqrt(n3.^2-sin(phi)^2));
rs23_sam = (sqrt(n2^2-sin(phi)^2)-sqrt(n3.^2-sin(phi)^2))./...
    (sqrt(n2^2-sin(phi)^2)+sqrt(n3.^2-sin(phi)^2));
rp23_air = (-n1.^2*sqrt(n2^2-sin(phi)^2)+n2^2*sqrt(n1.^2-sin(phi)^2))./...
    (n1.^2*sqrt(n2^2-sin(phi)^2)+n2^2*sqrt(n1.^2-sin(phi)^2));
rs23_air = (sqrt(n2^2-sin(phi)^2)-sqrt(n1.^2-sin(phi)^2))./...
    (sqrt(n2^2-sin(phi)^2)+sqrt(n1.^2-sin(phi)^2));

%% Calculate the ratios of the electric field reflected from the window-sample interface and the air-window interface.
% Eref = (rp12-rs12).*cos(alpha)-(rp12+rs12).*cos(alpha-2*delta);
r1 = 0.5*((rp23_sam.*tp12.*tp21-rs23_sam.*ts12.*ts21)*cos(alpha)-(rp23_sam.*tp12.*tp21+rs23_sam.*ts12.*ts21)*cos(alpha-2*delta));
if n2==1
    r2=1;
else
r2 = 0.5*((rp23_air.*tp12.*tp21-rs23_air.*ts12.*ts21)*cos(alpha)-(rp23_air.*tp12.*tp21+rs23_air.*ts12.*ts21)*cos(alpha-2*delta));
end
% r1 = (rp23_sam.*tp12.*tp21-rs23_sam.*ts12.*ts21)*sin(alpha)+(rp23_sam.*tp12.*tp21+rs23_sam.*ts12.*ts21)*sin(alpha-2*delta);
% r2 = (rp23_air.*tp12.*tp21-rs23_air.*ts12.*ts21)*sin(alpha)+(rp23_air.*tp12.*tp21+rs23_air.*ts12.*ts21)*sin(alpha-2*delta);
R0 = r1/r2;
f = (real(R)-real(R0))^2+(imag(R)-imag(R0))^2;

end

