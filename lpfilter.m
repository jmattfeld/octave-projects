% lpfilter.m

clear all; close all;

% load signal package
pkg load signal;

% setup time array
frame = [1:3220];
ftime = frame*2;
time = ftime./60;

% pos step data
data_file = "C:\\Users\\Jeremy.SV\\Documents\\Step Test MPS Data 12-10-18.csv";
temps = dlmread(data_file,',',"D2..K3221");

% calculate cutoff freq
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/16

% butterworth low pass filter
[b,a] = butter(2, flp/fnyq);

% apply butterworth filter with offset
fTemps = filter(b,a,temps(:,1));

% FIR1
n = 23; % for a filter length of 10
b = fir1(n,flp)
% apply FIR filter (fir1) with offset
fir1Temps = filter(b,1,temps(:,1));

figure(1); hold on;
plot(time,temps(:,1));
%plot(time+1,fTemps(:,1));
plot(time,fir1Temps(:,1));
title("comparison of digital signal filters");
legend("unfiltered signal","fir1 (octave)",'location','southeast');
grid on;
hold off;

% export unfiltered signal for C implementation
unfiltered = temps(:,1);
csvwrite("unfiltered.csv",unfiltered);

% read FIR filtered output from c program
filtered = csvread("filtered.csv");

figure(2); hold on;
plot(time, unfiltered);
plot(time, filtered);
title("FIR filter response (C implementation)");
legend("unfiltered signal","firC",'location','southeast');
grid on;
hold off;


