classdef BatteryPack
	properties
		battery = Battery('','','',-1,-1,-1,0,-1,-1,-1,-1,-1)
		pressurized = false
		power = -1;
		maxCurrent = -1;
		maxVoltage = -1;
		totalCapacity = -1;
		percentCapacity = 1
		temperature = 27;
		numSeries = -1
		numParrallel = -1;
		mass = 0;
	end
	
	methods
		
		function pack = BatteryPack(varargin)
			validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x>0);
			p = inputParser;
			addOptional(p,'BatteryChemistry', "");
			addOptional(p,'BatteryModel', "");
			addOptional(p,'BatteryManufacturer', "");
			addOptional(p,'BatteryMaxChargeCurrent', -1, validScalarPosNum);
			addOptional(p,'BatteryMaxDischargeCurrent', -1, validScalarPosNum);
			addOptional(p,'BatteryInternalResistance', -1, validScalarPosNum);
			addOptional(p,'BatteryMass', 0, validScalarPosNum);
			addOptional(p,'BatteryNominalVoltage', -1, validScalarPosNum);
			addOptional(p,'BatteryMinVoltage', -1, validScalarPosNum);
			addOptional(p,'BatteryMaxVoltage', -1, validScalarPosNum);
			addOptional(p, 'PackPressurized', false);
			addOptional(p, 'PackNominalPower', -1, validScalarPosNum);
			addOptional(p, 'PackNominalCurrent', -1, validScalarPosNum);
			addOptional(p, 'PackNominalVoltage', -1, validScalarPosNum);
			addOptional(p, 'PackMaxCurrent' ,-1, validScalarPosNum);
			addOptional(p, 'BatteryCapacity', -1, validScalarPosNum);
			p.CaseSensitive = false;
			parse(p, varargin{:});
			
			% Battery Info
			pack.battery.chemistry = p.Results.BatteryChemistry;
			pack.battery.model = p.Results.BatteryModel;
			pack.battery.manufacturer = p.Results.BatteryManufacturer;
			pack.battery.maxChargeCurrent = p.Results.BatteryMaxChargeCurrent;
			pack.battery.maxDischargeCurrent = p.Results.BatteryMaxDischargeCurrent;
			pack.battery.internalResistance = p.Results.BatteryInternalResistance;
			pack.battery.mass = p.Results.BatteryMass;
			pack.battery.nominalVoltage = p.Results.BatteryNominalVoltage;
			pack.battery.maxVoltage = p.Results.BatteryMaxVoltage;
			pack.battery.minVoltage = p.Results.BatteryMinVoltage;
			pack.battery.capacity = p.Results.BatteryCapacity;
			
% 			if p.Results.BatteryChemistry == ""
% 				pack.battery.chemistry = input('Battery chemistry: ');
% 			else
% 				pack.battery.chemistry = p.Results.BatteryChemistry;
% 			end
% 			if p.Results.BatteryModel == ""
% 				pack.battery.model = input('Battery model: ');
% 			else
% 				pack.battery.model = p.Results.BatteryModel;
% 			end
% 			if p.Results.BatteryManufacturer == ""
% 				pack.battery.manufacturer = input('Battery manufacturer: ');
% 			else
% 				pack.battery.manufacturer = p.Results.BatteryManufacturer;
% 			end
% 			if p.Results.BatteryMaxChargeCurrent == -1
% 				pack.battery.maxChargeCurrent = input('Battery charge current: ');
% 			else
% 				pack.battery.maxChargeCurrent = p.Results.BatteryMaxChargeCurrent;
% 			end
% 			if p.Results.BatteryMaxDischargeCurrent == -1
% 				pack.battery.maxDischargeCurrent = input('Battery discharge current: ');
% 			else
% 				pack.battery.maxDischargeCurrent = p.Results.BatteryMaxDischargeCurrent;
% 			end
% 			if p.Results.BatteryInternalResistance == -1
% 				pack.battery.internalResistance = input('Battery internal resistance: ');
% 			else
% 				pack.battery.internalResistance = p.Results.BatteryInternalResistance;
% 			end
% 			if p.Results.BatteryMass == 0
% 				pack.battery.mass = input('Battery mass: ');
% 			else
% 				pack.battery.mass = p.Results.BatteryMass;
% 			end
% 			if p.Results.BatteryNominalVoltage == -1
% 				pack.battery.nominalVoltage = input('Nominal Battery V: ');
% 			else
% 				pack.battery.nominalVoltage = p.Results.BatteryNominalVoltage;
% 			end
% 			if p.Results.BatteryMinVoltage == -1
% 				pack.battery.minVoltage = input('Min Battery V: ');
% 			else
% 				pack.battery.minVoltage = p.Results.BatteryMinVoltage;
% 			end
% 			if p.Results.BatteryMaxVoltage == -1
% 				pack.battery.maxVoltage = input('Max Battery V: ');
% 			else
% 				pack.battery.maxVoltage = p.Results.BatteryMaxVoltage;
% 			end
			
			
		end
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Simulate the discharge of the battery pack at a specified
		% voltage, cuurrent and duration
		% battery keeps track of capacity
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		function [pack] = discharge(pack, current, time)
			pack.temperature = heatRise(current, time) + pack.temperature;
			pack.percentCapacity = pack.percentCapacity - current *...
				(time/3600) / pack.totalCapacity;
		end
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Determines the configuration of the pack dependent on the battery
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		function [pack] = OptimizePack(pack, nominalVoltage, nominalCurrent)
			if pack.battery.nominalVoltage == -1
				disp('Please initalize the battery information before creating a pack');
			end
			pack.numSeries = nominalVoltage / pack.battery.nominalVoltage;
			pack.maxVoltage = pack.numSeries*pack.battery.maxVoltage;
			pack.minVoltage = pack.numSeries*pack.battery.minVoltage;
			pack.numParallel = nominalCurrent / pack.battery.maxDischargeCurrent;
			pack.totalCapacity = pack.numParallel*pack.battery.capacity;
			pack.mass = pack.numSeries*pack.numParallel*pack.battery.mass;
		end
	end
end