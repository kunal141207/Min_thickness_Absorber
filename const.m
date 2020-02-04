function [c ceq] = const(x)
    c = reflectivity(x) - 0.3162;
    ceq =[];
