function [elec]=box_electron(Vth,boxes,xlim,ylim)
elec(1,1)=rand()*xlim;
elec(1,2)=rand()*ylim;
while(check_box_loc(elec(1,1:2), boxes))
            elec(1,1:2) = [xlim*rand ylim*rand];
end
elec(1,3)=randn()*Vth/(2^0.5);
elec(1,4)=randn()*Vth/(2^0.5);
end