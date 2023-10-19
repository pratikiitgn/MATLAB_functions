clc             % this will erase the command window
clear all       % This will clear the workspace

% system parameters
m = 1.5;        % mass of the quadcopter
g = 9.81;       % gravitational acceleration
Jq1     = 1.13/100; Jq2 = 1.33/100; Jq3 = 1.87/100;         % moment of intertias of the quadcopter about their first, second and third axes
J       = [Jq1, 0, 0;  0, Jq2, 0; 0,0, Jq3];
