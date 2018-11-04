import sys
import math

import bl_constants as const
import bl_parameters as param

###############################################################################
#                                Helper Functions                             #
###############################################################################
def _print_tabs(num):
	for _ in range(num):
		print("\t", end="")

def _print_var(var, num_tabs):

	if isinstance(var, dict):
		print("")
		_print_dict(var, num_tabs)

	elif isinstance(var, list):
		_print_list(var, num_tabs)

	else:
		print(str(var))

def _print_list(_list, num_tabs):

	for item in _list:
		_print_tabs(num_tabs)
		_print_var(item, num_tabs + 1)

	print("")

def _print_dict(_dict, num_tabs):

	for key, value in _dict.items():
		_print_tabs(num_tabs)
		print(str(key) + ":\t", end="")
		_print_var(value , num_tabs + 1)

	print("")

def in_to_m(val):
	return val * 2.54 / 100.0
###############################################################################
###############################################################################

constants = {
	"tube" : const.tube_const,
	"elec" : const.elec_const,
	"mech" : const.mech_const
}
def print_constants():
	print("**********************          Constants            **************************")
	_print_var(constants, 0)
	print("*******************************************************************************\n\n")

parameters = {
	"elec" : param.elec_param,
	"mech" : param.mech_param
}
def print_parameters():
	print("**************************        Parameters         **************************")
	_print_var(parameters, 0)
	print("*******************************************************************************\n\n")

def get_pod_mass():
	pod_mass = 0
	for sys, val in constants["elec"]["mass"].items():
		pod_mass += val
	for sys, val in constants["mech"]["mass"].items():
		pod_mass += val
	return pod_mass

def get_motor_power():
	return constants["elec"]["motor"]["torque"] * 6.28 / 60.0 * constants["elec"]["motor"]["rpm"]

def get_motor_force():
	force = constants["elec"]["motor"]["torque"]
	force /= (in_to_m(constants["elec"]["motor"]["wheel_diam"]) / 2.0)
	force *= constants["elec"]["motor"]["torque_rat"]
	return force

def get_wheel_circum():
	return in_to_m(constants["elec"]["motor"]["wheel_diam"]) * math.pi

def get_max_velocity():
	value = constants["elec"]["motor"]["rpm"] / 60.0
	value *= get_wheel_circum()
	value /= constants["elec"]["motor"]["torque_rat"]
	return value

def main(args):

	pod_mass = get_pod_mass()
	print("Pod mass:\t" + "%.2f" % pod_mass + " kg")

	motor_power = get_motor_power()
	print("Motor Power:\t" + "%.2f" % (motor_power/1000) + " kW")

	motor_force = get_motor_force()
	print("Motor Force:\t" + "%.2f" % motor_force + " N")

	max_v = get_max_velocity()
	print("Max Velocity:\t" + "%.2f" % max_v + " m/s")

	max_a = motor_force / pod_mass
	print("Max Accel:\t" + "%.2f" % max_a + " m/s^2")

	max_x = max_v * max_v / (2 * max_a)
	print("Max Vel. X:\t" + "%.2f" % max_x + " m")

	braking_a = max_v * max_v / 2 / (constants["tube"]["length"] - max_x)
	print("Braking Accel:\t" + "%.2f" % braking_a + " m/s^2")

	braking_f = braking_a * pod_mass
	print("Braking Force:\t" + "%.2f" % braking_f + " N")

	time_to_max_v = max_v / max_a
	print("Time to Max V:\t" + "%.2f" % time_to_max_v + " s")

	return 0

if __name__ == "__main__":
	print("*******************************************************************************")
	print("************        Badgerloop: Pod III Run Profile      **********************")
	print("*******************************************************************************")
	print("Command-line Arguments:")
	_print_var(sys.argv[1:], 0)
	print_constants()
	print_parameters()
	ret = main(sys.argv)
	print("*******************************************************************************")
	print("*******************************************************************************")
	exit(ret)

