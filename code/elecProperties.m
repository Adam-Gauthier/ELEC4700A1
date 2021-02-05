function [elec]= elecProperties(Vth,xlim,ylim)
%random position
elec(1,1)=rand()*xlim;
elec(1,2)=rand()*ylim;
%random velocity
elec(1,3)=randn()*Vth;
elec(1,4)=randn()*Vth;
end