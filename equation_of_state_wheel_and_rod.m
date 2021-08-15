clc
clear
clf

% parameters
g = -9.80665; % [m/s^2] ホントは＋
m1 = 0.1; % [kg]
m2 = 0.1; % [kg]
l_g = 0.05; % [m]
l = l_g*2; % [m]
r = 0.025; % [m]
I1 = (1/3) * m1 * (l_g*2)^2;
I2 = (1/2) * m2 * r^2;
c1 = 1 * 10^-2.5; % 粘性係数
c2 = 1 * 10^-2.5; % フライホイールの粘性係数

W = -1 / I2;
X = c2 / I2;
Y = ((m2*l + m1*l_g)*g) / (m1*l_g^2 + m2*l^2 + I1);
Z = -c1 / (m1*l_g^2 + m2*l^2 + I1);
V = I1 + I2;

% equation of state
A = [0, 1, 0, 0;
     Y, Z, 0, 0;
     0, 0, 0, 1;
     0, 0, 0, X];
B = [0; V; 0; W];
C = [1, 0, 1, 0];

% 可制御　可観測
Uc = [B, A*B, A^2*B, A^3*B];
det(Uc)
Uo = [C; C*A; C*A^2; C*A^3];
det(Uo)

dt = 0.001;
t = 0 : dt : 5;
i = 0;
x = [0.1; 0; 0; 0];
u = 0.00;
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

figure(1)
subplot(2, 2, 1)
plot(t, x1);
legend('th_1')

subplot(2, 2, 2)
plot(t, x2);
legend('dth_1')

subplot(2, 2, 3)
plot(t, x3);
legend('th_2')

subplot(2, 2, 4)
plot(t, x4);
legend('dth_2')

% アニメーション
figure(2)
xlim([-1 1])
ylim([-1 1])
i = 0;
for n = t
    i = i + 1;    
    if rem(i, 20) == 0
        x = [0 sin(x1(i))];
        y = [0 cos(x1(i))];
%         plot([0 sin(x1(i))], [0 cos(x1(i))], '.b'); 
        g = line(x, y);
        drawnow;
        delete(g);
    end
end