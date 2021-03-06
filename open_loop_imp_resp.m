M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.8;
l = 0.3;
q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');

P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);

P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q);

sys_tf = [P_cart ; P_pend];

inputs = {'u'};
outputs = {'x'; 'phi'};

set(sys_tf,'InputName',inputs)
set(sys_tf,'OutputName',outputs)

t=0:0.01:1;
impulse(sys_tf,t)
title('Open-Loop Impulse Response')

t = 0:0.05:10;
u = ones(size(t))

[y,t] = lsim(sys_tf,u,t);
plot(t,y);
title('Open-Loop Step Response')
axis([0 3 0 50])
legend('x','phi')

for k=1:100:length(t)
    drawcartpend_i_p(y(k,:),20*m,20*M,20*l);
    y(k,:)
    pause(1.0);
end