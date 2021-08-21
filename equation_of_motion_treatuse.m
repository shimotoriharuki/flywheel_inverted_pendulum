clear

syms I1 I2 m1 m2 l lg th1(t) th2(t) g c1 c2 T
dth1 = diff(th1, t);
dth2 = diff(th2, t);
ddth1 = diff(th1, t, t);
ddth2 = diff(th2, t, t);

% 運動方程式
eq1 = (I1 + I2 + m1*lg^2 + m2*l^2) * ddth1 + I2 * ddth2 + -(m1*lg + m2*l)*g*sin(th1) + c1*dth1 == 0; % ...①
eq2 = I2 * ddth1 + I2 * ddth2 + c2 * dth2 == T; % ...②

eq_ddth1_2 = rhs(isolate(eq2, ddth1)); % ...③　②のddth1を左辺に持ってくる　右辺だけ取得
eq_ddth2_2 = rhs(isolate(eq2, ddth2)); % ...④　②のddth2を左辺に持ってくる　右辺だけ取得

eq_ddth1 = subs(eq1, ddth2, eq_ddth2_2) % ①のddth2に④を代入
eq_ddth2 = subs(eq1, ddth1, eq_ddth1_2) % ①のddth1に③を代入

eq_ddth1 = isolate(eq_ddth1, ddth1) % ddth1を左辺に移動
eq_ddth2 = isolate(eq_ddth2, ddth2) % ddth2を左辺に移動