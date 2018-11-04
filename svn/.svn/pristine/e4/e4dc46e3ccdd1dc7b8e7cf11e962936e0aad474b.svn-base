classdef Shell
	% Shell class holds aerodynamic data for the pod
	
	properties
		version = "NULL";
		mass = 0;
		Cd = 0;
		Area_Projected = 1;
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	methods		
		% Drag  for a shell given a Velocity and Pressure
		function d = drag(obj, v, P)
			R = 287.05;
			density = P/R/280;
			d = obj.Cd*obj.Area_Projected * density/2 * v^2;
		end
		
	end
end
