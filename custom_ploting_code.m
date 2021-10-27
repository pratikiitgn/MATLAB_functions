%% sizing for the plots
% Dimesions are written in cm

D_BB    = 0.9;          % Bottom margin
D_LL    = 1;          % Left margin
D_RR    = 0.2;         % Right margin
D_TT    = 0.2;          % Top margin
L_1     = 5;            % Width of 3D plot
L_2     = 4;            % Width of other plot
L_3     = 1.5;            % Height of each plots
I_HH    = 1;
I_VV    = 0.13;

a1_x = D_LL; a1_y = D_BB + 2*L_3 + 2*I_VV;
a2_x = D_LL; a2_y = D_BB +   L_3 +   I_VV;
a3_x = D_LL; a3_y = D_BB ;

a4_x = D_LL+L_2+I_HH; a4_y = D_BB + 2*L_3 + 2*I_VV;
a5_x = D_LL+L_2+I_HH; a5_y = D_BB +   L_3 +   I_VV;
a6_x = D_LL+L_2+I_HH; a6_y = D_BB ;

a1_pos = [ a1_x a1_y L_2 L_3 ];
a2_pos = [ a2_x a2_y L_2 L_3 ];
a3_pos = [ a3_x a3_y L_2 L_3 ];
a4_pos = [ a4_x a4_y L_2 L_3 ];
a5_pos = [ a5_x a5_y L_2 L_3 ];
a6_pos = [ a6_x a6_y L_2 L_3 ];

set(a1, 'Units','centimeters', 'Position', a1_pos );
set(a2, 'Units','centimeters', 'Position', a2_pos );
set(a3, 'Units','centimeters', 'Position', a3_pos );
set(a4, 'Units','centimeters', 'Position', a4_pos );
set(a5, 'Units','centimeters', 'Position', a5_pos );
set(a6, 'Units','centimeters', 'Position', a6_pos );

Total_width     = D_LL + 2*L_2 + 1*I_HH + D_RR;
Total_height    = D_BB + 3*L_3 + 2*I_VV + D_TT;

set(gcf,'Units','centimeters', 'Position', [5 5 Total_width Total_height])
