function [APM] = obj_fun_npm(x)

% Objective function based on neighborhood phase margin
% Constants: tau, k, kp, omega_c
% Inputs: lambda, kd
% Outputs: obj=area phase margin
% Demo:
%  obj_fun_apm([-0.9694 0.6192])
%  kp = 2.6992;
lambda=x(1);kd=x(2);

%% Step one: Preparing necessary data
% Plant parameters
global K T1
% K = 1.0263;
% T1 = 0.71;
tau=T1;k=K;

% Controller design specifications
global wc phi_m
% wc = 2.51; %crossover frequency
% phi_m=83.9;

%% Step two: Calculate area phase margin to build the objective function
w=wc;
delta = 1.25;
APM1 = atan2(kd*w^lambda*sin(pi*lambda/2),(1+kd*w^lambda*cos(pi*lambda/2)))...
    +atan2(1,T1*w);
w=wc*delta;
APM2 = atan2(kd*w^lambda*sin(pi*lambda/2),(1+kd*w^lambda*cos(pi*lambda/2)))...
    +atan2(1,T1*w);
w=wc/delta;
APM3 = atan2(kd*w^lambda*sin(pi*lambda/2),(1+kd*w^lambda*cos(pi*lambda/2)))...
    +atan2(1,T1*w);
sigma = 2;
APM = 2*abs(phi_m-APM1/pi*180)+abs(phi_m+sigma-APM2/pi*180)+abs(phi_m-sigma-APM3/pi*180);
%APM = 2*abs(phi_m-APM1/pi*180)-APM2/pi*180-APM3/pi*180;
% to get the min value max, so we use a negative symbol.

end

