% SN008_wTempDeltas.m

clear all; close all;

% setup time array
frame = [1:2700];
ftime = frame*2;
time = ftime./60;

% csv filename handles
harm_file = "C:\\Users\\Jeremy.SV\\Documents\\DNW_TEST_RAW_11-12-18.csv";
coeff_file = "C:\\Users\\Jeremy.SV\\Documents\\SN008_adjfit.csv";
raw_file = "C:\\Users\\Jeremy.SV\\Documents\\MPS008_Raw_11-13-18.csv";

coeffs = dlmread(coeff_file,',',"JH2..LS4");
a = coeffs(1,:);
b = coeffs(2,:);
c = coeffs(3,:);

temp_matrix = dlmread(harm_file,',',"E10..L2709");
p_eu = dlmread(harm_file,',',"R10..CC2709");
p_raw = dlmread(raw_file,',',"M2..BX2701");

press_temp_matrix = zeros(2700,64);

%for i = 1:64
%   press_temp_matrix(:,i) = a(i) .* p_raw(:,i).^2 + b(i) .* p_raw(:,i) + c(i); 
%endfor
% temp = ax^2 + bx + c
pr1_to_temp = a(1) .* p_raw(:,1).^2 + b(1) .* p_raw(:,1) + c(1); 

figure(1); hold on;
%plot(time,temp_matrix(:,1),'linewidth',2);
for i = 1:8
   pri_to_temp = a(i) .* p_raw(:,i).^2 + b(i) .* p_raw(:,i) + c(i); 
%plot(time,p_raw(:,1),'linewidth',2);
   plot(time,pri_to_temp,'linewidth',2);
endfor
hold off;
%plot(time,press_temp_matrix(:,1),'linewidth',2);
title("temp chip versus pressure sensor quadratic fit");
%legend("tempx","px1temp");

%figure(2); hold on;
%delta_t1t2 = temp_matrix(:,1) - temp_matrix(:,2);
%plot(time,delta_t1t2);
%title("delta temp1 vs temp2");


