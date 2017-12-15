k = 5.56*10^4;
%syms x0(t) x1(t) sx(t) 
%ode1 = diff(sx(t)) ==  k*x1*x0 -k*sx*x0 - k*sx*x1;
%ode2 = diff(x0(t)) == -k*x1*x0 + 2*k*sx*x0;
%ode3 = diff(x1(t)) == -k*x1*x0 + 2*k*sx*x1;

f = @(t,x) [-k*x(2)*x(1) + 2*k*x(1)*x(3);
            -k*x(2)*x(1) + 2*k*x(2)*x(3);
             k*x(2)*x(1)  - k*x(3)*x(1) - k*x(3)*x(2)];
[t, xa] = ode45(f,[0 200000], [.3*10^-9 .7*10^-9 0]);
plot(t,xa(:,1));
hold on;
plot(t,xa(:,2));
plot(t,xa(:,3));
legend('X0', 'X1', 'SX');
ylabel('Molarity');
xlabel('time (s)');
title('Representing a high bit');
grid on;