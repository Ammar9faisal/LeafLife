function button = button(a) %performs action based on short or long press

    buttonVal = readDigitalPin(a,"D6"); %checks button value
    
    if buttonVal == 0    %if button isnt pushed, loop continues
        button = true;   %putting this at top makes it more effiecient
    
    elseif buttonVal == 1
       
       buttonDuration = 10; %1 unit is 0.1 secs
       buttonValues = zeros(1,buttonDuration);
       
       for i = 1:buttonDuration   %generates array of buttonVal in duration
            buttonVal = readDigitalPin(a,"D6");
            buttonValues(i) = buttonVal;
            pause(0.1)
       end
       
       finalVal = mean(buttonValues);  %Ex: mean[1 1 1 1 ...] = 1
                                       %    mean[1 0 1 0 ...] =(0 < x < 1)
       
       if finalVal == 1  %mean 1 indicates long press                                     
           button = false; %functions output's false stopping while loop
       else 
           button = true;  %mean less than 1 indicates shortpress
                           %activates manual pump overide
           disp("Manual Pump Override Active")
           pump(a,'D7','D4', 4)
           disp("Manual Pump Override Disabled")
       end
    end
end