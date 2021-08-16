clear
clc

% ---------- 棒の運動エネルギ ------------%
% parameters
syms l_g th1(t) m1 I1 g;
dth1 = diff(th1, t);

% 重心位置
x1_g = l_g * sin(th1);
y1_g = l_g * cos(th1);

% 重心速度
dx1_g = diff(x1_g, t);
dy1_g = diff(y1_g, t);

Kr = (1/2)*m1*(dx1_g^2 + dy1_g^2) + (1/2)*I1*dth1^2;
simplify(Kr)


% ----------- フライホイールの運動エネルギ -----------%
% parameters
syms l th2(t) m2 I2 T;
dth2 = diff(th2, t);

% 重心位置
x2_g = l * sin(th1);
y2_g = l * cos(th1);

% 重心速度
dx2_g = diff(x2_g, t);
dy2_g = diff(y2_g, t);

Kw = (1/2)*m2*(dx2_g^2 + dy2_g^2) + (1/2)*I2*(dth1 + dth2)^2;
simplify(Kw)

% ---------- 両方の位置エネルギ ----------%
U = m1*g*y1_g + m2*g*y2_g;
simplify(U)

%ラグランジアン
L = Kr + Kw - U;
L = simplify(L)

syms Tr Tw
eqn_th1 = functionalDerivative(L, th1) == Tr;
simplify(eqn_th1)
eqn_th2 = functionalDerivative(L, th2) == Tw


% ------- 線形化 ------%
% eqn_th1 = subs(eqn_th1, sin(th1), th1)

% θについて解いてみる
sol = dsolve(eqn_th1, th1(0) == 0.1, dth1(0) == 0)
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
%     x(i) = (exp((n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(10*I1 + (g*l_g*m1*(m1*l_g^2 + I1))^(1/2) + 10*l_g^2*m1))/(2*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2)) - (exp(-(n*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))/(m1*l_g^2 + I1))*(10*I1 - (g*l_g*m1*(m1*l_g^2 + I1))^(1/2) + 10*l_g^2*m1))/(2*(g*l_g*m1*(m1*l_g^2 + I1))^(1/2))


end

% plot(t, x)
