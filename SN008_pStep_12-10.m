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

y = [0,60];

%figure(1); hold on;
%%subplot(5,1,1); hold on; grid on;
%plot(time,d_t12);
%title("T1\/T2 temperature delta")
%hold off;
%
%figure(2); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,1),time,d_p14);
%h3 = plot(time,p_temp(:,4));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P1 temp","P4 temp","deltaP1\/P4","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P1\/P4 temperature delta")
%grid on;
%hold off;
%
%figure(3); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,5),time,d_p58);
%h3 = plot(time,p_temp(:,8));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P5 temp","P8 temp","deltaP5\/P8","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P5\/P8 temperature delta")
%grid on;
%hold off;
%
%figure(4); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,9),time,d_p912);
%h3 = plot(time,p_temp(:,12));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P9 temp","P12 temp","deltaP9\/P12","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P9\/P12 temperature delta")
%grid on;
%hold off;
%
%figure(5); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,13),time,d_p1316);
%h3 = plot(time,p_temp(:,16));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P13 temp","P16 temp","deltaP13\/P16","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P13\/P16 temperature delta")
%grid on;
%hold off;
%
%figure(6); hold on;
%%subplot(5,1,1); hold on; grid on;
%plot(time,d_t34);
%title("T3\/T4 temperature delta")
%hold off;
%
%figure(7); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,17),time,d_p1720);
%h3 = plot(time,p_temp(:,20));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P17 temp","P20 temp","deltaP17\/P20","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P17\/P20 temperature delta")
%grid on;
%hold off;
%
%figure(8); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,21),time,d_p2124);
%h3 = plot(time,p_temp(:,24));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P21 temp","P24 temp","deltaP21\/P24","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P21\/P24 temperature delta")
%grid on;
%hold off;
%
%figure(9); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,25),time,d_p2528);
%h3 = plot(time,p_temp(:,28));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P25 temp","P28 temp","deltaP25\/P28","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P25\/P28 temperature delta")
%grid on;
%hold off;
%
%figure(10); hold on;
%%subplot(5,1,2); hold on; grid on;
%[hax, h1, h2] = plotyy(time,p_temp(:,29),time,d_p2932);
%h3 = plot(time,p_temp(:,32));
%%[val idx] = max(d_p14);
%%h4 = plot([time(idx),time(idx)],y);
%legend([h1;h3;h2],"P29 temp","P32 temp","deltaP29\/P32","location","northwest");
%%set(hax, 'xlim',[10,60]);
%set(hax(1), 'ycolor','b');
%set(hax(2), 'ycolor','r');
%set (h1, 'color', 'b');
%set (h2, 'color', 'r');
%set (h3, 'color', 'g');
%title("P29\/P32 temperature delta")
%grid on;
%hold off;

% calculate starting offsets
p1shft = p_temp(1,1) - temp_matrix(1,1);
p2shft = p_temp(1,2) - temp_matrix(1,1);
p3shft = p_temp(1,3) - temp_matrix(1,1);
p5shft = p_temp(1,5) - temp_matrix(1,1);
p7shft = p_temp(1,7) - temp_matrix(1,1);
p9shft = p_temp(1,9) - temp_matrix(1,1);

% adjusted temps
adj_p1_temp = p_temp(:,1) - p1shft;
adj_p2_temp = p_temp(:,2) - p2shft;
adj_p3_temp = p_temp(:,3) - p3shft;
adj_p5_temp = p_temp(:,5) - p5shft;
adj_p7_temp = p_temp(:,7) - p7shft;
adj_p9_temp = p_temp(:,9) - p9shft;

% Px to T1 deltas
d_p1t1 = abs(p_temp(:,1) - temp_matrix(:,1));
d_p2t1 = abs(p_temp(:,2) - temp_matrix(:,1));
d_p3t1 = abs(p_temp(:,3) - temp_matrix(:,1));
d_p5t1 = abs(p_temp(:,5) - temp_matrix(:,1));
d_p7t1 = abs(p_temp(:,7) - temp_matrix(:,1));
d_p9t1 = abs(p_temp(:,9) - temp_matrix(:,1));

% adjusted Px to T1 deltas
ad_p1t1 = abs(adj_p1_temp - temp_matrix(:,1));
ad_p2t1 = abs(adj_p2_temp - temp_matrix(:,1));
ad_p3t1 = abs(adj_p3_temp - temp_matrix(:,1));
ad_p5t1 = abs(adj_p5_temp - temp_matrix(:,1));
ad_p7t1 = abs(adj_p7_temp - temp_matrix(:,1));
ad_p9t1 = abs(adj_p9_temp - temp_matrix(:,1));

figure(11); hold on;
%subplot(5,1,2); hold on; grid on;
[hax, h1, h2] = plotyy(time,adj_p1_temp,time,ad_p1t1);
h3 = plot(time,temp_matrix(:,1));
%[val idx] = max(d_p14);
%h4 = plot([time(idx),time(idx)],y);
legend([h1;h3;h2],"P1 temp","T1 temp","deltaP1\/T1","location","northwest");
%set(hax, 'xlim',[10,60]);
set(hax(1), 'ycolor','b');
set(hax(2), 'ycolor','r');
set (h1, 'color', 'b');
set (h2, 'color', 'r');
set (h3, 'color', 'g');
title("P1\/T1 temperature delta")
grid on;
hold off;

figure(12); hold on;
%subplot(5,1,2); hold on; grid on;
[hax, h1, h2] = plotyy(time,adj_p2_temp,time,ad_p2t1);
h3 = plot(time,temp_matrix(:,1));
%[val idx] = max(d_p14);
%h4 = plot([time(idx),time(idx)],y);
legend([h1;h3;h2],"P2 temp","T1 temp","deltaP1\/T1","location","northwest");
%set(hax, 'xlim',[10,60]);
set(hax(1), 'ycolor','b');
set(hax(2), 'ycolor','r');
set (h1, 'color', 'b');
set (h2, 'color', 'r');
set (h3, 'color', 'g');
title("P2\/T1 temperature delta")
grid on;
hold off;

figure(13); hold on;
%subplot(5,1,2); hold on; grid on;
[hax, h1, h2] = plotyy(time,adj_p3_temp,time,ad_p3t1);
h3 = plot(time,temp_matrix(:,1));
%[val idx] = max(d_p14);
%h4 = plot([time(idx),time(idx)],y);
legend([h1;h3;h2],"P3 temp","T1 temp","deltaP3\/T1","location","northwest");
%set(hax, 'xlim',[10,60]);
set(hax(1), 'ycolor','b');
set(hax(2), 'ycolor','r');
set (h1, 'color', 'b');
set (h2, 'color', 'r');
set (h3, 'color', 'g');
title("P3\/T1 temperature delta")
grid on;
hold off;
