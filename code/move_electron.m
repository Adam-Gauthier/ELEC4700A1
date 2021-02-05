function[electrons] = move_electron(electrons,dt,xlim,ylim)
    %Boolean logical index check if speed puts position past top ylimit
    greater_than_top= (electrons(:,2)+electrons(:,4)*dt) >ylim;
    %Boolean logical index check if speed puts position past bottom ylimit
    less_than_bottom =(electrons(:,2)+electrons(:,4)*dt)<0;
    % Y BC, if greater than top or less than bottom, velocity reflects back
    electrons(:,4)=electrons(:,4) - 2*electrons(:,4).*greater_than_top -2*electrons(:,4).*less_than_bottom  ;
    % Update x position, Modulus for x position as they pass from on boundary to the other
    electrons(:,1)=mod(electrons(:,1)+electrons(:,3)*dt,xlim);
    % Update y-position
    electrons(:,2)=electrons(:,2)+electrons(:,4)*dt;
end