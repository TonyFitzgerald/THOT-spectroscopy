function [freq, amplitude, phase]=UWA_csvread_freq(filename)
ref_import=dlmread(filename,',',0,0);
freq=ref_import(:,1);
amplitude=ref_import(:,2);
phase=ref_import(:,3);