clear all;
close all;

%%robot data

robotPos = load('../data/robot_results/rightLegPos/data.log');
robotVel = load('../data/robot_results/rightLegVel/data.log');
robotAcc = load('../data/robot_results/rightLegAcc/data.log');

%retrive first real data
% robotHip = robotPos(:,3);
% robotFirstData = robotHip(1);
% robotFirstIndex = 1;
% for i = 1: length(robotHip)
%     if (abs(robotFirstData - robotHip(i)) > 1e-1) 
%        robotFirstIndex = i;
%        break;
%     end
% end
%do it manually!
robotFirstIndex = 697 - 20;

%now trim some samples before
% if (robotFirstIndex - 20 > 1)
    robotPos(1:robotFirstIndex, :) = [];
    robotVel(1:robotFirstIndex, :) = [];
    robotAcc(1:robotFirstIndex, :) = [];
% end

%normalize time
robotPos(:,2) = robotPos(:,2) - min(robotPos(:,2));
robotVel(:,2) = robotVel(:,2) - min(robotVel(:,2));
robotAcc(:,2) = robotAcc(:,2) - min(robotAcc(:,2));

%%Simulator Data ("true" friction estimation)

simPos = load('../data/sim_results/rightLegPos/data.log');
simVel = load('../data/sim_results/rightLegVel/data.log');
simAcc = load('../data/sim_results/rightLegAcc/data.log');

%retrive first real data
% simHip = simPos(:,3);
% simFirstData = simHip(1);
% simFirstIndex = 1;
% for i = 1: length(simHip)
%     if (abs(simFirstData - simHip(i)) > 1e-1) 
%        simFirstIndex = i;
%        break;
%     end
% end

%manual trim
simFirstIndex = 127 - 3;

%now trim some samples before
% if (simFirstIndex - 20 > 1)
    simPos(1:simFirstIndex, :) = [];
    simVel(1:simFirstIndex, :) = [];
    simAcc(1:simFirstIndex, :) = [];
% end

%normalize time
simPos(:,2) = simPos(:,2) - min(simPos(:,2));
simVel(:,2) = simVel(:,2) - min(simVel(:,2));
simAcc(:,2) = simAcc(:,2) - min(simAcc(:,2));

%%Simulator Data (only robot viscous component)

sim_visc_Pos = load('../data/sim_fake_results/rightLegPos/data.log');
sim_visc_Vel = load('../data/sim_fake_results/rightLegVel/data.log');
sim_visc_Acc = load('../data/sim_fake_results/rightLegAcc/data.log');

%retrive first real data
% sim_visc_Hip = sim_visc_Pos(:,3);
% sim_visc_FirstData = sim_visc_Hip(1);
% sim_visc_FirstIndex = 1;
% for i = 1: length(sim_visc_Hip)
%     if (abs(sim_visc_FirstData - sim_visc_Hip(i)) > 1e-1) 
%        sim_visc_FirstIndex = i;
%        break;
%     end
% end
%manual trim
sim_visc_FirstIndex = 59 - 3;
%now trim some samples before
% if (sim_visc_FirstIndex - 20 > 1)
    sim_visc_Pos(1:sim_visc_FirstIndex, :) = [];
    sim_visc_Vel(1:sim_visc_FirstIndex, :) = [];
    sim_visc_Acc(1:sim_visc_FirstIndex, :) = [];
% end

%normalize time
sim_visc_Pos(:,2) = sim_visc_Pos(:,2) - min(sim_visc_Pos(:,2));
sim_visc_Vel(:,2) = sim_visc_Vel(:,2) - min(sim_visc_Vel(:,2));
sim_visc_Acc(:,2) = sim_visc_Acc(:,2) - min(sim_visc_Acc(:,2));


%%plots

%position (hip)

figure;
hold on;
grid on;
plot(robotPos(:,2), robotPos(:,3), 'b');
plot(simPos(:,2), simPos(:,3), 'r');
% plot(sim_visc_Pos(:,2), sim_visc_Pos(:,3), 'g');

title('Hip joint')
xlabel('time [s]')
ylabel('Angle [deg]')

legend('Real Robot', 'Gazebo Simulator');%, 'Sim: viscous friction');

%position knee
figure;
hold on;
grid on;
plot(robotPos(:,2), robotPos(:,6), 'b');
plot(simPos(:,2), simPos(:,6), 'r');
% plot(sim_visc_Pos(:,2), sim_visc_Pos(:,6), 'g');

title('Knee joint')
xlabel('time [s]')
ylabel('Angle [deg]')

legend('Real Robot', 'Gazebo Simulator');%, 'Sim: viscous friction');
