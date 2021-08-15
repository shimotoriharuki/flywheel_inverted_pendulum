clc
clf

% parameters
g = 9.80665; % [m/s^2]
m = 0.1; % [kg]
l_g = 0.05; % [m]
% I = 1 * 10^-3; % [kg m^2]
I = (1/3) * m * (l_g*2)^2;
c = 1 * 10^-2.5; % 粘性係数

X = (g * m * l_g) / (m * l_g^2 + I);
Y = c / (m * l_g^2 + I);
Z = 1 / (m * l_g^2 + I);

% equation of state
A = [0, 1; X, -Y];
B = [0; -Z];
C = [1 0];

% 可制御　可観測
Uc = [B, A*B];
det(Uc)
Uo = [C; C*A];
det(Uo)

% シミュレーション

dt = 0.001;
t = 0 : dt : 0.1;
i = 0;
x = [0.01; 0];
u = 0.0;
x1 = [];
x2 = [];
for n = t
    i = i + 1;
    dx = A * x + B * u;
    x = x + dx * dt;
    
    x1 = [x1, x(1)];
    x2 = [x2, x(2)];
end

figure(1)
plot(t, x1);

% アニメーション
figure(2)
xlim([-1 1])
ylim([-1 1])
i = 0;
for n = t
    i = i + 1;    
    if rem(i, 10) == 0
        x = [0 sin(x1(i))];
        y = [0 cos(x1(i))];
%         plot([0 sin(x1(i))], [0 cos(x1(i))], '.b'); 
        g = line(x, y);
        drawnow;
        delete(g);
    end
end


