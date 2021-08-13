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
K1 = simplify(K1)

% 位置エネルギ
U1 = m1 * g * y1_g