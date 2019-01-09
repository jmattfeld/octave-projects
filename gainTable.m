close all; clear all;

x = [1:7299];

gain0_0 = dlmread("./data/out_0.csv");
gain3_0 = dlmread("./data/out.csv");
gain2_35 = dlmread("./data/out_2_35.csv");

figure(); hold on;
plot(x,gain0_0);
plot(x,gain3_0);
plot(x,gain2_35);
ylim([14.99,15.04]);
legend("uncorrected","gain=3","gain=2.35");
grid on;
