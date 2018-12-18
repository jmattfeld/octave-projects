% SN008 10 to 45 C step

clear all; close all;

%% Initialize arrays
% setup time array
frame = [1:1740];
ftime = frame*2;
time = ftime./60;

% read excel data, ignore header row
%xls_data = csvread("C:\\Users\\Jeremy.SV\\Documents\\octave-projects\\SN008_10_to_45_Step.csv",1,0);
xls_data = csvread("C:\\Users\\Jeremy.SV\\Documents\\octave-projects\\SN008_adjfit.csv",1,0);

rtd_temps = xls_data(1:1740,2:9);
mps_avg_temp = sum(rtd_temps,2)/8;

%coeffs
coeffs = xls_data(1:3,268:331);
tr_coeffs = transpose(coeffs);
%A = tr_coeffs(:,1);
%B = tr_coeffs(:,2);
%C = tr_coeffs(:,3);
%A = xls_data(1,268:331);
%B = xls_data(2,268:331);
%C = xls_data(3,268:331);

% y = ax^2 + bx + c
%a = 8.00366e-10;
%b = -9.34156e-5;
%c = -8.9522;

% Y = Ax^3 + Bx^2 + C + D
%A = -2.34262e-15;
%B = -4.13847e-10;
%C = -0.000299302;
%D = -20.35771;

% array x
px = xls_data(1:1740,11:74);
xls_deltas = xls_data(1:1740,203:266);
sp = [4 2 3 1];
%figure(); hold on;
for p = 1:4
   %figure(); hold on;
   sp(p)
   subplot(5,1,sp(p)); hold on;

   for n = 1:8
      idx = 4 * (n-1) + p;
      pnx = px(:,idx);
      pt = (pnx.^2).*tr_coeffs(idx,1) + pnx.*tr_coeffs(idx,2) + tr_coeffs(idx,3);
      %delta = pt - mps_avg_temp;
      delta = xls_deltas(:,idx);
      plot(time,delta, 'linewidth',2);
      ylim([-0.4,0.8]);
      xlim([0,20]);
      grid on;
   endfor
   %hold off;
endfor
subplot(5,1,5);
plot(time,mps_avg_temp,'linewidth',2);
grid on;
xlim([0,20]);

%plot(time,pt, 'linewidth',2);
%plot(time,rtd_temps(:,4), 'linewidth',2);
%plot(time,y_temp, 'linewidth',2);
%plot(time,Y_temp, 'linewidth',2);
%legend("mps avg temp","ch1 temp","2nd Order Fit","3rd Order Fit","location","northwest");
%hold off;
%for n = 1:64
%   pnx = px(:,n);
%   pt = (pnx.^2).*tr_coeffs(n,1) + pnx.*tr_coeffs(n,2) + tr_coeffs(n,3);
%   plot(time,pt, 'linewidth',2);
%endfor
%p1x = xls_data(:,13);
%y_temp = a.*(p1x.^2) + b.*p1x + c;
%Y_temp = A.*(p1x.^3) + B.*(p1x.^2) + C.*p1x + D;


%extract oven_setpoint, oven_temp and mps_avg_temp
%oven_setpoint = xls_data(10:2709,3);
%oven_setpoint = transpose(oven_setpoint);
%
%oven_temp = xls_data(10:2709,4);
%oven_temp = transpose(oven_temp);
%
%mps_avg_temp = xls_data(10:2709,13);
%mps_avg_temp= transpose(mps_avg_temp);
%
%%max_err_per_ch
%max_err_per_ch = xls_data(3,18:81);
%min_err_per_ch = xls_data(5,18:81);
%
%% temp chip matrix
%rtd_matrix = xls_data(10:2709,5:12);
%
%f1 = figure(1); hold on;
%plot(time,mps_avg_temp, 'linewidth',2);
%plot(time,rtd_temps(:,4), 'linewidth',2);
%plot(time,y_temp, 'linewidth',2);
%plot(time,Y_temp, 'linewidth',2);
%legend("mps avg temp","ch1 temp","2nd Order Fit","3rd Order Fit","location","northwest");
%hold off;
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
