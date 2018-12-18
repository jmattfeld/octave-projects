% SN008_pStep_12-10.m

clear all; close all;

% load signal package
pkg load signal

% declare some path variables
wkDir = "C:\\Users\\Jeremy.SV\\Documents\\octave-projects\\";
inpDir = [wkDir "data\\"];
outpDir = [wkDir "outputs\\"];

% setup time array
frame = [1:3220];
ftime = frame*2;
time = ftime./60;

% csv filename handles
data_file = [inpDir "SN008_data_pStep_12-10.csv"];

temp_matrix = dlmread(data_file,',',"D2..K3221");
p_eu = dlmread(data_file,',',"M2..BX3221");
p_raw = dlmread(data_file,',',"EK2..GV3221");

%coeffs
coeffs = dlmread(data_file,',',"LV2..OG4");

%calc px raw to temp
p_temp = zeros(3220,64);
for i = 1:64
   p_temp(:,i) = p_raw(:,i).^2 .* coeffs(1,i) + p_raw(:,i) .* coeffs(2,i) + coeffs(3,i);
endfor

% deltas
d_p14 = abs(p_temp(:,1) - p_temp(:,4));
d_p58 = abs(p_temp(:,5) - p_temp(:,8));
d_p912 = abs(p_temp(:,9) - p_temp(:,12));
d_p1316 = abs(p_temp(:,13) - p_temp(:,16));
d_p1720 = abs(p_temp(:,17) - p_temp(:,20));
d_p2124 = abs(p_temp(:,21) - p_temp(:,24));
d_p2528 = abs(p_temp(:,25) - p_temp(:,28));
d_p2932 = abs(p_temp(:,29) - p_temp(:,32));
d_t12 = abs(temp_matrix(:,1) - temp_matrix(:,2));
d_t34 = abs(temp_matrix(:,3) - temp_matrix(:,4));


% low pass filter
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/8

[b,a] = butter(2, flp/fnyq);

% diffeq fit
y = 50 - 35.*e.^(-0.14.*(time-16));
figure(1); hold on;
plot(time,temp_matrix(:,1),'linewidth',3);
plot(time,y,'linestyle','-.');
ylim([0,50]);
grid on;
hold off;

ddt_t1 = diff(temp_matrix(:,1));
ddt_t1 = [ ddt_t1(1) ; ddt_t1 ];

figure(2); hold on;
[hax, h1, h2] = plotyy(time,temp_matrix(:,1),time,ddt_t1);
title("diff(t1temp)");
hold off;

lp_ddt_t1 = filter(b,a,ddt_t1);

figure(3); hold on;
[hax, h1, h2] = plotyy(time,temp_matrix(:,1),time,lp_ddt_t1);
title("diff\(t1temp)");
grid on;
hold off;

