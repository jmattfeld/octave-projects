% lpfilter.m

clear all; close all;

% load signal package
pkg load signal;

% declare some path variables
wkDir = "/home/jmattfeld/Source/octave-projects/";
inpDir = [wkDir "data/"];
outpDir = [wkDir "outputs/"];

% pos step data
data_file = [inpDir "Ts_10_50_15.csv"];
temps = dlmread(data_file,',',"D1..K7299");

% setup time array
frame = [1:7299];
seconds = frame*2;
minutes = seconds./60;

% calculate cutoff freq
fs = 0.5;
fnyq = fs/2;
fc = fnyq/12

% butterworth low pass filter
[b,a] = butter(2, fc/fnyq)
[h,w] = freqz(b,a,512,fs);

% apply butterworth filter
fTemps = filter(b,a,temps(:,1));

figure(1); hold on;
plot(seconds,temps(:,1));
plot(seconds,fTemps(:,1));
xlim([4000,13000]);
ylim([10,60]);
xlabel("time [s]");
ylabel("temperature [C]");
title("comparison of digital signal filters");
legend("unfiltered signal","butter",'location','southeast');
grid on;
hold off;

figure(2); hold on;
grpdelay(b,a);
%freqz_plot(w,h);

%% export unfiltered signal for C implementation
%unfiltered = temps(:,1);
%outfile = [outpDir "unfiltered.csv"];
%csvwrite(outfile, unfiltered);
%
%% read FIR filtered output from c program
%infile = [inpDir "filtered.csv"];
%filtered = csvread(infile);
%
%figure(2); hold on;
%plot(time, unfiltered);
%plot(time, filtered);
%title("FIR filter response (C implementation)");
%legend("unfiltered signal","firC",'location','southeast');
%grid on;
%hold off;

