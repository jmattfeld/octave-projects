% MPS008_Track

clear all; close all;

%% Initialize arrays
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
max_err_per_ch = xls_data(3,18:81);
min_err_per_ch = xls_data(5,18:81);

% temp chip matrix
rtd_matrix = xls_data(10:2709,5:12);

%f1 = figure(1); hold on;
%[hax, h1, h2] = plotyy(time,oven_setpoint,time,oven_temp);
%[~, p1, p2] = plotyy(max_err_per_ch,px_array,min_err_per_ch,px_array,'scatter');
%h3 = plot(time,mps_avg_temp, "linewidth",3);
%legend([h1;h2;h3;p1;p2],"Oven Setpoint","Oven Temp","Mps Avg Temp","Max Err\+","Max Err\-","location","north");
%%plot(time,rtd_matrix(:,1:8));
%set ([h1,h2], "linewidth", 3);
%set(hax(1), 'ylim',[1,64]);
%set(hax(2), 'ylim',[1,64]);
%set(hax(1), 'xlim',[0,90]);
%set(hax(2), 'xlim',[0,90]);
%ylabel(hax(1), "temp \(C\)");
%ylabel(hax(2), "Px channel");
%set(hax,'xtick',0:4:90);
%set(hax(1),'ytick',0:5:60);
%set(hax(2),'ytick',0:4:64);
%xlabel("time \(min\)")
%title("max eu error events by channel");
%grid on;
%hold off;
%print(f1, "eu_err_evts.pdf", "-dpdf");
%
%% read raw data
%raw_data = csvread("C:\\Users\\Jeremy.SV\\Documents\\MPS008_Raw_11-13-18.csv");
%%raw_data = csvread("C:\\Users\\jeremymelinda\\Documents\\MPS008_Raw_11-13-18.csv");
%px_raw = raw_data(2:2701,13:76);
%[max_ct, max_idx] = max(px_raw);
%[min_ct, min_idx] = min(px_raw);
%max_raw_err_per_ch = (max_idx.*2)./60;
%min_raw_err_per_ch = (min_idx.*2)./60;
%
%f2 = figure(2); hold on;
%[hax, h1, h2] = plotyy(time,oven_setpoint,time,oven_temp);
%[~, p1, p2] = plotyy(max_raw_err_per_ch,px_array,min_raw_err_per_ch,px_array,'scatter');
%h3 = plot(time,mps_avg_temp, "linewidth",3);
%legend([h1;h2;h3;p1;p2],"Oven Setpoint","Oven Temp","Mps Avg Temp","Max Count\+","Max Count\-","location","northwest");
%set ([h1,h2], "linewidth", 3);
%set(hax(1), 'ylim',[1,64]);
%set(hax(2), 'ylim',[1,64]);
%set(hax(1), 'xlim',[0,90]);
%set(hax(2), 'xlim',[0,90]);
%ylabel(hax(1), "temp \(C\)");
%ylabel(hax(2), "Px channel");
%set(hax,'xtick',0:4:90);
%set(hax(1),'ytick',0:5:60);
%set(hax(2),'ytick',0:4:64);
%xlabel("time \(min\)")
%title("max raw count events by channel");
%grid on;
%hold off;
%print(f2, "raw_err_evts.pdf", "-dpdf");

d_mps_temps = zeros(2700,1);
for i = 1:2699
   d_mps_temps(i) = 0.5 * (mps_avg_temp(i + 1) - mps_avg_temp(i));
endfor

f1 = figure(3); hold on;
%subplot(2,1,1);
[hax, h1, h2] = plotyy(time,d_mps_temps,time,mps_avg_temp);
%subplot(2,1,2)
%[pax, p1, p2] = plotyy(max_err_per_ch,px_array,min_err_per_ch,px_array,'scatter');
%[h1, h2] = plotyy(time,d_mps_temps,time,mps_avg_temp);
%legend([h1;h2;h3;p1;p2],"Oven Setpoint","Oven Temp","Mps Avg Temp","Max Err\+","Max Err\-","location","north");
%%plot(time,rtd_matrix(:,1:8));
set (h1, "linewidth", 1);
set (h2, "linewidth", 3);
%set(hax(1), 'ylim',[1,64]);
%set(hax(2), 'ylim',[1,64]);
set(hax, 'xlim',[0,90]);
%set(pax, 'xlim',[0,90]);
%set(hax(2), 'xlim',[0,90]);
%ylabel(hax(1), "temp \(C\)");
%ylabel(hax(2), "Px channel");
%set(hax,'xtick',0:4:90);
%set(hax(1),'ytick',0:5:60);
%set(hax(2),'ytick',0:4:64);
%xlabel("time \(min\)")
%title("max eu error events by channel");
title("MPS avg temp rate of change \(degrees per second\)")
grid on;
%hold off;
%print(f1, "eu_err_evts.pdf", "-dpdf");



