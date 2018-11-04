classdef Pod
	properties
		motor = Motor
		pack = BatteryPack('BatteryChemistry', ' ')
		wheel = Wheel
		shell = Shell
		stability
		mass = 0
	end
	methods
		function pod = Pod(varargin)
			p = inputParser;
			validPosNum = @(x) isnumeric(x) && (x>0);
			
			addOptional(p,'MotorPower', -1, validPosNum);
			addOptional(p,'MotorTorque', -1, validPosNum);
			addOptional(p,'MotorFrequency', -1, validPosNum);
			addOptional(p,'MotorMass', 0, validPosNum);
			addOptional(p, 'MotorEfficiency', 0.9, validPosNum);
			
			addOptional(p,'BatteryChemistry', "");
			addOptional(p,'BatteryModel', "");
			addOptional(p,'BatteryManufacturer', "");
			addOptional(p,'BatteryMaxChargeCurrent', -1, validPosNum);
			addOptional(p,'BatteryMaxDischargeCurrent', -1, validPosNum);
			addOptional(p,'BatteryInternalResistance', -1, validPosNum);
			addOptional(p,'BatteryMass', 0, validPosNum);
			addOptional(p,'BatteryNominalVoltage', -1, validPosNum);
			addOptional(p,'BatteryMinVoltage', -1, validPosNum);
			addOptional(p,'BatteryMaxVoltage', -1, validPosNum);
			
			addOptional(p,'WheelDiameter', -1, validPosNum);
			addOptional(p,'WheelCOF', -1, validPosNum);
			addOptional(p,'WheelMass', 0, validPosNum);
			
			addOptional(p, 'ShellArea', 0, validPosNum);
			addOptional(p, 'ShellCd', 0.4, validPosNum);
			addOptional(p, 'ShellMass', 25, validPosNum);
			addOptional(p, 'ShellVersion', "no shell");
			
			addOptional(p, 'StabilityMass', 15, validPosNum);
			addOptional(p, 'StabilityVertStiff', 0, validPosNum);
			addOptional(p, 'StabilityHoriStiff', 0, validPosNum);
			addOptional(p, 'StabilityVersion', 'no stability');
			addOptional(p, 'StabilityHoriDamp', 0, validPosNum);
			addOptional(p, 'StabilityVertDamp', 0, validPosNum);
			addOptional(p, 'StabilityFriction', 0, validPosNum);
			addOptional(p, 'StabilityVerticalSprings', 8, validPosNum);
			addOptional(p, 'StabilityHorizontalSprings', 4, validPosNum);
			addOptional(p, 'StabilityVPreload', [0,0,0,0,0,0,0,0]);
			addOptional(p, 'StabilityHPreload', [0,0,0,0]);
			
			p.CaseSensitive = false;
			p.KeepUnmatched = true;
			parse(p,varargin{:});
			
			pod.motor.efficiency = p.Results.MotorEfficiency;
			
			% Motor Info
			if p.Results.MotorPower == -1
				pod.motor.power = input('Motor Power: ');
			else
				pod.motor.power = p.Results.MotorPower;
			end
			if p.Results.MotorTorque == -1
				pod.motor.torque = input('Motor Torque [Nm]: ');
			else
				pod.motor.torque = p.Results.MotorTorque;
			end
			if p.Results.MotorFrequency == -1
				pod.motor.frequency = Motor.ConvertRPM(input('Motor RPM: '));
			else
				pod.motor.frequency = p.Results.MotorFrequency;
			end
			if p.Results.MotorMass == 0
				pod.motor.mass = input('Motor Mass [kg]: ');
			else
				pod.motor.mass = p.Results.MotorMass;
			end
			
			% Wheel Info
			if p.Results.WheelMass == 0
				pod.wheel.mass = input('Wheel mass: ');
			else
				pod.wheel.mass = p.Results.WheelMass;
			end
			if p.Results.WheelCOF == -1
				pod.wheel.frictionCoeff = input('Wheel Coefficient of Friction: ');
			else
				pod.wheel.frictionCoeff = p.Results.WheelCOF;
			end
			if p.Results.WheelDiameter == -1
				pod.wheel.diameter = input('Wheel diameter [in]: ')*2.54/100;
			else
				pod.wheel.diameter = p.Results.WheelDiameter*2.54/100;
			end
			
			%Shell
			pod.shell.mass = p.Results.ShellMass;
			pod.shell.Area_Projected = p.Results.ShellArea;
			pod.shell.Cd = p.Results.ShellCd;
			pod.shell.version = p.Results.ShellVersion;
			
			% Stability
			version = p.Results.StabilityVersion;
			smass = p.Results.StabilityMass;
			vs = p.Results.StabilityVertStiff;
			hs = p.Results.StabilityHoriStiff;
			vd = p.Results.StabilityVertDamp;
			hd = p.Results.StabilityHoriDamp;
			sfric = p.Results.StabilityFriction;
			nh = p.Results.StabilityHorizontalSprings;
			nv = p.Results.StabilityVerticalSprings;
			h_preload = p.Results.StabilityHPreload;
			v_preload = p.Results.StabilityVPreload;
			pod.stability = Stability(version,smass,sfric, vs, vd, nv,...
				v_preload, hs, hd, nh, h_preload);
			
			pod.mass = pod.pack.mass + pod.motor.mass + pod.wheel.mass...
				+ pod.shell.mass + pod.stability.mass + 20 +30; %mass braking, stability, pack weight
			pod.motor = Optimize(pod.motor, pod.mass,pod.wheel.diameter);
		end
	end
end