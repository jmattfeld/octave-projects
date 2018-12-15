% TransTblGen.m

clear all; close all;
pkg load image;

% input files
ss_data_file = "C:\\Users\\Jeremy.SV\\Documents\\Steady State Temperature Table From Cal 12-10-18.csv";
trans_data_file = "C:\\Users\\Jeremy.SV\\Documents\\Transient Data Abbreviated 10 to 45 Degree.csv";

ss_data = dlmread(ss_data_file,',',"A1..D960");
%trans_data = dlmread(trans_data_file,',',"A1..BT1000");
trans_data = csvread(trans_data_file);

jDim = 15;
sst3d = zeros(15,2,64);
coeffs = zeros(64,3);

% separate the ss_data by px channel and calculate coeffs
for k = 1:64
   pxData = ss_data((k-1)*jDim + 1:(k-1)*jDim + jDim,3:4);
   sst3d(:,:,k) = pxData;
   %coeffs(k,:) = polyfit(pxData(:,2),pxData(:,1),2);
   coeffs(k,:) = polyfit(pxData(2:11,2),pxData(2:11,1),2);
endfor

%% checking the fit
%x = linspace(-270000,90000,1000);
%y = coeffs(1,1).*x.^2 + coeffs(1,2).*x + coeffs(1,3);
%figure(); hold on;
%plot(x,y);
%plot(sst3d(:,2,1), sst3d(:,1,1),'x');
%xlim([-267000,-92000]);
%ylim([10,50]);
%hold off;

% trans data
Tx = trans_data(2:1001,1:8);
PCx = trans_data(2:1001,9:72);
%PSTx = zeros(1000,64);

%Tx averages
T1T2 = sum(Tx(:,1:2),2) ./ 2;
T3T4 = sum(Tx(:,3:4),2) ./ 2;
T5T6 = sum(Tx(:,5:6),2) ./ 2;
T7T8 = sum(Tx(:,7:8),2) ./ 2;

% temp chip mappiings
grp1 = [Tx(:,1) PCx(:,1:4)];
grp12 = [T1T2 PCx(:,5:12)];
grp2 = [Tx(:,2) PCx(:,13:16)];
grp3 = [Tx(:,3) PCx(:,17:20)];
grp34 = [T3T4 PCx(:,21:28)];
grp4 = [Tx(:,4) PCx(:,29:32)];
grp6 = [Tx(:,6) PCx(:,33:36)];
grp56 = [T5T6 PCx(:,37:44)];
grp5 = [Tx(:,5) PCx(:,45:48)];
grp8 = [Tx(:,8) PCx(:,49:52)];
grp78 = [T7T8 PCx(:,53:60)];
grp7 = [Tx(:,7) PCx(:,61:64)];

% get the unique rows of each group
[C, ia, ic] = unique(grp1(:,1),'rows');
uGrp1 = grp1(ia,:);
uGrp12 = grp12(ia,:);
[C, ia, ic] = unique(grp2(:,1),'rows');
uGrp2 = grp2(ia,:);
[C, ia, ic] = unique(grp3(:,1),'rows');
uGrp3 = grp3(ia,:);
uGrp34 = grp34(ia,:);
[C, ia, ic] = unique(grp4(:,1),'rows');
uGrp4 = grp4(ia,:);
[C, ia, ic] = unique(grp6(:,1),'rows');
uGrp6 = grp6(ia,:);
uGrp56 = grp56(ia,:);
[C, ia, ic] = unique(grp5(:,1),'rows');
uGrp5 = grp5(ia,:);
[C, ia, ic] = unique(grp8(:,1),'rows');
uGrp8 = grp8(ia(1:428),:);
uGrp78 = grp78(ia(1:428),:);
[C, ia, ic] = unique(grp7(:,1),'rows');
uGrp7 = grp7(ia,:);

% pad short matrices to make table even (to 428 long)
uGrp1 = padarray(uGrp1,[5,0],'replicate', 'post');
uGrp12 = padarray(uGrp12,[5,0],'replicate', 'post');
uGrp2 = padarray(uGrp2,[2,0],'replicate', 'post');
uGrp3 = padarray(uGrp3,[2,0],'replicate', 'post');
uGrp34 = padarray(uGrp34,[2,0],'replicate', 'post');
uGrp5 = padarray(uGrp5,[17,0],'replicate', 'post');
uGrp56 = padarray(uGrp56,[3,0],'replicate', 'post');
uGrp6 = padarray(uGrp6,[3,0],'replicate', 'post');
uGrp7 = padarray(uGrp7,[4,0],'replicate', 'post');

% we need to replace the averaged TSTxTx+1 values (there were a few duplicates)
uGrp12(:,1) = (uGrp1(:,1) + uGrp2(:,1)) ./ 2;
uGrp34(:,1) = (uGrp3(:,1) + uGrp4(:,1)) ./ 2;
uGrp56(:,1) = (uGrp5(:,1) + uGrp6(:,1)) ./ 2;
uGrp78(:,1) = (uGrp7(:,1) + uGrp8(:,1)) ./ 2;

% put the Px matrix back together
uPCx = [uGrp1(:,2:5) uGrp12(:,2:9) uGrp2(:,2:5) uGrp3(:,2:5) uGrp34(:,2:9) uGrp4(:,2:5) uGrp6(:,2:5) uGrp56(:,2:9) uGrp6(:,2:5) uGrp8(:,2:5) uGrp78(:,2:9) uGrp7(:,2:5)];

% calculate PST for each channel
PSTx = zeros(428,64);
for i = 1:64
   a = coeffs(i,1);
   b = coeffs(i,2);
   c = coeffs(i,3);
   x = uPCx(:,i);
   PSTx(:,i) = a.*x.^2 + b.*x + c;
endfor

%Tx averages
T1T2 = sum(Tx(:,1:2),2) ./ 2;
T3T4 = sum(Tx(:,3:4),2) ./ 2;
T5T6 = sum(Tx(:,5:6),2) ./ 2;
T7T8 = sum(Tx(:,7:8),2) ./ 2;

% initialize output table
transOut = zeros(428,128);

% build output table
for i = 1:64 % for each channel
   % TSTx column
   switch (i)
      case { 1,2,3,4 }
         transOut(:,i*2-1) = uGrp1(:,1);
      case { 5,6,7,8,9,10,11,12 }
         transOut(:,i*2-1) = uGrp12(:,1);
      case { 13,14,15,16 }
         transOut(:,i*2-1) = uGrp2(:,1);
      case { 17,18,19,20 }
         transOut(:,i*2-1) = uGrp3(:,1);
      case { 21,22,23,24,25,26,27,28 }
         transOut(:,i*2-1) = uGrp34(:,1);
      case { 29,30,31,32 }
         transOut(:,i*2-1) = uGrp4(:,1);
      case { 33,34,35,36 }
         transOut(:,i*2-1) = uGrp6(:,1);
      case { 37,38,39,40,41,42,43,44 }
         transOut(:,i*2-1) = uGrp56(:,1);
      case { 45,46,47,48 }
         transOut(:,i*2-1) = uGrp5(:,1);
      case { 49,50,51,52 }
         transOut(:,i*2-1) = uGrp8(:,1);
      case { 53,54,55,56,57,58,59,60 }
         transOut(:,i*2-1) = uGrp78(:,1);
      case { 61,62,63,64 }
         transOut(:,i*2-1) = uGrp7(:,1);
   endswitch

   % PSTx column
   transOut(:,i*2) = PSTx(:,i);
endfor

idx = transpose(linspace(0,427,428));
transOut = [idx transOut];

csvwrite("TransTable.csv",transOut)

