function f = Reflection_error_function_s(x,R,n_1,n_2)

n_0=1;
sintheta0=0.5;
costheta1=sqrt(1-(n_0/n_1*sintheta0)^2);
costheta2=sqrt(1-(n_0/n_2*sintheta0)^2);
n_sam=x(1)-1i*x(2);
costheta_sam=sqrt(1-(n_0/n_sam*sintheta0)^2);
if n_1==1
R_ref0=-1;
else
    R_ref0=(n_1*costheta1-n_2*costheta2)/(n_1*costheta1+n_2*costheta2);
end
R_sam0=(n_1*costheta1-n_sam*costheta_sam)/(n_1*costheta1+n_sam*costheta_sam);
R0=R_sam0/R_ref0;
% f=(log(abs(R0))-log(abs(R)))^2+(angle(R0)-angle(R))^2;
f=(real(R0)-real(R))^2+(imag(R0)-imag(R))^2;
