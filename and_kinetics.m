%AND gate logic bits analysis using differential equation dictating
%molecualr computation
k = 5.56*10^4;
f = @(t,x) [-k*x(2)*x(1) + 2*k*x(1)*x(3);
            -k*x(2)*x(1) + 2*k*x(2)*x(3);
             k*x(2)*x(1)  - k*x(3)*x(1) - k*x(3)*x(2);
             -k*x(5)*x(4) + 2*k*x(4)*x(6);
            -k*x(5)*x(4) + 2*k*x(5)*x(6);
             k*x(5)*x(4)  - k*x(6)*x(4) - k*x(6)*x(5);
             -k*x(8)*x(7) + 2*k*x(7)*x(9) - k*x(10) * x(7) + k*x(1)*x(8) + k*x(4)*x(8);
             -k*x(8)*x(7) + 2*k*x(8)*x(9) - k*x(1)*x(8) - k*x(8)*x(4) + k*x(10)*x(7);
             k*x(8)*x(7)  - k*x(9)*x(7) - k*x(9)*x(8);
             k*x(2)*x(5) - x(10)*k*x(7) - x(10)^2*k ];
            [t, xa] = ode15s(f,[0 20000000], [0 1*10^-9 1*10^-15 0 1*10^-9 1*10^-15 .9*10^-9 .1*10^-9 1*10^-15 1*10^-12]);
   plot(t,xa(:,2));
hold on;
plot(t,xa(:,5));
plot(t,xa(:,7));
plot(t,xa(:,8));

legend('X1', 'Y1', 'Z0', 'Z1');
ylabel('Molarity');
xlabel('time (s)');
title('switching of an AND gate');
grid on;