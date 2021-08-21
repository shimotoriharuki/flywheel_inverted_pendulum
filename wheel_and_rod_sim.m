clear
clc


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

dt = 0.001;
t = 0 : dt : 0.1;
i = 0;
dth1 = 0;
dth2 = 0;
th1 = 0.1;
th2 = 0;
Tw = 0;

s_th1 = [];
s_th2 = [];
s_dth1 = [];
s_dth2 = [];
for n = t
    i = i + 1;
    % 自分で求めた運動方程式
%     ddth1 = (Tw - c1*dth1 + c2*dth2 + g*sin(th1)*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1);
%     ddth2 = -(Tw - c1*dth1 + c2*dth2 + (I1*(Tw + c2*dth2))/I2 + g*sin(th1)*(l*m2 + l_g*m1) + (l^2*m2*(Tw + c2*dth2))/I2 + (l_g^2*m1*(Tw + c2*dth2))/I2)/(m2*l^2 + m1*l_g^2 + I1);
    % 論文の運動方程式
%     ddth1 = -(Tw + c1*dth1 - c2*dth2 - g*sin(th1)*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1)
%     ddth2 = (c1*dth1 + ((Tw - c2*dth2)*(m2*l^2 + m1*l_g^2 + I1 + I2))/I2 - g*sin(th1)*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1)
    % 線形化した運動方程式
    ddth1 = (Tw - c1*dth1 + c2*dth2 + g*th1*(l*m2 + l_g*m1))/(m2*l^2 + m1*l_g^2 + I1);
    ddth2 = -(Tw - c1*dth1 + c2*dth2 + g*th1*(l*m2 + l_g*m1) + (I1*(c2*dth2 + Tw))/I2 + (l^2*m2*(c2*dth2 + Tw))/I2 + (l_g^2*m1*(c2*dth2 + Tw))/I2)/(m2*l^2 + m1*l_g^2 + I1);
    
    dth1 = dth1 + ddth1 * dt;
    dth2 = dth2 + ddth2 * dt;
    
    th1 = th1 + dth1 * dt;
    th2 = th2 + dth2 * dt;
    
    s_th1 = [s_th1 th1];
    s_th2 = [s_th2 th2];
    s_dth1 = [s_dth1 dth1];
    s_dth2 = [s_dth2 dth2];
end

figure(1)
subplot(2, 2, 1)
plot(t, s_th1)
legend('th1')
title('運動方程式のシミュレーション')

subplot(2, 2, 2)
plot(t, s_th2)
legend('th2')
title('運動方程式のシミュレーション')

subplot(2, 2, 3)
plot(t, s_dth1)
legend('dth2')
title('運動方程式のシミュレーション')

subplot(2, 2, 4)
plot(t, s_dth2)
legend('dth2')
title('運動方程式のシミュレーション')