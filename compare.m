th1_sim = out.simout.Data(: ,1);
th2_sim = out.simout.Data(: ,2);
dth1_sim = out.simout.Data(: , 3);
dth2_sim = out.simout.Data(: ,4);
t_sim = out.simout.Time;

figure(1)
subplot(2, 2, 1)
plot(t, s_th1)
hold on
plot(t_sim, th1_sim)
hold off
legend('数値シミュレーション', "Simscapeシミュレーション")
title('$\theta_{p}$', 'Interpreter', 'latex')

subplot(2, 2, 2)
plot(t, s_th2)
hold on
plot(t_sim, th2_sim)
hold off
legend('数値シミュレーション', "Simscapeシミュレーション")
title('$\theta_{w}$', 'Interpreter', 'latex')

subplot(2, 2, 3)
plot(t, s_dth1)
hold on
plot(t_sim, dth1_sim)
hold off
legend('数値シミュレーション', "Simscapeシミュレーション")
title('$\dot{\theta_{p}}$', 'Interpreter', 'latex')

subplot(2, 2, 4)
plot(t, s_dth2)
hold on
plot(t_sim, dth2_sim)
hold off
legend('数値シミュレーション', "Simscapeシミュレーション")
title('$\dot{\theta_{w}}$', 'Interpreter', 'latex')
