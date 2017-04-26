function output=error_function(v,A_meas,phi_meas,n_ref,w,d)

c=299792458;% speed of light
% n_win=2.12;% quartz window
% x=v(1);y=v(2);
n_sam=v(1)-1i*v(2);


A=4*n_sam*n_ref./(n_sam+n_ref).^2;
B=exp(-1i*(n_sam-1).*w*d/c);
ang1=-v(1)*w*d/c+w*d/c;
ang2=atan(imag(A)/real(A));
T_theory=A.*B;
% phi=angle(T_theory);
% phi=mytan(imag(T_theory),real(T_theory));
% output=T_theory;
phi=ang1+ang2;
A_theory=abs(T_theory);
 output=(log(A_meas) - log(A_theory)).^2+(phi_meas-phi).^2;
