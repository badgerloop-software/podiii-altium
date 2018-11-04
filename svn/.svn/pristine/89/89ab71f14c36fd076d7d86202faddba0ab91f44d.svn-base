function [c,ceq] = nonlinconstr(x,power, mass, tube_length)
% Equality
ceq = [];
% Inequality
c = [x(1)^2/x(3) + x(1)^2/x(2) - 2*tube_length;...
    x(1) - 2*pi*power / (mass*x(2))];
end