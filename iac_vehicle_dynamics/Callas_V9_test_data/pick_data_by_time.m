t_t = 10.0;

m = 719.233;
Ixx = 70.6817;
Iyy = 524;
Izz = 604.101;

[accel_t, accel_i] = min(abs(accelcdg.Time - t_t));
[speed_t, speed_i] = min(abs(distancetangentialspeed.Time - t_t));
[throttle_t, throttle_i] = min(abs(CommandsCommands.Time - t_t));

accel_t = accel_t + t_t;
speed_t = speed_t + t_t;
throttle_t = throttle_t + t_t;

% Fx = (Cm1 - Cm2*vx)*d - Cr0 - Cr2*vx**2;
% Cm1 = (Fx + Cr0 + Cr2*vx**2)/d + Cm2*vx;
% Fx = m*a
Fx = m*accelcdg.CoGAccelerationX(accel_i);
Cr0 = 20; % 15 or 20
Cr2 = 0.725;
d = CommandsCommands.Gaspedal(throttle_i);
% d = CommandsCommands.Brakepedalforce(throttle_i)/40;
Cm2 = 0.05;
vx = distancetangentialspeed.Horizontaltangentialspeed(speed_i);

Cm1 = (Fx + Cr0 + Cr2*vx^2)/d + Cm2*vx;
