% lpfilter.m

clear all; close all;

% load signal package
pkg load signal;

% declare some path variables
wkDir = "C:\\Users\\Jeremy.SV\\Documents\\octave-projects\\";
inpDir = [wkDir "data\\"];
outpDir = [wkDir "outputs\\"];

% pos step data
data_file = [inpDir "SN008_data_pStep_12-10.csv"];
temps = dlmread(data_file,',',"D2..K3221");

% setup time array
frame = [1:3220];
ftime = frame*2;
time = ftime./60;

% calculate cutoff freq
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/16;

% butterworth low pass filter
[b,a] = butter(2, flp/fnyq);

% apply butterworth filter with offset
fTemps = filter(b,a,temps(:,1));

% FIR1
n = 9; % for a filter length of 10
b = fir1(n,flp);
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
outfile = [outpDir "unfiltered.csv"];
csvwrite(outfile, unfiltered);

% read FIR filtered output from c program
infile = [inpDir "filtered.csv"];
filtered = csvread(infile);

figure(2); hold on;
plot(time, unfiltered);
plot(time, filtered);
title("FIR filter response (C implementation)");
legend("unfiltered signal","firC",'location','southeast');
grid on;
hold off;

