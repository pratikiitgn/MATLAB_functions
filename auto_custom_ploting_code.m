clc
clear
close all

N_columns = 1;
N_rows   = 2;

H_P     = 1.9;          % height of each plot
W_P     = 5;            % Width  of each plot
D_BB    = 1;          % Bottom margin
D_LL    = 0.5;          % Left margin
D_RR    = 0.5;          % Right margin
D_TT    = 0.5;          % Top margin
I_H     = 0.5;          % Intermediate distance between plot in horizontal direction
I_V     = 0.5;          % Intermediate distance between plot in vertical direction

b1 = subplot(5,1,1);
b2 = subplot(5,1,2);
% b3 = subplot(5,1,3);
% b4 = subplot(5,1,4);
% b5 = subplot(5,1,5);

% subplot_array = [b1;b2;b3;b4;b5];
subplot_array = [b1;b2];

ploting_function_(H_P,W_P,D_BB,D_LL,D_RR,D_TT,I_H,I_V,N_columns,N_rows,subplot_array)


function [] = ploting_function_(H_P,W_P,D_BB,D_LL,D_RR,D_TT,I_H,I_V,N_columns,N_rows,subplot_array)

    for ii = 1:N_columns
        for jj = 1:(N_rows)
            x(jj,ii) = D_LL + (ii-1)*(W_P + I_H);
            y(jj,ii) = D_BB + ((N_rows) - jj) * (H_P + I_V);
        end
    end
    x = reshape(x.',[],1)
    y = reshape(y.',[],1)
    
    for oo= 1:length(x)
        pos(:,:,oo) = [x(oo) y(oo) W_P H_P];
    end
    
    for q = 1: length(x)
        set(subplot_array(q), 'Units','centimeters', 'Position', pos(:,:,q));
    end
    set(gcf,'Units','centimeters', 'Position', [10 5 D_LL+D_RR+N_columns*W_P+(N_columns-1)*I_H   D_BB+D_TT+N_rows*H_P+(N_rows-1)*I_V])

end
