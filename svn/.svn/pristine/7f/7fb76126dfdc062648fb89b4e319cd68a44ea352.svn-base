classdef Battery
	%Battery - class to organize information about batteries
	%   Funtions: trueVoltageAtCurrent, powerToParameters, heatRise
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%                          Useful Functions                           %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	properties (Access = public)
		
		chemistry = "Unknown"
		model = "18650"
		manufacturer = "Unknown"
		maxChargeCurrent = -1
		maxDischargeCurrent = -1                                % amperes
		internalResistance = -1                                 % ohms
		mass = -1                                             % grams
		nominalVoltage = -1
		minVoltage = -1
		maxVoltage = -1   % volts
		capacity = -1;
        packVoltage = -1;
	end % /properties
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%                          Useful Functions                           %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	methods
		
		% Class constructor
		function battery = Battery(chemistry, model, manufacturer,...
				maxChargeRate, maxDischargeRate, internalResistance,...
				mass, nominalVoltage, minVoltage, maxVoltage, capacity, packVoltage)
			battery.chemistry = chemistry;
			battery.model = model;
			battery.manufacturer = manufacturer;
			battery.maxChargeCurrent = maxChargeRate*capacity;
			battery.maxDischargeCurrent = maxDischargeRate*capacity;
			battery.internalResistance = internalResistance;
			battery.mass = mass;
			battery.nominalVoltage = nominalVoltage;
			battery.minVoltage = minVoltage;
			battery.maxVoltage = maxVoltage;
			battery.capacity = capacity; %Ah
            battery.packVoltage = packVoltage;
		end
		
		% Get a realistic estimate of what the output voltage is
		% at certain loads
		%
		% This may require a switch statement on chemistry or even
		% model/manufacturer depending on how many cell types we want
		% to catalog
		%
		function voltage = trueVoltageAtCurrent(obj, current)
			voltage = current * obj.internalResistance;
		end
		
		% Set a power requirement, see what kind of a pack you end up with
		function [numCells, packVoltage, packCurrent] = powerToParameters(power)
			numCells = power / (obj.nominalVoltage*obj.maxDischargeCurrent);
			packVoltage = 230;
			packCurrent = power * packVoltage;
		end
		
		% Determine how hot each cell will get
		function deltaT = heatRise(currentDraw, time)
			deltaT = currentDraw * time * obj.internalResistance;
		end
		
	end % /methods (Static)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	methods
		
	end % /methods
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
end % /classdef
