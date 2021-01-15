p = param;

for i = 1:2
    if i == 1
        C_alpha=1700;
        Fz = 2000;
        alpha_max = 5.35;
    elseif i == 2
        C_alpha=2280;
        Fz = 4000;
        alpha_max = 6.65;
    end
        
    for k = 2.1:0.1:3.5
        syms Cs
        eq = tan(pi/(2*Cs))-k/Cs == 0;
        C = double(solve(eq,Cs));
        C = abs(C);
        D = C_alpha*alpha_max/k;
        B = k/(alpha_max*C);
        p.F{end+1} = Fz;
        p.C_alpha{end} = C_alpha;
        p.alpha_max{end} = alpha_max;
        p.k{end} = k;
        p.D{end} = D;
        p.C{end} = C;
        p.B{end} = B;
    end
end
    
        
        