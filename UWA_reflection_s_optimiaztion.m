function [f_range, n_sam, alpha_sam, e_sam]=UWA_reflection_s_optimiaztion(fd_proc,n1,n2,polarization)
R0_A=fd_proc.sam_amp1./fd_proc.ref_amp1;
R0_phi=fd_proc.sam_phase1-fd_proc.ref_phase1;
R0=R0_A.*exp(1i*R0_phi);
opts=optimset('Display','off','Algorithm','sqp');
f_range=find(fd_proc.f>0&fd_proc.f<=4);
c=299792458;% According to Jensen model, [elevation angle, polarisation angle of the incident wave, angle of incidence]
w=2*pi*fd_proc.f*10^12;
for I=numel(f_range):-1:1
    
    if I~=numel(f_range)
        v0=v;
    else
        v0=[2,0.002];
    end
%     if numel(n_ref)> 1
%         n_ref_use=n_ref(f_range(I));
%     else
%         n_ref_use=n_ref;
%     end
if polarization ==2
    v = fmincon(@(v) Reflection_error_function_s(v,R0(f_range(I)),n1,n2),v0,[],[],[],[],[-10 -10],[10 5],[],opts);
else if polarization==3
        v = fmincon(@(v) Reflection_error_function_p(v,R0(f_range(I)),n1,n2),v0,[],[],[],[],[-10 -10],[10 5],[],opts);
    end
end
    n_complex(I,1)=v(1)-1i*v(2);
    disp(horzcat('finished for ',num2str(fd_proc.f(f_range(I))),' THz'));
end
n_sam=real(n_complex);

alpha_sam=-imag(n_complex)*2.*w(f_range)/c/100; %in /cm

e_sam=n_complex.^2;