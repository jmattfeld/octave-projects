% lpfilter.m

clear all; close all;

% load signal package
pkg load signal;

% declare some path variables
wkDir = "/home/jeremymelinda/Source/Octave/octave-projects/";
inpDir = [wkDir "data/"];
outpDir = [wkDir "outputs/"];

% pos step data
data_file = [inpDir "All_10_50_15_1HzTmpCor.csv"];
press = dlmread(data_file,',',"Q2..R15063");

% setup x array
frame = [1:15062];

% calculate cutoff freq
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/48

% FIR1
n = 49; % for a filter length of 10
b = fir1(n,flp);
fCorPress = filter(b,1,press(:,2));

figure(1); hold on;
plot(frame,press(:,1),'linewidth',2);
plot(frame,press(:,2),'linewidth',2);
plot(frame,fCorPress,'g','linewidth',3);
title("filtered corrected pressure");
xlim([4000,14000]);
ylim([14.99,15.02]);
legend("uncorrected pressure","unfiltered corrected pressure","filtered corrected pressure",'location','southeast');
grid on;
hold off;

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
