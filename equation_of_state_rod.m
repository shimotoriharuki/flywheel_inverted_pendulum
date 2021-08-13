clc

% ddth1を左辺に持ってくる
isolate(eqn, diff(th1(t), t, t))

% th1を左辺に持ってくる
isolate(eqn, th1)