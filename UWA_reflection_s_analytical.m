function [f_range, n_sam, alpha_sam, e_sam]=UWA_reflection_s_analytical(fd_proc,n_1,n_2)
f_range=find(fd_proc.f>0&fd_proc.f<=4);
n_0=1;
costheta0=sqrt(1-(sind(30))^2); % cos theta air
costheta1=sqrt(1-(n_0/n_1*sind(30))^2); % cos theta window
sintheta1=sqrt(1-costheta1^2);
costheta2=sqrt(1-(n_1/n_2*sintheta1)^2); % cos theta sample
c=299792458; % speed of light in m/s
w=2*pi*fd_proc.f(f_range)*10^12;



R_mag=fd_proc.sam_amp1./fd_proc.ref_amp1;
R_phase=exp(1i*(fd_proc.sam_phase1-fd_proc.ref_phase1));

        R=R_mag(f_range).*R_phase(f_range);
        X=((1+R).*n_2.*n_1.*costheta1.*costheta2+(1-R)*n_1^2*costheta1^2)./((1+R).*n_1.*costheta1+(1-R)*n_2*costheta2);
        n_sam=sqrt((real(X)).^2+0.25);
        theta_sample=real(X)./sqrt(0.25+real(X).^2);
        alpha_sam=-2*w./c.*imag(X)./theta_sample/100;

extinct_coeff=c./(2*2*w).*alpha_sam*100;



n_complex=n_sam-1i*extinct_coeff;


e_sam=n_complex.^2;