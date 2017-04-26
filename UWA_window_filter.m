function signal_proc=UWA_window_filter(win,filt_func,time,signal)
%%
window_range= time>=win(1)&time<=win(2);
window_func=zeros(size(signal));
window_func(window_range)=1;
signal_proc=signal.*window_func.*filt_func;
    
