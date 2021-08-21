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
simplify(Kr);


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
simplify(Kw);

% ---------- 両方の位置エネルギ ----------%
U = m1*g*y1_g + m2*g*y2_g;
simplify(U);

%ラグランジアン
L = Kr + Kw - U;
L = simplify(L);

syms Tw c1 c2
eqn_th1 = functionalDerivative(L, th1) == 0;
eqn_th1 = lhs(eqn_th1) - c1*diff(th1(t), t) == 0; % 粘性を追加する
eqn_th1 = simplify(eqn_th1); % ...1
eqn_th2 = functionalDerivative(L, th2) == Tw; % ...2
eqn_th2 = lhs(eqn_th2) - c2*diff(th2(t), t) == Tw; % 粘性を追加する

ddth2_2 = rhs(isolate(eqn_th2, diff(th2(t), t, t))); % ...3 2をddth2について解く 解いた方程式の右辺を取得
eqn_ddth1 = subs(eqn_th1, diff(th2(t), t, t), ddth2_2); % 3を1に代入
eqn_ddth1 = isolate(eqn_ddth1, diff(th1(t), t, t)) % ddth1について解く

ddth1_2 = rhs(isolate(eqn_th2, diff(th1(t), t, t))); % ...4 2をddth1について解く 解いた方程式の右辺を取得
eqn_ddth2 = subs(eqn_th1, diff(th1(t), t, t), ddth1_2); % 4を1に代入
eqn_ddth2 = isolate(eqn_ddth2, diff(th2(t), t, t)) % ddth2について解く
% latex(eqn_ddth2)


% ------- 線形化 ------%
eqn_ddth1_linear = subs(eqn_ddth1, sin(th1), th1)
eqn_ddth2_linear = subs(eqn_ddth2, sin(th1), th1)

