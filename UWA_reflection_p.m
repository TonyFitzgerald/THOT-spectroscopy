function [f_range, n_sam, alpha_sam, e_sam]=UWA_reflection_p(fd_proc,n_1,n_2)
% n_2=1;
f_range=find(fd_proc.f>0&fd_proc.f<=4);
theta_i=sqrt(1-(1/2/n_1)^2); % cos theta topas
theta_air=sqrt(3)/2; % cos theta air
c=299792458; % speed of light in m/s
w=2*pi*fd_proc.f(f_range)*10^12;



R_mag=fd_proc.sam_amp1./fd_proc.ref_amp1;
R_phase=exp(1i*(fd_proc.sam_phase1-fd_proc.ref_phase1));

R=R_mag(f_range).*R_phase(f_range);
A=(n_2*theta_i+n_1*theta_air)/(n_2*theta_i-n_1*theta_air);
X=n_1/theta_i*(A+R)./(A-R);
B=-(real(X)).^2;
C=1/4;
n_sam=sqrt((-B+sqrt(B.^2-4*C))/2);

theta_sample=n_sam./real(X);

alpha_sam=-2*w./c.*imag(X)./theta_sample/100;
extinct_coeff=c./(2*2*w).*alpha_sam*100;



n_complex=n_sam-1i*extinct_coeff;
% n_sam=real(n_complex);

% alpha_sam=-imag(n_complex)*2.*w(f_range)/c/100; %in /cm

e_sam=n_complex.^2;
