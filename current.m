function [Efin, Ifin] = current(t_f,E0,E_s)
% t_f = time the applied potential is changed, so equal to 20
% E0 is E^0
% E_s is E_start
% I_0 is initial current (What is it?!)
if nargin==0
    t_f=20;
    E0=0;
    E_s=-10
end
I_0=0;

N = 200;
% time step
dt = 1/N;


% total iterations
M = t_f/dt;


% time vector
t = zeros(1,M+1);
t(1) = 0;
for i = 2:M+1
    t(i) = t(i-1) + dt;
end

% functions for E(t), e1 for 0 < t < 20, e2 for 20 < t < 40
    function [E1] = e1(a)
        E1 = E_s + a;
    end

    function [E2] = e2(a)
        E2 = E_s + 20 - a;
    end


% I(t) is current for e1
I = zeros(1,M+1);
I(1) = I_0;
I(2) = (1/(2*sqrt(t(2))))*((sqrt(pi))/(exp(-e1(t(2)) + E0) + 1));

A = zeros(1,M);
A(1) = 0;
A(2) = (sqrt(t(3)))*(I(2) - I(1));

for i = 3:M+1
   a = 0;
   for j = 2:(i-1)
   a = a + ((sqrt(t(i) - t(j-1)))*(I(j) - I(j-1)));
   end
   A(i-1) = a;
   
   I(i) = I(i-1) + (  (1/2)*((sqrt(pi))/(exp(-e1(t(i)) + E0) + 1))   - I(1)*sqrt(t(i)) - A(i-1)   );   
end


% J(t) is current for e2
J = zeros(1,M+1);
J(1) = I(M+1);
J(2) = (1/(2*sqrt(t(2))))*((sqrt(pi))/(exp(-e2(t(2)) + E0) + 1));

B = zeros(1,M);
B(1) = 0;
B(2) = (sqrt(t(3)))*(J(2) - J(1));

for i = 3:M+1
   b = 0;
   for j = 2:(i-1)
   b = b + ((sqrt(t(i) - t(j-1)))*(J(j) - J(j-1)));
   end
   B(i-1) = b;
   
   J(i) = J(i-1) + (  (1/2)*((sqrt(pi))/(exp(-e2(t(i)) + E0) + 1))   - J(1)*sqrt(t(i)) - B(i-1)   );   
end

for i = 1:M+1
    e_1(i) = e1(t(i));
end

for i = 1:M+1
    e_2(i) = e2(t(i));
end

% cut of first 'indis' indices
indis = 100;
plot(e_1(indis:M+1),I(indis:M+1))
hold on
plot(e_2(indis:M+1),J(indis:M+1))




end


