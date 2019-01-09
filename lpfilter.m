% lpfilter.m

clear all; close all;

% load signal package
pkg load signal;

% declare some path variables
wkDir = "/home/jeremymelinda/Source/Octave/octave-projects/";
inpDir = [wkDir "data/"];
outpDir = [wkDir "outputs/"];

% pos step data
data_file = [inpDir "Ts_10_50_15.csv"];
temps = dlmread(data_file,',',"D1..K7299");

% setup x array
frame = [1:7299];
seconds = frame*2;
minutes = seconds./60;

% calculate time constant
t_0 = 5700;
temp_0 = 16.5;
temp_f = 55.63;
y_tau = (temp_f - temp_0) * (1 - 1/e) + temp_0;

for i = 1:7299
	if (temps(i,1) >= y_tau)
		t_tau = i * 2
		break
	endif
endfor

% this is the time constant
% for the step response
tau = t_tau - t_0;

% find -3dB freq (omega_c)
% this should be our corner frequency
wc = 1/tau
fc = 1/(2*pi*tau)

% calculate cutoff freq
fs = 0.5;
fnyq = fs/2;

% design our 2nd order butterworth filter
[z,p,k] = butter(2,wc)
sos = zp2sos(z,p,k)
b = sos(1:3)
a = sos(4:6)

fTemp = filtfilt(b,a,temps(:,1));

figure(1); hold on;
plot(seconds,temps(:,1));
plot(seconds,fTemp
);
xlim([4000,14000]);
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
