clc             % this will erase the command window
clear all       % This will clear the workspace

%% system parameters
m = 1.5;        % mass of the quadcopter
g = 9.81;       % gravitational acceleration
Jq1     = 1.13/100; Jq2 = 1.33/100; Jq3 = 1.87/100;         % moment of intertias of the quadcopter about their first, second and third axes
J       = [Jq1, 0, 0;  0, Jq2, 0; 0,0, Jq3];
e3      = [0;0;1];          % third inertial axis

%% initialize the positional states
xq_0       = [0;0;0];
phi_0      = 0.0;
theta_0    = 0.0;
psi_0      = 0.0;
R_0        = func_rotz(psi_0)*func_rotx(phi_0)*func_roty(theta_0);
R_0        = [R_0(1,1); R_0(2,1);R_0(3,1);...
           R_0(1,2); R_0(2,2);R_0(3,2);...
           R_0(1,3); R_0(2,3);R_0(3,3)];

% initialize the velocities states
xq_dot_0   = [0;0;0];
Omega_0    = [0;0;0];

IC = [xq_0; R_0; xq_dot_0; Omega_0 ];

%% Soving the dynamics of the system

sim_time    = 1;
Ts          = 0.01;

XK             = IC;
iterations     = sim_time/Ts;

for ii = 0:1:iterations-1

    %%% time steps
    t(ii+1,1)               = ii*Ts;
    
    f = m*g;
    M = [0.01;0;0];

    xq_1(ii+1,1)   = XK(1,1);
    xq_2(ii+1,1)   = XK(2,1);
    xq_3(ii+1,1)   = XK(3,1);

    X(:,1,ii+1)     = RK45_method(t(ii+1,1),XK,f,M);
    XK              = X(:,:,ii+1);

end

%% Plot the values

figure(1)
subplot(3,1,1)
plot(t,xq_1)

subplot(3,1,2)
plot(t,xq_2)

subplot(3,1,3)
plot(t,xq_3)

%% 

function X_ddot = EOM(t,XK,f,M)
m = 1.5;        % mass of the quadcopter
g = 9.81;       % gravitational acceleration
Jq1     = 1.13/100; Jq2 = 1.33/100; Jq3 = 1.87/100;         % moment of intertias of the quadcopter about their first, second and third axes
J       = [Jq1, 0, 0;  0, Jq2, 0; 0,0, Jq3];
e3      = [0;0;1];          % third inertial axis

xq                 = [ XK(1,1); XK(2,1); XK(3,1)];
R                  = [ XK(4,1) XK(7,1) XK(10,1);
                     XK(5,1) XK(8,1) XK(11,1); 
                     XK(6,1) XK(9,1) XK(12,1)]
xq_dot             = [ XK(13,1); XK(14,1); XK(15,1)];
Omega              = [ XK(16,1); XK(17,1); XK(18,1)];

R_dot              = R*hatmap(Omega);
xq_ddot            = f*R*e3/m - g *e3;
Omega_dot          = inv(J)*(M - hatmap(Omega)*J*Omega);

X_ddot(1:3,1)     = xq_dot;
X_ddot(4:6,1)     = R_dot(1:3,1);
X_ddot(7:9,1)     = R_dot(1:3,2);
X_ddot(10:12,1)   = R_dot(1:3,3);

X_ddot(13:15,1)   = xq_ddot;
X_ddot(16:18,1)   = Omega_dot;

end


function XK_1 = RK45_method(t,XK,f,M)

Ts = 0.01;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   RK fourth order method coefficients   %%%%%%%%%%
A_21 = 1/4;
A_31 = 3/32;         A_32 = 9/32;
A_41 = 1932/2197;    A_42 = -7200/2197;   A_43 = 7296/2197;
A_51 = 439/216;      A_52 = -8;           A_53 = 3680/513;    A_54 = -845/4104;
B1   = 25/216;       B2   = 0;            B3   = 1408/2565;   B4   = 2197/4104;     B5 = -1/5;

KK1     = Ts*EOM(t,XK,f,M);

XK2     = XK + A_21*KK1;
KK2     = Ts*EOM(t,XK2,f,M);

XK3     = XK + A_31*KK1 + A_32*KK2;
KK3     = Ts*EOM(t,XK3,f,M);

XK4     = XK + A_41*KK1 + A_42*KK2 + A_43*KK3;
KK4     = Ts*EOM(t,XK4,f,M);

XK5     = XK + A_51*KK1 + A_52*KK2 + A_53*KK3 + A_54*KK4;
KK5     = Ts*EOM(t,XK5,f,M);

XK_1    = XK + (B1*KK1) + (B2*KK2) + (B3*KK3) + (B4*KK4) + (B5*KK5);
end

function matrix = func_rotz(angle)
  matrix = [ cos(angle) -sin(angle)  0;
             sin(angle)  cos(angle)  0;
             0             0           1];
end
function matrix = func_rotx(angle)
  matrix = [1 0 0;
           0 cos(angle) -sin(angle);
           0 sin(angle)  cos(angle)];
end
function matrix = func_roty(angle)
  matrix = [ cos(angle)  0 sin(angle);
             0           1     0 ;
             -sin(angle) 0 cos(angle) ];  
end

function final_matrix = hatmap(v)
final_matrix = [ 0 , -v(3) , v(2);
    v(3),    0  ,-v(1);
    -v(2),  v(1) , 0  ];
end
