% Vehicle Lateral Parameter Plotter
% 
% Data: param.mat/param_feasible
% eq = tan(pi/(2*C))-k*C == 0
% solve(eq,C)
% for k = 1.9 ~ 3.0(?)
% then, D = C_alpha*alpha_max/k, B = k/(alpha_max*C)
% 
% Brief: convert linear tire model to Pacejka Magic formula
% 
% Fy = C_{alpha}*alpha
% into
% Fy = D*sin(C*atan(B*alpha))
% using
% C_{alpha} = D*C*B and C*atan(B*alpha_{max}) = pi/2
% and C_{alpha}*alpha_{max} = k*D
% Thus, plot depending on k = 1.6~2.0

% p = param;
p = param_feasible;

figure()

alpha = 0:0.2:30;
alpha_lin = 0:0.2:7;
C_alpha1 = p.C_alpha{1};
C_alpha2 = p.C_alpha{6};
Fy_lin1  = C_alpha1.*alpha_lin;
Fy_lin2  = C_alpha2.*alpha_lin;

legend1 = [];
legend2 = [];
legend3 = [];

for i = 1:length(p.F)
    B = p.B{i};
    C = p.C{i};
    D = p.D{i};
    k = p.k{i};
    Fz = p.F{i};
    if Fz == 2000
        subplot(311)
        Fy = D*sin(C*atan(B.*alpha));
        plot(alpha, Fy)
        legend1{end+1} = "k = "+num2str(k);
    elseif Fz == 4000
        subplot(312)
        Fy = D*sin(C*atan(B.*alpha));
        plot(alpha, Fy)
        legend2{end+1} = "k = "+num2str(k);
    end
    hold on
end

% Plot measured parameters
subplot(313)
B = 7.3689;
C = 1.9589;
D = 4702.8301;
Fy = D*sin(C*atan(B.*alpha*3.14/180));
plot(alpha, Fy)
legend3{end+1} = "Rear";
hold on
subplot(313)
B = 7.0215;
C = 1.9148;
D = 3621.6843;
Fy = D*sin(C*atan(B.*alpha*3.14/180));
plot(alpha, Fy)
legend3{end+1} = "Front";

% Formulate averaged params
subplot(313)
B = (7.0215 + 7.3689)/2;
C = (1.9148 + 1.9589)/2;
D = (3621.6843 + 4702.8301)/2;
Fy = D*sin(C*atan(B.*alpha*3.14/180));
plot(alpha, Fy)
legend3{end+1} = "Front+Rear/2";
B = (0.235685678073820);
C = (1.74476004071079);
D = (4134.09090909091);
Fy = D*sin(C*atan(B.*alpha));
plot(alpha, Fy)
legend3{end+1} = "by Spec k = 2.2";
B = (0.258631459375314);
C = (1.66223607558976);
D = (3954.34782608696);
Fy = D*sin(C*atan(B.*alpha));
plot(alpha, Fy)
legend3{end+1} = "by Spec k = 2.3";
B = 10;
C = 1.38;
D = 1500;
Fy = D*sin(C*atan(B.*alpha*3.14/180));
plot(alpha, Fy)
legend3{end+1} = "fullscale";

subplot(311)
title("Fz = 2000, C_{alpha} = 1700");
xlabel("slip angle (degree)")
ylabel("F_y (N)")
plot(alpha_lin, Fy_lin1, 'k--')
plot(alpha_lin, Fy_lin2, 'b--')
legend1{end+1} = "Fz = 2000 N";
legend1{end+1} = "Fz = 4000 N";
legend(legend1)
axis([-inf inf 0 5000])

subplot(312)
title("Fz = 4000, C_{alpha} = 2280");
xlabel("slip angle (degree)")
ylabel("F_y (N)")
plot(alpha_lin, Fy_lin1, 'k--')
plot(alpha_lin, Fy_lin2, 'b--')
legend2{end+1} = "Fz = 2000 N";
legend2{end+1} = "Fz = 4000 N";
legend(legend2)
axis([-inf inf 0 5000])

subplot(313)
title("Measured");
xlabel("slip angle (degree)")
ylabel("F_y (N)")
plot(alpha_lin, Fy_lin1, 'k--')
plot(alpha_lin, Fy_lin2, 'b--')
legend3{end+1} = "Fz = 2000 N";
legend3{end+1} = "Fz = 4000 N";
legend(legend3)
axis([-inf inf 0 5000])

