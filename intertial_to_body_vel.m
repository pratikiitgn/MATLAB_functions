function body_vel = intertial_to_body_vel(ph,th,ps, ph_dot,th_dot, ps_dot)
%% This is followed by ZXY rotation

body_vel = [0 ; th_dot; 0] + func_roty(th)*[ph_dot; 0; 0] + func_roty(th)*func_roty(ph)*[0;0;ps_dot];

end
