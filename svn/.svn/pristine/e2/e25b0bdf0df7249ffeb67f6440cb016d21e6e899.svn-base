classdef Stability
	% Stability class holds information on springs/vibrations
	
	properties
		version = "NULL";
		mass = 0;
		horizontal_stiffness = 0;
		vertical_stiffness = 0;
		horizontal_dampening = 0;
		vertical_dampening = 0;
		wheel_friction = 0;
		horizontal_springs = 4;
		vertical_springs = 8;
									% [front left, front right, rear left, rear right]
		springs_horizontal_preload = [0,0,0,0];
		springs_horizontal_displacement = [0,0,0,0];
								% [flu, fll, fru, frl, rlu, rll, rru, rrl]
		springs_vertical_preload = [0,0,0,0,0,0,0,0];
		springs_vertical_displacement = [0,0,0,0,0,0,0,0];
		
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	methods
		function stability = Stability(version, mass, friction, hs, hd, nh, h_preload, vs, vd, nv, v_preload)
			stability.version = version;
			stability.mass = mass;
			stability.wheel_friction = friction;
			
			stability.horizontal_stiffness = hs;
			stability.horizontal_dampening = hd;
			stability.horizontal_springs = nh;
			stability.springs_horizontal_preload = h_preload;
			stability.springs_horizontal_displacement = h_preload./hs;
			
			stability.vertical_stiffness = vs;
			stability.vertical_dampening = vd;
			stability.vertical_springs = nv;
			stability.springs_horizontal_displacement = v_preload./vs;
			
			
		end
		function fric = friction(obj)
			fric = 0;
			for i = 1:obj.horizontal_springs
				fric = fric + obj.springs_horizontal_displacement(i)*obj.horizontal_stiffness;
			end
			for i = 1:obj.vertical_springs
				fric = fric + obj.springs_vertical_displacement(i)*obj.vertical_stiffness;
			end
			fric = fric * obj.wheel_friction;
		end
	end
end
