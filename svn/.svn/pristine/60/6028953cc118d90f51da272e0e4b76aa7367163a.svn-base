classdef Motor
    %Motor class
    properties
       power = -1
       torque = -1
       frequency = -1
       optimalV = -1
       optimalA = -1
       optimalBraking = -1
       name = -1
       voltage = -1
       current = -1
       torqueRatio = -1;
       efficiency = .9;
       mass = 0;
	   material = "Aluminum"
	   heatCapacity = -1;
    end
    methods
        function [m1] = Optimize(m, mass, wheel_diameter)
            %X = [v_m, a_m, a_b]
            % Initial Conditions
            x_0 = [110, 10, 10];
            % Options for solver, setting tolerance really low
            options = optimoptions('fmincon', 'OptimalityTolerance',1E-10);
            % constraints on motor
            f = @(x)nonlinconstr(x, m.power, mass, 1250);
			
			% Linear constraints Ax <= b
			A = [0 0 0];
			b = [0];
            % Target values (x, weight for a_m, weight for a_b)
            objective = @(x)motorObj(x,1,1);
            % Actually run the optimization
            [y, fval] = fmincon(objective,x_0,A,b,[],[],[],[],f,options);
            disp(fval);
            % Check for all data
            if m.torque == -1
                m.torque = input('Enter the motor torque [Nm]: ');
            end
            if m.frequency == -1
               m.frequency = input('Enter the max motor frequency [RPM]: ');
               m.frequency = m.frequency * 3600 /(2*pi);
            end
            
            % Calculate optimal values based on max v, a_m and a_b
            m.torqueRatio = y(2) * mass * wheel_diameter / (2*m.torque);
            m1 = m;
            m1.optimalV = y(1);
            m1.optimalA = y(2);
            m1.optimalBraking = y(3);
		end
		
		function [heatCapacity] = materialHeatCapacity(motor, mat)
			if strcmp(mat,"Aluminum")
				heatCapacity = 896; %J/kg-C
			end
			if strcmp(mat, "Copper")
				heatCapacity = 390;
			end
			if strcmp(mat, "Water")
				heatCapacity = 4184;
			end
		end
		
		function [deltaTemp] = heatRise(motor, power, time)
			motor.heatCapacity = motor.materialHeatCapacity("Copper");
			deltaTemp = power*(1-motor.efficiency)*time;
			deltaTemp = deltaTemp / (motor.heatCapacity);
		end
    end
    methods (Static)
        function [frequency] = ConvertRPM(rpm)
           frequency = rpm * 3600 / (2*pi); 
        end
    end
end