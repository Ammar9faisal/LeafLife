function pump = pump(arduino,pump_pin,led_pin,time)
    writeDigitalPin(arduino,pump_pin,1);
    writeDigitalPin(arduino,led_pin,1);
    pause(time);
    writeDigitalPin(arduino,pump_pin,0);
    writeDigitalPin(arduino,led_pin,0);
end