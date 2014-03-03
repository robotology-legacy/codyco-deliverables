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


%% UPMC + IIT experiments
% Load UPMC data
viscOverPos = load('../data/sim_results_UPMC/Compensated_Viscous/log_position_compensated.log');
%viscPurePos = load('../data/sim_results_UPMC/Viscous_0Coulomb/log_position_identified.log');
viscCoulPos = load('../data/sim_results_UPMC/Viscous_Coulomb/log_position_identified_coulomb.log');
%noFricPos = load('../data/sim_results_UPMC/No_Friction/log_position_no_friction.log');

viscOverPos = viscOverPos(1:14000,:);
%viscPurePos = viscPurePos(1:14000,:);
viscCoulPos = viscCoulPos(1:14000,:);
%noFricPos = noFricPos(1:14000,:);
simPos = simPos(1:1400,:)

% Extend IIT data
lt_upmc = size(viscOverPos,1)
lt_iit = size(robotPos,1)

% we know that lt_upmc > lt_iit
robotPos(lt_iit+1:lt_upmc,:) = 0;
robotPos(lt_iit+1:lt_upmc,2) = viscOverPos(lt_iit+1:lt_upmc,1);
robotPos(lt_iit+1:lt_upmc,6) = robotPos(lt_iit,6);
robotPos(lt_iit+1:lt_upmc,3) = robotPos(lt_iit,3);

% Plot
figure('Color','w');
hold on;
grid on;

plot(robotPos(:,2), robotPos(:,6), 'b','LineWidth',2);
%plot(noFricPos(:,1),noFricPos(:,2),'--k');
%plot(viscPurePos(:,1),viscPurePos(:,2),'g','LineWidth',2);
%plot(viscCoulPos(:,1),viscCoulPos(:,2),'m','LineWidth',2);
plot(simPos(:,2), simPos(:,6), 'r','LineWidth',2);
plot(viscOverPos(:,1),viscOverPos(:,2),'c','LineWidth',2);


legend('A_1: Real Robot', 'B_2: Adapted Viscous - Gazebo','B_3: Adapted Viscous - XDE')
title('Knee joint','fontsize',12,'fontweight','b')
xlabel('time [s]','fontsize',12,'fontweight','b')
ylabel('Angle [deg]','fontsize',12,'fontweight','b')
set(gca,'XTick',0:20:140,'YTick',-140:20:40,'fontsize',12,'fontweight','b')

figure('Color','w');
hold on;
grid on;
plot(robotPos(:,2), robotPos(:,3), 'b','LineWidth',2);
%plot(noFricPos(:,1),noFricPos(:,3),'--k');
%plot(viscPurePos(:,1),viscPurePos(:,3),'g','LineWidth',2);
%plot(viscCoulPos(:,1),viscCoulPos(:,3),'m','LineWidth',2);
plot(simPos(:,2), simPos(:,3), 'r','LineWidth',2);
plot(viscOverPos(:,1),viscOverPos(:,3),'c','LineWidth',2);

legend('A_1: Real Robot', 'B_2: Adapted Viscous - Gazebo','B_3: Adapted Viscous - XDE')
title('Hip joint','fontsize',12,'fontweight','b')
xlabel('time [s]','fontsize',12,'fontweight','b')
ylabel('Angle [deg]','fontsize',12,'fontweight','b')
set(gca,'XTick',0:20:140,'YTick',-50:25:150,'fontsize',12,'fontweight','b')

%% IIT experiments
%position (hip)

% figure;
% hold on;
% grid on;
% plot(robotPos(:,2), robotPos(:,3), 'b');
% plot(simPos(:,2), simPos(:,3), 'r');
% % plot(sim_visc_Pos(:,2), sim_visc_Pos(:,3), 'g');
% 
% title('Hip joint')
% xlabel('time [s]')
% ylabel('Angle [deg]')
% 
% legend('Real Robot', 'Gazebo Simulator');%, 'Sim: viscous friction');
% 
% %position knee
% figure;
% hold on;
% grid on;
% plot(robotPos(:,2), robotPos(:,6), 'b');
% plot(simPos(:,2), simPos(:,6), 'r');
% % plot(sim_visc_Pos(:,2), sim_visc_Pos(:,6), 'g');
% 
% title('Knee joint')
% xlabel('time [s]')
% ylabel('Angle [deg]')
% 
% legend('Real Robot', 'Gazebo Simulator');%, 'Sim: viscous friction');
