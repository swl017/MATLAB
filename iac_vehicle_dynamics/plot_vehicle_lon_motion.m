pl = lonp;
vx_max = [];
dt = 0.04;
time = 0:dt:60;

figure()

for i = 1:length(pl.m)
    Cm1 = pl.Cm1(i);
    Cm2 = pl.Cm2(i);
    Cr0 = pl.Cr0(i);
    Cr2 = pl.Cr2(i);
    m   = pl.m(i);
    syms vx;
    eq = (Cm1 - Cm2 * vx) - Cr0 - Cr2 * vx^2 == 0;
    vx = solve(eq,vx);
    vx = double(max(vx));
    if ~isempty(vx)
        vx_max(end+1) = double(max(vx));
        v = 0;
        vt = zeros(length(time),1);
        j = 1;
        for t = time
            Fx = (Cm1 - Cm2 * v) - Cr0 - Cr2 * v^2;
            v  = v + Fx/m * dt;
            vt(j) = v;
            j  = j+1;
        end
    end
    subplot(3,1,i)
    plot(time,vt)
    hold on;
    grid on;
%     axis([-inf inf 0 inf])
    
    xlabel("time (s)");
    ylabel("vx (m/s)");
    if i == 1
        legend(legend1);
        title("by Spec vx_{max} = "+num2str(floor(vx))+" m/s");
    elseif i == 2
        legend(legend2);
        title("Measured vx_{max} = "+num2str(floor(vx))+" m/s");
    elseif i == 3
        legend(legend3);
        title("model\_iac.json vx_{max} = "+num2str(floor(vx))+" m/s");
    end
end

            