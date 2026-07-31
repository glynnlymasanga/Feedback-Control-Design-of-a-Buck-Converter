clc;
clear;
close all;

%% ============================================================
%  Feedback Control Design of a Buck Converter
%  Open-Loop Frequency Response Comparison
%  P, PI and PID Controllers
%% ============================================================

s = tf('s');

%% ============================================================
% Buck Converter Small-Signal Plant
%
%               4.8e9
% Gvd(s) = -------------------
%           s² + 1000s + 2e8
%% ============================================================

Gvd = tf(4.8e9,[1 1000 2e8]);

%% ============================================================
% Controller Parameters
%% ============================================================

%----------------------------
% Proportional Controller
%----------------------------
Kp_P = 0.042;

%----------------------------
% PI Controller
%----------------------------
Kp_PI = 0.0399;
Ki_PI = 16.9;

%----------------------------
% PID Controller
%----------------------------
Kp_PID = 0.0367;
Ki_PID = 11.97;
Kd_PID = 1.995e-5;

%% ============================================================
% Controller Transfer Functions
%% ============================================================

C_P   = Kp_P;

C_PI  = Kp_PI + Ki_PI/s;

C_PID = Kp_PID + Ki_PID/s + Kd_PID*s;

%% ============================================================
% Open-Loop Transfer Functions
%% ============================================================

L_P   = minreal(C_P   * Gvd);
L_PI  = minreal(C_PI  * Gvd);
L_PID = minreal(C_PID * Gvd);

%% ============================================================
% Bode Plot
%% ============================================================

figure('Color','w');

h = bodeplot(L_P,L_PI,L_PID);

grid on

setoptions(h,...
    'FreqUnits','rad/s',...
    'MagUnits','dB',...
    'PhaseVisible','on',...
    'Grid','on');

title('Open-Loop Bode Plot Comparison')

legend('P Controller',...
       'PI Controller',...
       'PID Controller',...
       'Location','best');

%% ============================================================
% Classical Stability Margins
%% ============================================================

fprintf('\n==============================================\n');
fprintf('         CLASSICAL STABILITY MARGINS\n');
fprintf('==============================================\n');

controllers = {L_P,L_PI,L_PID};
names = {'P','PI','PID'};

for k = 1:length(controllers)

    [GM,PM,Wcg,Wcp] = margin(controllers{k});

    fprintf('\n%s Controller\n',names{k});
    fprintf('-----------------------------\n');
    fprintf('Phase Margin : %8.2f deg\n',PM);

    if isinf(GM)
        fprintf('Gain Margin  : Infinite\n');
    else
        fprintf('Gain Margin  : %8.2f dB\n',20*log10(GM));
    end

    fprintf('Gain Crossover Frequency  : %10.2f rad/s\n',Wcg);
    fprintf('Phase Crossover Frequency : %10.2f rad/s\n',Wcp);

end

%% ============================================================
% Complete Margin Information
% (Useful when multiple crossover frequencies exist.)
%% ============================================================

fprintf('\n==============================================\n');
fprintf('          COMPLETE MARGIN ANALYSIS\n');
fprintf('==============================================\n');

disp(' ');
disp('P Controller');
disp(allmargin(L_P));

disp(' ');
disp('PI Controller');
disp(allmargin(L_PI));

disp(' ');
disp('PID Controller');
disp(allmargin(L_PID));