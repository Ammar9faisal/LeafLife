clear all; close all;
a = arduino('COM3', 'Nano3');           %opens connection to arduino

moisturePin = 'A1';
buttonPin = 'D6';    %defines pins
pumpPin = 'D7';
ledPin = 'D4';

figure
h = animatedline("Marker","o");
ax = gca;
ax.YGrid = 'on';            %initiates graph
ax.YLim = [-0.1 5];
title('Moisture Level');
xlabel('Time [s]');
ylabel('Voltage [volt]');


tic;  %starts timer
working = true;
while working    
    %Runs loop while while button is not pressed
    moistureValue = readVoltage(a, moisturePin);
    fprintf('Moisture Value: %.2f V\n', moistureValue);
       
    if (moistureValue > 3)  
        pump(a,pumpPin,ledPin,4)
    end

    t = toc;
    addpoints(h,t,moistureValue);
    ax.XLim = [t-2,t+1];

    pause(0.1); 
    working = button(a);  %I passed in the arduino Object
end

writeDigitalPin(a,"D4",0);
writeDigitalPin(a,"D7",0);
disp('SHUTTING DOWN!')
pause(1);
disp("System has shut down")
