function [f_range, n_sam, alpha_sam, e_sam]=UWA_reflection_jepsen(fd_proc,n1,n2)
% Details: This code is based on Jepsen's method and used to extract the
% refractive index of sample in reflection

%% Configuration
% window = [1 300 301 600];       % windows used to split the main pulse from pre-pulse
config = [60 90 30].*pi/180; 
c=299792458;% According to Jensen model, [elevation angle, polarisation angle of the incident wave, angle of incidence]
w=2*pi*fd_proc.f*10^12;
%% Calculate the ratio of the air pulse and reference pulse
ref1=fd_proc.ref_amp1.*exp(1i*fd_proc.ref_phase1);
if n1~=1
ref2=fd_proc.ref_amp2.*exp(1i*fd_proc.ref_phase2);


Rref0 = ref2./ref1;
end

%% Calculate the ratio of the sample pulse and reference pulse

sam1=fd_proc.sam_amp1.*exp(1i*fd_proc.sam_phase1);
if n1~=1
sam2=fd_proc.sam_amp2.*exp(1i*fd_proc.sam_phase2);

Rsam0 = sam2./sam1;
end

%% Calculate the ratio of sample/air
if n1~=1
R0 = Rsam0./Rref0;
else
    R0=sam1./ref1;
end


%% Iterative method to calculate the sample refractive index at each frequency
% n1 = 1;     % refractive index of air (baseline measurement)
% n2 = 2.12;  % refractive index of quartz 

% opts = optimoptions('fmincon', 'Display','off','Algorithm','sqp');
opts=optimset('Display','off','Algorithm','sqp');
f_range=find(fd_proc.f>0&fd_proc.f<=4);
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
    v = fmincon(@(v) Jepsen_error_function(v,R0(f_range(I)),n2,n1,config),v0,[],[],[],[],[1 0],[10 5],[],opts);
    n_complex(I,1)=v(1)-1i*v(2);
    disp(horzcat('finished for ',num2str(fd_proc.f(f_range(I))),' THz'));
end

n_sam=real(n_complex);

alpha_sam=-imag(n_complex)*2.*w(f_range)/c/100; %in /cm

e_sam=n_complex.^2;

