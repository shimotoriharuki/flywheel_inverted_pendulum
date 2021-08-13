clear
clc

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

%ラグランジアン
L = K1 - U1;

% 運動方程式
eqn = functionalDerivative(L, th1) == 0;
% texlabel(eqn,'literal')
% simplify(eqn)

% sinθはθが微小のときはθなので、置き換える。
eqn = subs(eqn,sin(th1),th1)

% θについて解いてみる
sol = dsolve(eqn, th1(0) == 1, dth1(0) == 10)
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
    x(i) = (exp((n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(10*I1 + (g*l_g*m1*(m1*l_g^2 + I1))^(1/2) + 10*l_g^2*m1))/(2*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2)) - (exp(-(n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(10*I1 - (g*l_g*m1*(m1*l_g^2 + I1))^(1/2) + 10*l_g^2*m1))/(2*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))


end

plot(t, x)



