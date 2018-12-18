% MPS008_Track

% Initialize arrays
clear all; close all;

% setup time array
frame = [1:2700];
ftime = frame*2;
time = ftime./60;

% setup px channel array
%px_array = linspace(1,50,64);
px_array = [1:64];

% read excel data
xls_data = csvread("C:\\Users\\Jeremy.SV\\Documents\\DNW_TEST_RAW_11-12-18.csv");
%xls_data = csvread("C:\\Users\\jeremymelinda\\Documents\\DNW_TEST_RAW_11-12-18.csv");

% extract oven_setpoint, oven_temp and mps_avg_temp
oven_setpoint = xls_data(10:2709,3);
oven_setpoint = transpose(oven_setpoint);

oven_temp = xls_data(10:2709,4);
oven_temp = transpose(oven_temp);

mps_avg_temp = xls_data(10:2709,13);
mps_avg_temp= transpose(mps_avg_temp);

%max_err_per_ch
max_err_per_ch = xls_data(3,17:80);
min_err_per_ch = xls_data(5,17:80);

% temp chip matrix
rtd_matrix = xls_data(10:2709,5:12);

figure(1); hold on;
[hax, h1, h2] = plotyy(time,oven_setpoint,time,oven_temp);
[~, p1, p2] = plotyy(max_err_per_ch,px_array,min_err_per_ch,px_array,'scatter');
plot(time,mps_avg_temp, "linewidth",3);
plot(time,rtd_matrix(:,1:8));
set ([h1,h2], "linewidth", 3);
set(hax(1), 'ylim',[1,64]);
set(hax(2), 'ylim',[1,64]);
ylabel(hax(1), "temp \(C\)");
ylabel(hax(2), "Px channel");
set(hax,'xtick',0:4:90);
set(hax(1),'ytick',0:5:60);
set(hax(2),'ytick',0:4:64);
xlabel("time \(min\)")
title("max error events");
grid on;
hold off;

raw_data = csvread("C:\\Users\\jeremymelinda\\Documents\\MPS008_Raw_11-13-18.csv");
px_raw = raw_data(2:2701,13:76);
[max_ct, max_idx] = max(px_raw)
[min_ct, min_idx] = min(px_raw)
max_raw_err_per_ch = (max_idx.*2)./60;
min_raw_err_per_ch = (min_idx.*2)./60;

figure(2); hold on;
[hax, h1, h2] = plotyy(time,oven_setpoint,time,oven_temp);
[~, p1, p2] = plotyy(max_raw_err_per_ch,px_array,min_raw_err_per_ch,px_array,'scatter');
plot(time,mps_avg_temp, "linewidth",3);
set ([h1,h2], "linewidth", 3);
set(hax(1), 'ylim',[1,64]);
set(hax(2), 'ylim',[1,64]);
set(hax(1), 'xlim',[0,90]);
set(hax(2), 'xlim',[0,90]);
ylabel(hax(1), "temp \(C\)");
ylabel(hax(2), "Px channel");
set(hax,'xtick',0:4:90);
set(hax(1),'ytick',0:5:60);
set(hax(2),'ytick',0:4:64);
xlabel("time \(min\)")
title("max raw count events");
grid on;
hold off;
