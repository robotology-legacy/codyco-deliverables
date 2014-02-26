%%Robot properties
leg_mass = 4.014 + 0.4; %[kg] %from cad
leg_com  = 0.245; %[m] %from cad

knee_mass = leg_mass *0.40; %[kg] random value
knee_com = 0.12;% [m] random value


hip_dq_max = 6.5; %[deg/s]
hip_dq_max_rad = hip_dq_max / 180 * pi; %[rad/s]

knee_dq_max = 6; %[deg/s]
knee_dq_max_rad = knee_dq_max / 180 * pi;

%% hip joint

coulomb = (9.89676 / 5.53061); %[Nm]
viscous_rad = (3.80569 / 5.53061); %[Nm/(rad/s)]
viscous_deg = viscous_rad *180/pi; %[Nm/(deg/s)]

%equal friction power
hipEstimatedViscousCoefficient_deg = coulomb / hip_dq_max + viscous_deg;
hipEstimatedViscousCoefficient_rad = coulomb / hip_dq_max_rad  + viscous_rad;

% fprintf('Estimated viscous friction coefficient at %s:\n\t%f[Nm/(deg/s)]\n\t%f[Nm/(rad/s)]\n', 'hip', ...
%     hipEstimatedViscousCoefficient_deg, hipEstimatedViscousCoefficient_rad);

checkPowerHip_rad = hipEstimatedViscousCoefficient_rad * hip_dq_max_rad^2 - (coulomb * hip_dq_max_rad   + viscous_rad * hip_dq_max_rad^2);
checkPowerHip_deg = hipEstimatedViscousCoefficient_deg * hip_dq_max^2 - (coulomb * hip_dq_max  + viscous_deg * hip_dq_max^2);

%% knee joint


coulomb = (-8.96247 / -4.46536); %[Nm]
viscous_rad = (-2.54755 / -4.46536); %[Nm/(rad/s)]
viscous_deg = viscous_rad *180/pi; %[Nm/(deg/s)]

%equal friction power
kneeEstimatedViscousCoefficient_deg = coulomb / knee_dq_max + viscous_deg;
kneeEstimatedViscousCoefficient_rad = coulomb / knee_dq_max_rad + viscous_rad;

% fprintf('Estimated viscous friction coefficient at %s:\n\t%f[Nm/(deg/s)]\n\t%f[Nm/(rad/s)]\n', 'knee', ...
%     kneeEstimatedViscousCoefficient_deg, kneeEstimatedViscousCoefficient_rad);

checkPowerKnee_rad = kneeEstimatedViscousCoefficient_rad * knee_dq_max_rad^2 - (coulomb * knee_dq_max_rad  + viscous_rad * knee_dq_max_rad^2);
checkPowerKnee_deg = kneeEstimatedViscousCoefficient_deg * knee_dq_max^2 - (coulomb * knee_dq_max  + viscous_deg * knee_dq_max^2);


%%Regime velocity method:
initialTorque_leg = leg_mass * 9.81 * leg_com;
initialTorque_knee = knee_mass * 9.81 * knee_com;
hipEstimatedViscousCoefficient_slope = initialTorque_leg / hip_dq_max_rad;
kneeEstimatedViscousCoefficient_slope = initialTorque_knee / knee_dq_max_rad;

fprintf('Estimated viscous friction coefficient at %s:\n\t%f[Nm/(rad/s)]\n', 'hip', ...
    hipEstimatedViscousCoefficient_slope);
fprintf('Estimated viscous friction coefficient at %s:\n\t%f[Nm/(rad/s)]\n', 'knee', ...
    kneeEstimatedViscousCoefficient_slope);

