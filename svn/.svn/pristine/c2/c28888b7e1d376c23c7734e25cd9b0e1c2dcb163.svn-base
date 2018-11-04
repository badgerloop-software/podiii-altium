%
% Badgerloop: Battery Equation Sandbox
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Configurations                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Battery(chemistry, model, manufacturer, maxChargeRate, maxDischargeRate, internalResistance, weight, nominalVoltage, minVoltage, maxVoltage)
batt = Battery(...
    "li-po",...       % Chemistry
    "Z50003S-30",...     % Model
    "Zippy",...      % Manufacturer
    2,...               % Maximum charge rate           (C)
    45,...               % Maximum discharge rate       (C)
    0.01,...            % Internal resistance           (ohms)
    490,...              % Weight                        (grams)
    11.1,...             % Nominal voltage               (volts)
    9.0,...             % Minimum voltage               (volts)
    12.6,...               % Maximum voltage               (volts)
    5,...               % Capacity                       (Ah)
    230);               % Pack Voltage                    (Volts)



disp(batt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Tests                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
steadyVoltage = batt.trueVoltageAtCurrent(batt.maxDischargeCurrent);
fprintf("Voltage at max current: %.02f V\n\n", steadyVoltage);
powerInput = batt.maxDischargeCurrent  * steadyVoltage;
dischargeTime = 60;

[cells, voltage, current] = batt.powerToParameters(powerInput);
fprintf("With %d W power draw:\n# Cells:\t\t\t%d\nOverall Voltage:\t%d\nOverall Current:\t%d\n\n",...
    powerInput, cells, voltage, current);

deltaT = batt.heatRise(batt.maxDischargeCurrent, dischargeTime);
fprintf("Temperature increase over %d seconds: %.02f deg. C\n", dischargeTime, deltaT);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
