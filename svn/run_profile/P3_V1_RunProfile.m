% Run profile
% Badgerloop Pod 3
% Justin Williams
% Started 8/28/2017
% V2.0.0
clc, clear, clf

%% Input Parameters
% Tube details
VACUUM = 865; %Pa
ATM = 101000;

tube_length = 1250; %m Does not do anything
tube_pressure = VACUUM;

% General pod details, if you are missing important info, it will ask
pod = Pod(...
	'MotorPower', 62000,...
	'MotorTorque', 100,...
	'MotorFrequency', Motor.ConvertRPM(6000),...
	'BatteryMaxChargeCurrent', 1,...
	'BatteryMaxDischargeCurrent', 1,...
	'BatteryInternalResistance', 0.1,...
	'BatteryMass', 25,...
	'BatteryNominalVoltage', 2.4,...
	'BatteryMinVoltage', 2,...
	'BatteryMaxVoltage', 3,...
	'WheelDiameter', 6,...
	'WheelCOF', 0.1,...
	'WheelMass', 10,...
	'MotorMass', 10,...
	'BatteryManufacturer',"Samsung",...
	'BatteryChemistry', "Lipo",...
	'BatteryModel', "18650",...
	'BatteryCapacity', 3.7,...
	'ShellArea', 1/5,...
	'ShellCD', 0.198,...
	'ShellMass', 45,...
	'ShellVersion', 'JustinGuess');

%% Calculations
% Simulation Details
dt = 1E-1;

% Pod Kinematics
% Acceleration
fMax = 2*pod.motor.torque * pod.motor.torqueRatio / pod.wheel.diameter;
xMax = pod.motor.optimalV^2 / (2*pod.motor.optimalA);
% Deceleration
fBraking = pod.motor.optimalBraking*pod.mass;

% Timing Info
tMax = pod.motor.optimalV/pod.motor.optimalA;
tStop = pod.motor.optimalV/pod.motor.optimalBraking;
tTot = tMax+tStop;

% Motor Temperature
mFinalT = pod.motor.heatRise(70000, 10) + 25;

% Simulation Loop
tSteps = floor(tTot/dt)+1;
xx = zeros(tSteps,1);
vv = zeros(tSteps,1);
aa = zeros(tSteps,1);
tt = zeros(tSteps,1);

% Initial Conditions
tt(1) = 0;
aa(1) = 0;
vv(1) = 0;
xx(1) = 0;

for i = 2:tSteps
	tt(i) = i*dt;
	losses = pod.shell.drag(vv(i-1), VACUUM);
	if(tt(i) < tMax)
		aa(i) = pod.motor.optimalA;
	else
		aa(i) = -pod.motor.optimalBraking;
	end
	aa(i) = aa(i) - losses;
	% using forward Euler TODO implement RK4
	vv(i) = aa(i)*dt + vv(i-1);
	if(vv(i) < 0)
		vv(i) = 0;
		aa(i) = 0;
	end
	xx(i) = vv(i)*dt + xx(i-1);
end

%% Results
max_a = norm(aa, inf); % not right
max_braking = norm(-aa, inf);
max_v = norm(vv, inf);
max_x = norm(xx, inf);

fprintf('Pod mass %3.0f kg\n', pod.mass);
fprintf('optimal acceleration: %2.1f m/s^2 \t optimal decceleration: %2.1f m/s^2 \t Optimal top speed: %3.1f m/s \n'...
	, pod.motor.optimalA, pod.motor.optimalBraking, pod.motor.optimalV);
fprintf('Actual acceleration: %2.1f m/s^2 \t Actual decceleration: %2.1f m/s^2 \t Actual top speed: %3.1f m/s \n'...
	, aa(2), max_braking, max_v);


figure(1) 
subplot(3,1,1); plot(tt, aa); title('Acceleration (m/s^2) vs time');
axis([0 tTot -max_braking pod.motor.optimalA+3])

subplot(3,1,2); plot(tt,vv); title('Velocity (m/s) vs time');
axis([0 tTot 0 pod.motor.optimalV])

subplot(3,1,3); plot(tt,xx); title('Position (m) vs time');
axis([0 tTot 0 1250])

%% Additional output
accFile = 'acceleration.csv';
velFile = 'velocity.csv';
posFile = 'position.csv';
csvwrite(accFile,aa); csvwrite(velFile,vv); csvwrite(posFile,xx);