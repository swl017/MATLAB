syms vx;
Cm1 = 5000;
d = 1.0;
eq = (Cm1 - Cm2*vx)*d - Cr0 - Cr2*vx^2==0;
vx_f = solve(eq, vx);
max(double(vx_f))*3.6