function [f_range, n_sam, alpha_sam, e_sam]=UWA_transmission_optimization(fd_proc,n_ref,d)

    
%% measurement
A_meas=fd_proc.sam_amp1./fd_proc.ref_amp1;
phi_meas=fd_proc.sam_phase1-fd_proc.ref_phase1;

w=2*pi*fd_proc.f*10^12;
%%
c=299792458;
opts=optimset('Display','off','Algorithm','sqp');
f_range=find(fd_proc.f>0&fd_proc.f<=4);
for I=numel(f_range):-1:1

    if I~=numel(f_range)
        v0=v;
    else
        v0=[2,0.002];
    end
if numel(n_ref)> 1
    n_ref_use=n_ref(f_range(I));
else
    n_ref_use=n_ref;
end
v = fmincon(@(v) error_function(v,A_meas(f_range(I)),phi_meas(f_range(I)),n_ref_use,w(f_range(I)),d),v0,[],[],[],[],[1 0],[10 5],[],opts); 
n_complex(I,1)=v(1)+1i*v(2);
disp(horzcat('finished for ',num2str(fd_proc.f(f_range(I))),' THz'));
end


%%
n_sam=real(n_complex);

alpha_sam=imag(n_complex)*2.*w(f_range)/c/100; %in /cm

e_sam=n_complex.^2;




