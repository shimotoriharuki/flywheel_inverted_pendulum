clc
clear

% パラメータ
g = 9.80665;
l = 0.1;
l_g = l/2;
m1 = 0.1;
m2 = 1;
r = 0.05; % [m]
I1 = (1/12) * m1 * (l)^2; 
I2 = (1/2) * m2 * r^2;
c1 = 1*10^-3; % 粘性係数 1*10^-3
c2 = 1*10^-3; % フライホイールの粘性係数

M1 = (-c1/(m2*l^2 + m1*l_g^2 + I1));
M2 = (c2/(m2*l^2 + m1*l_g^2 + I1));
M3 = (g*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1);
M4 = 1/(m2*l^2 + m1*l_g^2 + I1);
M5 = (c1/(m2*l^2 + m1*l_g^2 + I1));
M6 = (-((c2*m2*l^2)/I2 + (c2*m1*l_g^2)/I2 + c2 + (I1*c2)/I2)/(m2*l^2 + m1*l_g^2 + I1));
M7 = (-g*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1);
M8 = (-((m2*l^2)/I2 + (m1*l_g^2)/I2 + I1/I2 + 1)/(m2*l^2 + m1*l_g^2 + I1));

A = [0, 0, 1, 0;
     0, 0, 0, 1;
     M3, 0, M1, M2;
     M7, 0, M5, M6];
B = [0; 0; M4; M8];
C = [1, 1, 0, 0];

Ab = [A, zeros(4, 1);
      -C, 0];
Bb = [B; 0];

% 可制御　可観測
Uc = [Bb, Ab*Bb, Ab^2*Bb, Ab^3*Bb, Ab^4*Bb];
if det(Uc) ~= 0
    disp('可制御である')
end
% Uo = [C; C*Ab; C*Ab^2; C*Ab^3; C*Ab^4];
% 
% if det(Uo) ~= 0
%     disp('可観測である')
% end



Q = [10, 0, 0, 0, 0;
     0, 0.001, 0, 0, 0;
     0, 0, 0.001, 0, 0;
     0, 0, 0, 0.001, 0;
     0, 0, 0, 0, 1];
R = 0.01;
gain = lqr(Ab, Bb, Q, R);
f = gain(1:4);
k = -gain(5);

% シミュレーション
dt = 0.001;
t = 0 : dt : 10;
xb0 = [0.1; 0; 0; 0]; % 初期値
z = 0; % 偏差の積分
v = [10; 1; 1; 1]; % 外乱
r = 0; % 目標値


u = 0; % 入力の初期値
xb = xb0;

s_x1 = [];
s_x2 = [];
s_x3 = [];
s_x4 = [];
s_z = [];
s_u = [];
for n = t
    dxb = Ab * [xb; z] + Bb * u + [v; r];
    xb = xb + dxb(1:4, 1) * dt;
    z = z + dxb(5) * dt;
    u = -f*xb + k*z;
    
    s_x1 = [s_x1 xb(1)];
    s_x2 = [s_x2 xb(2)];
    s_x3 = [s_x3 xb(3)];
    s_x4 = [s_x4 xb(4)];
    s_z = [s_z z];
    s_u = [s_u u];

end

figure(3)
subplot(2, 2, 1)
plot(t, s_x1);
legend('th_1')
title('状態フィードバックのシミュレーション')

subplot(2, 2, 3)
plot(t, s_x2);
legend('th_2')
title('状態フィードバックのシミュレーション')

subplot(2, 2, 2)
plot(t, s_x3);
legend('dth_1')
title('状態フィードバックのシミュレーション')

subplot(2, 2, 4)
plot(t, s_x4);
legend('dth_2')
title('状態フィードバックのシミュレーション')

figure(4)
plot(t, s_z);
legend('z')
title('状態フィードバックのシミュレーション')

figure(5)
plot(t, s_u);
legend('u')
title('状態フィードバックのシミュレーション')