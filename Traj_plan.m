clc
clear
close all

%% Boundary conditions

x1 = [0;0;0];
x2 = [0;0;4];
x3 = [6;0;4];
x4 = [6;-6;4];
x5 = [3;-3;6];
x6 = [0;0;4];
x7 = [0;0;0];

max_speed = 1;

t12 = dist(x1,x2)/max_speed 
t23 = dist(x2,x3)/max_speed 
t34 = dist(x3,x4)/max_speed 
t45 = dist(x4,x5)/max_speed 
t56 = dist(x5,x6)/max_speed 
t67 = dist(x6,x7)/max_speed 

t1 = 0
t2 = t1 + t12
t3 = t1 + t12 + t23
t4 = t1 + t12 + t23 + t34
t5 = t1 + t12 + t23 + t34 + t45
t6 = t1 + t12 + t23 + t34 + t45 + t56
t7 = t1 + t12 + t23 + t34 + t45 + t56 + t67
% 
syms tt1 tt2 p1 p2

boundary_cond = [ p1; 0; p2; 0];

Time_matrix = [ 1   tt1     tt1^2    tt1^3;
                0   1    2*tt1    3*tt1^2;
                1   tt2     tt2^2    tt2^3;
                0   1    2*tt2    3*tt2^2];

traj_coeff = inv(Time_matrix)*boundary_cond

% t = 0:0.1:30;
% figure(1)
% 
c12_x = Traj_plan(x1(1),x2(1),t1,t2)
c23_x = Traj_plan(x2(1),x3(1),t2,t3)
c34_x = Traj_plan(x3(1),x4(1),t3,t4)
c45_x = Traj_plan(x4(1),x5(1),t4,t5)
c56_x = Traj_plan(x5(1),x6(1),t5,t6)
c67_x = Traj_plan(x6(1),x7(1),t6,t7)

c12_y = Traj_plan(x1(2),x2(2),t1,t2)
c23_y = Traj_plan(x2(2),x3(2),t2,t3)
c34_y = Traj_plan(x3(2),x4(2),t3,t4)
c45_y = Traj_plan(x4(2),x5(2),t4,t5)
c56_y = Traj_plan(x5(2),x6(2),t5,t6)
c67_y = Traj_plan(x6(2),x7(2),t6,t7)

c12_z = Traj_plan(x1(3),x2(3),t1,t2)
c23_z = Traj_plan(x2(3),x3(3),t2,t3)
c34_z = Traj_plan(x3(3),x4(3),t3,t4)
c45_z = Traj_plan(x4(3),x5(3),t4,t5)
c56_z = Traj_plan(x5(3),x6(3),t5,t6)
c67_z = Traj_plan(x6(3),x7(3),t6,t7)

% for i=1:100
% for i=1:length(t)
for t = t1:0.1:t7

    if (t <= t2 && t >= t1)
        x = c12_x(1) + t * c12_x(2) + t*t * c12_x(3) + t*t*t*c12_x(4);
        y = c12_y(1) + t * c12_y(2) + t*t * c12_y(3) + t*t*t*c12_y(4);
        z = c12_z(1) + t * c12_z(2) + t*t * c12_z(3) + t*t*t*c12_z(4);
        fprintf("point 12 | t = %3.3f, x = %3.3f \n", t, x);
    end

    if (t <= t3 && t >= t2)
        x = c23_x(1) + t * c23_x(2) + t*t * c23_x(3) + t*t*t*c23_x(4);
        y = c23_y(1) + t * c23_y(2) + t*t * c23_y(3) + t*t*t*c23_y(4);
        z = c23_z(1) + t * c23_z(2) + t*t * c23_z(3) + t*t*t*c23_z(4);
        fprintf("point 23 | t = %3.3f, x = %3.3f \n", t, x);
    end

    if (t < t4 && t >= t3)
        x = [1 t t^2 t^3]*Traj_plan(x3(1),x4(1),t3,t4);
        y = [1 t t^2 t^3]*Traj_plan(x3(2),x4(2),t3,t4);
        z = [1 t t^2 t^3]*Traj_plan(x3(3),x4(3),t3,t4);
    end


    if (t < t5 && t >= t4)
        x = [1 t t^2 t^3]*Traj_plan(x4(1),x5(1),t4,t5);
        y = [1 t t^2 t^3]*Traj_plan(x4(2),x5(2),t4,t5);
        z = [1 t t^2 t^3]*Traj_plan(x4(3),x5(3),t4,t5);
    end

    if (t < t6 && t >= t5)
        x = [1 t t^2 t^3]*Traj_plan(x5(1),x6(1),t5,t6);
        y = [1 t t^2 t^3]*Traj_plan(x5(2),x6(2),t5,t6);
        z = [1 t t^2 t^3]*Traj_plan(x5(3),x6(3),t5,t6);
    end

    if (t < t7 && t >= t6)
        x = [1 t t^2 t^3]*Traj_plan(x6(1),x7(1),t6,t7);
        y = [1 t t^2 t^3]*Traj_plan(x6(2),x7(2),t6,t7);
        z = [1 t t^2 t^3]*Traj_plan(x6(3),x7(3),t6,t7);
    end

    if (t > t7)
        x = 0;
        y = 0;
        z = 0;
    end

    plot3(x,y,z,'r.')
    axis equal
    grid on
    xlim([-1 7])
    ylim([-7 1])
    zlim([-1 7])
    view(-57, 34)
    xlabel("x position")
    ylabel("y position")
    zlabel("z position")
    hold on;
    drawnow

end

%% useful functions
function distance = dist(A,B)

distance = sqrt( (A(1)-B(1))^2 + (A(2)-B(2))^2 + (A(3)-B(3))^2 );

end

function coeffi = Traj_plan(p1,p2, tt1, tt2)

denomenator = (tt1 - tt2)^3;

first_coeffi    = -(-p2 * tt1 * tt1 * tt1 + 3 * p2 * tt1 * tt1 * tt2 - 3 * p1 * tt1 * tt2 * tt2 + p1 * tt2*tt2*tt2) / denomenator;

second_coeffi   = (-6*tt1*tt2 * (p1 - p2)) / denomenator;

third_coeffi    = (3*(tt1+tt2) * (p1 - p2)) / denomenator;

forth_coeffi    = (-2*(p1 - p2))/denomenator;


% first_coeffi = -(- p2*tt1^3 + 3*p2*tt1^2*tt2 - 3*p1*tt1*tt2^2 + p1*tt2^3)/(tt1 - tt2)^3;
% second_coeffi =                -(6*tt1*tt2*(p1 - p2))/(tt1 - tt2)^3;
%                                  (3*(tt1 + tt2)*(p1 - p2))/(tt1 - tt2)^3
%                                             -(2*(p1 - p2))/(tt1 - tt2)^3

coeffi = [first_coeffi;second_coeffi;third_coeffi;forth_coeffi];

end
