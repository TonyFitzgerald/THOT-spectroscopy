function [time, signal]=UWA_csvread(filename)
ref_import=dlmread(filename,',',3,0);
ref_import(find(isnan(ref_import)))=0;
time=ref_import(:,1);

signal=ref_import(:,2);