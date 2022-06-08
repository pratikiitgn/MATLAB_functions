clc
clear
close all
sample_size = 500;
LATT        = cell2mat(struct2cell(load('Sinusoidal_data.mat','LATT')));
trimed_data = 1750 : 1750 + sample_size;
Th_ori      = LATT(trimed_data,7);
t           = (LATT(trimed_data,2) - LATT(trimed_data(1),2))/1000000 + 10;

%% Main reference page

%% Reference
% https://youtu.be/DSNd2cjWKUQ
% figure(1)
m = length(t);

% Coefficients for 5 pts
C_2 = -3/35;
C_1 = 12/35;
C_0 = 17/35;
C1  = 12/35;
C2  = -3/35;

Th_fil_5_pts = Th_ori;
Th_fil_9_pts = Th_ori;
Th_fil_9_pts_dot = zeros(length(Th_fil_9_pts ),1);

for i = 1:m-4
    if (i < 3 )
        Th_fil_5_pts(i) = Th_fil_5_pts(i);
    elseif  (i > 2)
        Th_fil_5_pts(i) = C_2* Th_ori(i-2) + C_1* Th_ori(i-1) + C_0 * Th_ori(i) + C1* Th_ori(i+1) + C2 * Th_ori(i+2);
    elseif (i > 4)
        Th_fil_5_pts(i) = C_2* Th_fil_5_pts(i-2) + C_1* Th_fil_5_pts(i-1) + C_0 * Th_fil_5_pts(i) + C1* Th_ori(i+1) + C2 * Th_ori(i+2);
    end
    if (i < 5 )
        Th_fil_9_pts(i) = Th_fil_9_pts(i);
    elseif  (i > 4)
        Th_fil_9_pts(i)       = second_order_9_pt_SG_filter(Th_ori(i-4),Th_ori(i-3),Th_ori(i-2),Th_ori(i-1),Th_ori(i),Th_ori(i+1),Th_ori(i+2),Th_ori(i+3), Th_ori(i+4));
        Th_fil_9_pts_dot(i)   = second_order_9_pt_SG_filter_dot(Th_ori(i-4),Th_ori(i-3),Th_ori(i-2),Th_ori(i-1),Th_ori(i),Th_ori(i+1),Th_ori(i+2),Th_ori(i+3), Th_ori(i+4));
    elseif (i > 9)
        Th_fil_9_pts(i)       = second_order_9_pt_SG_filter(Th_fil_9_pts(i-4),Th_fil_9_pts(i-3),Th_fil_9_pts(i-2),Th_fil_9_pts(i-1),Th_ori(i),Th_ori(i+1),Th_ori(i+2),Th_ori(i+3), Th_ori(i+4));
        Th_fil_9_pts_dot(i)   = second_order_9_pt_SG_filter_dot(Th_fil_9_pts(i-4),Th_fil_9_pts(i-3),Th_fil_9_pts(i-2),Th_fil_9_pts(i-1),Th_ori(i),Th_ori(i+1),Th_ori(i+2),Th_ori(i+3), Th_ori(i+4));
    end
end

% figure(1)
% set(gcf,'Units','centimeters', 'Position', [3 5  40 20])
% plot(t,Th_ori,'r-', 'MarkerSize',10);hold on;
% plot(t,Th_fil,'b-', 'MarkerSize',10);hold on;
% legend('ori','SG')

%% from matlab in built function
figure(1)
set(gcf,'Units','centimeters', 'Position', [3 5  40 20])

order = 2;
framelen = 9;

x = Th_ori;

sgf = sgolayfilt(x,order,framelen);

plot(x,'r-');hold on;
plot(sgf,'g-','LineWidth',2);hold on;
plot(Th_fil_9_pts,'b-', 'LineWidth',1);hold on;
plot(Th_fil_9_pts_dot*10,'k-', 'LineWidth',1);hold on;
legend('ori','SG-matlab','Custom')

function output = second_order_9_pt_SG_filter(data_4,data_3,data_2,data_1,data_0,data1,data2,data3,data4)

D_4 = -21/231;
D_3 = 14/231;
D_2 = 39/231;
D_1 = 54/231;
D_0 = 59/231;
D1  = 54/231;
D2  = 39/231;
D3  = 14/231;
D4  = -21/231;

output = D_4*data_4 + D_3*data_3 + D_2*data_2 + D_1*data_1 + D_0 * data_0 + D1*data1 + D2*data2 + D3*data3 + D4*data4;

end


function output = second_order_9_pt_SG_filter_dot(data_4,data_3,data_2,data_1,data_0,data1,data2,data3,data4)

D_4_d1 = -4/60;
D_3_d1 = -3/60;
D_2_d1 = -2/60;
D_1_d1 = -1/60;
D_0_d1 =  0/60;
D1_d1  =  1/60;
D2_d1  =  2/60;
D3_d1  =  3/60;
D4_d1  =  4/60;

output = D_4_d1*data_4 + D_3_d1*data_3 + D_2_d1*data_2 + D_1_d1*data_1 + D_0_d1 * data_0 + D1_d1*data1 + D2_d1*data2 + D3_d1*data3 + D4_d1*data4;

end


function output = second_order_9_pt_SG_filter_dot_2(data_4,data_3,data_2,data_1,data_0,data1,data2,data3,data4)

D_4_d2 = -4/60;
D_3_d2 = -3/60;
D_2_d2 = -2/60;
D_1_d2 = -1/60;
D_0_d2 = 0/60;
D1_d2 = 1/60;
D2_d2 = 2/60;
D3_d2 = 3/60;
D4_d2 = 4/60;

output = D_4_d2*data_4 + D_3_d2*data_3 + D_2_d2*data_2 + D_1_d2*data_1 + D_0_d2 * data_0 + D1_d2*data1 + D2_d2*data2 + D3_d2*data3 + D4_d2*data4;

end
