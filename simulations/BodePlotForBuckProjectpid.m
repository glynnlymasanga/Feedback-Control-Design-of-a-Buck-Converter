% clc; clear; close all;

s = tf('s');

% Plant
G = 1e8 / (s^2 + 1e3*s + 2e8);

% -------------------------
% Controllers
% -------------------------

% P
Kp_P = 2;
C_P = Kp_P;

% PI
Kp_PI = 1.92;
Ki_PI = 813;
C_PI = Kp_PI + Ki_PI/s;

% PID
Kp_PID = 1.76;
Ki_PID = 575;
Kd_PID = 0.00096;
C_PID = Kp_PID + Ki_PID/s + Kd_PID*s;

% -------------------------
% Open-loop systems
% -------------------------

L_P = C_P * G;
L_PI = C_PI * G;
L_PID = C_PID * G;

% -------------------------
% Bode Plot
% -------------------------

figure;
bode(L_P, 'b', L_PI, 'r', L_PID, 'g')
grid on;

legend('P Controller','PI Controller','PID Controller')

title('Bode Plot Comparison: P vs PI vs PID')