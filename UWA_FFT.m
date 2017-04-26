function [f, amp, phase]=UWA_FFT(time,td_signal,numpad)
%%
if nargin<3
    numpad=length(time);
end
deltaT=time(2)-time(1);
maxFreq=1/deltaT;
deltaFreq = maxFreq./(numpad-1)/2;
freq = (0:deltaFreq:maxFreq)';
fft_complex=fft(td_signal,numel(freq));
fft_amp=abs(fft_complex);
% fft_phase=unwrap_ed2(freq,fft_amp,angle(fft_complex));
fft_phase=unwrap(angle(fft_complex));
f=freq(1:numpad);
amp=fft_amp(1:numpad);
phase=fft_phase(1:numpad);

