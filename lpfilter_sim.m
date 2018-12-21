% lpfilter.m

clear all; close all;

% load signal package
pkg load signal;

% declare some path variables
wkDir = "C:\\Users\\Jeremy.SV\\Documents\\octave-projects\\";
inpDir = [wkDir "data\\"];
outpDir = [wkDir "outputs\\"];



% pos step data
%data_file = [inpDir "Pos Temp Step 15 PSI Applied.csv"];
neg = [inpDir "Neg Temp Step 15 PSI Applied.csv"];
pos = [inpDir "Pos Temp Step 15 PSI Applied.csv"];
neg_0 = [inpDir "Negative Step Test Zeros.csv"];
pos_0 = [inpDir "Pos Temp Step Zeros.csv"];
data_file = pos_0;
%data_file = pos;

% setup time array
%if data_file == neg
%temps = dlmread(data_file,',',"B3..I1702");
%frame = [1:1700];
%outfile = [outpDir "filtered_neg.csv"];
%elseif data_file == neg_0
%temps = dlmread(data_file,',',"B2..I2701");
%frame = [1:2700];
%outfile = [outpDir "filtered_neg_0.csv"];
%elseif data_file == pos_0
temps = dlmread(data_file,',',"B2..I3221");
frame = [1:3220];
outfile = [outpDir "filtered_pos_0.csv"];
%else % pos
%temps = dlmread(data_file,',',"B3..I3157");
%frame = [1:3155];
%outfile = [outpDir "filtered_pos.csv"];

ftime = frame*2;
time = ftime./60;

% calculate cutoff freq
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/24

%% butterworth low pass filter
%[b,a] = butter(2, flp/fnyq);
%
%% apply butterworth filter with offset
%fTemps = filter(b,a,temps(:,1));

% FIR1
n = 9; % for a filter length of 10
b = fir1(n,flp);
fir1Temps = filter(b,1,temps);

figure(1); hold on;
plot(time,temps(:,1));
%plot(time+1,fTemps(:,1));
plot(time,fir1Temps);
title("comparison of digital signal filters");
legend("unfiltered signal","fir1 (octave)",'location','southeast');
grid on;
hold off;

csvwrite(outfile, fir1Temps);

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
%
