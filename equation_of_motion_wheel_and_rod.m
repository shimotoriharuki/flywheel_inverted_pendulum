clear
clc

% ---------- rod ------------%
% parameters
syms l_g th1(t) m1 I1 g;
dth1 = diff(th1, t);

% 重心位置
x1_g = l_g * sin(th1);
y1_g = l_g * cos(th1);

% 重心速度
dx1_g = diff(x1_g, t);
dy1_g = diff(y1_g, t);

% 並進エネルギ
K1_t = (1/2) * m1 * dx1_g^2 + (1/2) * m1 * dy1_g^2;
K1_t = simplify(K1_t); % 式をシンプルにする

% 回転エネルギ
K1_r = (1/2) * I1 * dth1^2;

% 運動エネルギ（並進＋回転）
K1 = K1_t + K1_r;
K1 = simplify(K1);

% 位置エネルギ
U1 = m1 * g * y1_g;

% ----------- flywheel -----------%
% parameters
syms l th2(t) m2 I2 T;
dth2 = diff(th2, t);

% 重心位置
x2_g = l * sin(th1);
y2_g = l * cos(th1);

% 重心速度
dx2_g = diff(x2_g, t);
dy2_g = diff(y2_g, t);

% 並進エネルギ
K2_t = (1/2) * m2 * dx2_g^2 + (1/2) * m2 * dy2_g^2;
K2_t = simplify(K2_t); % 式をシンプルにする

% 回転エネルギ
K2_r = (1/2) * I2 * dth2^2;

% 運動エネルギ（並進＋回転）
K2 = K2_t + K2_r;
K2 = simplify(K2);

% 位置エネルギ
U2 = m2 * g * y2_g;


%ラグランジアン
L = (K1 + K2) - (U1 + U2);

% 運動方程式
eqn_th1 = functionalDerivative(L, th1) == 0
eqn_th2 = functionalDerivative(L, th2) == T
% texlabel(eqn,'literal')
simplify(eqn_th1)

% sinθはθが微小のときはθなので、置き換える。
eqn_th1 = subs(eqn_th1,sin(th1),th1);

%{
% θについて解いてみる
sol = dsolve(eqn_th1, th1(0) == 1, dth1(0) == 10);
% texlabel(sol)

% 解いたやつでシミュレーションしてみる
t = 0 : 0.01 : 10;
l_g = 0.1;
m1 = 0.01; 
I1 = 1*10^-3;
g = -9.8;

i = 0;
for n = t
    i = i + 1;
%     x(i) = (exp(-(n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(exp((2*n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1)) + 1))/2
    x(i) = (exp((n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(10*I1 + (g*l_g*m1*(m1*l_g^2 + I1))^(1/2) + 10*l_g^2*m1))/(2*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2)) - (exp(-(n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(10*I1 - (g*l_g*m1*(m1*l_g^2 + I1))^(1/2) + 10*l_g^2*m1))/(2*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2));


end

plot(t, x)
%}


