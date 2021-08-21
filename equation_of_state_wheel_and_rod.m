clc
clear

syms l_g th1(t) m1 I1 g l th2(t) m2 I2 Tw c1 c2

% 運動方程式
eq_ddth1 = diff(th1(t), t, t) == (Tw - c1*diff(th1(t), t) + c2*diff(th2(t), t) + g*th1(t)*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1)
eq_ddth2 = diff(th2(t), t, t) == -(Tw - c1*diff(th1(t), t) + c2*diff(th2(t), t) + g*th1(t)*(l*m2 + l_g*m1) + (I1*(c2*diff(th2(t), t) + Tw))/I2 + (l^2*m2*(c2*diff(th2(t), t) + Tw))/I2 + (l_g^2*m1*(c2*diff(th2(t), t) + Tw))/I2)/(m2*l^2 + m1*l_g^2 + I1)

% 係数をまとめる
eq_ddth1_collect = collect(eq_ddth1, [th1(1), th2(t), diff(th1(t), t), diff(th2(t), t), Tw])
eq_ddth2_collect = collect(eq_ddth2, [th1(1), th2(t), diff(th1(t), t), diff(th2(t), t), Tw])

latex(eq_ddth1_collect)
latex(eq_ddth2_collect)

% パラメータ
g = 9.80665;
l = 0.1;
l_g = l/2;
m1 = 0.1;
m2 = 1;
r = 0.025; % [m]
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

% 可制御　可観測
Uc = [B, A*B, A^2*B, A^3*B];
det(Uc)
Uo = [C; C*A; C*A^2; C*A^3];
det(Uo)

dt = 0.001;
t = 0 : dt : 0.1;
i = 0;
x = [0.1; 0; 0; 0];
u = 0;
x1 = [];
x2 = [];
x3 = [];
x4 = [];
for n = t
    i = i + 1;
    dx = A * x + B * u;
    x = x + dx * dt;
    
    x1 = [x1, x(1)];
    x2 = [x2, x(2)];
    x3 = [x3, x(3)];
    x4 = [x4, x(4)];
end

figure(2)
subplot(2, 2, 1)
plot(t, x1);
legend('th_1')
title('状態方程式のシミュレーション')

subplot(2, 2, 2)
plot(t, x2);
legend('th_2')
title('状態方程式のシミュレーション')

subplot(2, 2, 3)
plot(t, x3);
legend('dth_1')
title('状態方程式のシミュレーション')

subplot(2, 2, 4)
plot(t, x4);
legend('dth_2')
title('状態方程式のシミュレーション')

