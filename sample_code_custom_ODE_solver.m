clc
clear
close all

%% System parameters
sim_time      = 0.1;          % Maximum simulation time

global mp mq 

%% Initial conditions of quadcopter with payload system

IC = [];

%% Soving the dynamics of the system

XK            = IC;
iterations    = sim_time/Ts;
X(:,1,1)      = IC;

for ii = 0:1:iterations-1


    %% Control inputs

    %%% Desired configuration


    %% iteration loop
    X(:,1,ii+1)     = RK45_method(t(ii+1),XK,u,M);
    XK              = X(:,:,ii+1);

end

%% Useful functions
function XK_1 = RK45_method(t,XK,u,M)

global Ts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   RK fourth order method coefficients   %%%%%%%%%%
A_21 = 1/4;
A_31 = 3/32;         A_32 = 9/32;
A_41 = 1932/2197;    A_42 = -7200/2197;   A_43 = 7296/2197;
A_51 = 439/216;      A_52 = -8;           A_53 = 3680/513;    A_54 = -845/4104;
B1   = 25/216;       B2   = 0;            B3   = 1408/2565;   B4   = 2197/4104;     B5 = -1/5;


KK1     = Ts*EOM(t,XK,u,M);

XK2     = XK + A_21*KK1;
KK2     = Ts*EOM(t,XK2,u,M);

XK3     = XK + A_31*KK1 + A_32*KK2;
KK3     = Ts*EOM(t,XK3,u,M);

XK4     = XK + A_41*KK1 + A_42*KK2 + A_43*KK3;
KK4     = Ts*EOM(t,XK4,u,M);

XK5     = XK + A_51*KK1 + A_52*KK2 + A_53*KK3 + A_54*KK4;
KK5     = Ts*EOM(t,XK5,u,M);

XK_1    = XK + (B1*KK1) + (B2*KK2) + (B3*KK3) + (B4*KK4) + (B5*KK5);
end

%% Governing EOM

function X_ddot = EOM(t,XK,u,M)

global mp mq mt J l gamma e3 g


X_ddot(1:3,1)     = xq_dot;

end
