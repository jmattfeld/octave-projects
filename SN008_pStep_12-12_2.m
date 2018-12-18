% SN008_pStep_12-10.m

clear all; close all;


% setup time array
frame = [1:3220];
ftime = frame*2;
time = ftime./60;

% csv filename handles

% pos step data
data_file = "C:\\Users\\Jeremy.SV\\Documents\\Step Test MPS Data 12-10-18.csv";
% neg step data
%data_file = "C:\\Users\\Jeremy.SV\\Documents\\Negative Step Test 12-10-18 MPS Data.csv";

temps = dlmread(data_file,',',"D2..K3221");
p_eu = dlmread(data_file,',',"M2..BX3221");
p_raw = dlmread(data_file,',',"EK2..GV3221");
p_temp = dlmread(data_file,',',"BY2..EJ3221");

% low pass filter
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/8;
[b,a] = butter(2, flp/fnyq);
% end low pass filter

% d/dt temp chips
d1dt_temps = diff(temps,1,1);
d1dt_temps = [d1dt_temps(1,:) ; d1dt_temps];

% apply lp filter and plot
figure(); hold on;
d1dt_temps(:,1) = filter(b,a,d1dt_temps(:,1));
[hax, h1, h2] = plotyy(time,temps(:,1),time,d1dt_temps(:,1));
set(hax, 'xlim',[10,50]);
hold off;

% corrected Tx (relative to Px)
%cTemps = zeros(3220,64);
%cDeltas = zeros(3220,64);

%for t = 1:8
%   for p = 1:8
%      idx = (t-1)*8 + p
%      cTemps(:,idx) = temps(:,t) - d1dt_temps(:,t);
%   endfor
%endfor
%
%cDeltas = p_temp - cTemps;
%
%for t = 1:8
%   figure(); hold on;
%   for p = 1:8
%      idx = (t-1)*8 + p
%      plot(time,abs(p_temp(:,idx) - temps(:,t)));
%      %cDeltas(:,idx) = filter(b,a,cDeltas(:,idx));
%      %plot(time,cDeltas(:,idx));
%   endfor
%   hold off;
%endfor

figure(); hold on;
plot(time,p_temp(:,1));
plot(time,temps(:,1));
%plot(time,abs(p_temp(:,1) - temps(:,1)));
hold off;

