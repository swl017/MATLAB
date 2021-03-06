% Vehicle Longitudinal Parameter Plotter
% 
% Fx = (Cm1 - Cm2 * vx) * D - Cr0 - Cr2 * vx^2
% 
% Data: param.mat/lonp

pl = lonp;
vx_max = [];

figure()
D = 0:0.05:1;
legend1 = [];
legend2 = [];
legend3 = [];

for i = 1:length(pl.m)
    Cm1 = pl.Cm1(i);
    Cm2 = pl.Cm2(i);
    Cr0 = pl.Cr0(i);
    Cr2 = pl.Cr2(i);
    syms vx;
    eq = (Cm1 - Cm2 * vx) - Cr0 - Cr2 * vx^2 == 0;
    vx = solve(eq,vx);
    vx = double(max(vx));
    if ~isempty(vx)
        vx_max(end+1) = double(max(vx));
        for v = 0/3.6:100/3.6:vx
            Fx = (Cm1 - Cm2 * v) .* D - Cr0 - Cr2 * v^2;
            subplot(3,1,i)
            plot(D,Fx)
            hold on
            if i == 1
                legend1{end+1} = "v = "+num2str(floor(v))+" m/s";
            elseif i == 2
                legend2{end+1} = "v = "+num2str(floor(v))+" m/s";
            elseif i == 3
                legend3{end+1} = "v = "+num2str(floor(v))+" m/s";
            end
        end
    end
    subplot(3,1,i)
    grid on;
    axis([-inf inf 0 inf])
    
    xlabel("throttle (0~1)");
    ylabel("Fx (N)");
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

