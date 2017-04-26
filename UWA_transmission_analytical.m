function [n_sam, alpha_sam e_sam]=UWA_transmission_analytical(fd_proc,n_ref,d)
c=299792458;
n_air=1;
A=fd_proc.sam_amp1./fd_proc.ref_amp1;
phi=fd_proc.sam_phase1-fd_proc.ref_phase1;
w=2*pi*fd_proc.f*10^12;
n_sam=-(c*phi)./(w.*d)+n_air;
t_factor = 4.*n_sam.*n_ref./(n_sam + n_ref).^2;

log_input = A./ t_factor;


alpha_sam = -2 ./ (d./1e-2) .* log(log_input);
k_sam=-(2*w/c).^-1 .* alpha_sam*100;
e_sam=(n_sam-k_sam*1i).^2;


