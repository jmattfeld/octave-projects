% SN008_pStep_12-10.m

clear all; close all;

% setup time array
frame = [1:3220];
ftime = frame*2;
time = ftime./60;

% csv filename handles
data_file = "C:\\Users\\Jeremy.SV\\Documents\\SN008_data_pStep_12-10.csv";

temp_matrix = dlmread(data_file,',',"D2..K3221");
p_eu = dlmread(data_file,',',"M2..BX3221");
p_raw = dlmread(data_file,',',"EK2..GV3221");
%p_temp = dlmread(data_file,',',"GW2..JH3221");

%coeffs
coeffs = dlmread(data_file,',',"LV2..OG4");

%calc px raw to temp
p_temp = zeros(3220,64);
for i = 1:64
   p_temp(:,i) = p_raw(:,i).^2 .* coeffs(1,i) + p_raw(:,i) .* coeffs(2,i) + coeffs(3,i);
endfor

% low pass filter
fsam = 0.5;
fnyq = fsam/2;
flp = fnyq/8;
[b,a] = butter(2, flp/fnyq);

% d/dt T1
d1dt_t1 = diff(temp_matrix(:,1));
d1dt_t1 = filter(b,a,[d1dt_t1(1) ; d1dt_t1]);

% T1 deltas
d_t1 = abs(p_temp(:,1:8) - temp_matrix(:,1));

figure(); hold on;
plot(time, d1dt_t1);
for i = 1:4
   plot(time, filter(b,a,d_t1(:,i)));
endfor
legend(["d1dt T1",
        "P1",
        "P2",
        "P3",
        "P4"]);


% P channel 4 correction
cT1 = temp_matrix(:,1) - 3.*d1dt_t1;
cDelta4 = abs(p_temp(:,4) - cT1); 
figure(); hold on;
plot(time,filter(b,a,d_t1(:,4)));
plot(time,filter(b,a,cDelta4));
legend("P4-T1","P4-CorrectedT1");
title("P4 correction");

% P channel 2 correction
cT1 = temp_matrix(:,1) - 2.*d1dt_t1;
cDelta2 = abs(p_temp(:,2) - cT1); 
figure(); hold on;
plot(time,filter(b,a,d_t1(:,2)));
plot(time,filter(b,a,cDelta2));
legend("P2-T1","P2-CorrectedT1");
title("P2 correction");

% P channel 3 correction
cT1 = temp_matrix(:,1) + 3.*d1dt_t1;
cDelta3 = abs(p_temp(:,3) - cT1); 
figure(); hold on;
plot(time,filter(b,a,d_t1(:,3)));
plot(time,filter(b,a,cDelta3));
legend("P3-T1","P3-CorrectedT1");
title("P3 correction");



