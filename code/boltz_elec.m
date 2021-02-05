function [electron]=boltz_elec(Vth)
electron(1,1)=rand()*200e-9;
electron(1,2)=rand()*100e-9;
electron(1,3)=randn()*Vth/(2^0.5);
electron(1,4)=randn()*Vth/(2^0.5);

end