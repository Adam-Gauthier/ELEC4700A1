function[electron] = move_electron2(electron,dt,xlim,ylim,Vth,ps,nParticles,index)
global  mfpx x_dist mfpy y_dist t_count mft
    %Check exceed top/bottom
    check_top= (electron(:,2)+electron(:,4)*dt) >ylim;
    check_bottom =(electron(:,2)+electron(:,4)*dt)<0;
    %scatter
    scatter_chance=rand(nParticles,1);
    scatter = ps(:,1) >scatter_chance;
    mft(:,index)=t_count.*scatter*dt;
    t_count=(t_count+1).*~scatter;
    x_dist=x_dist + electron(:,3).*dt.*~scatter;
    mfpx(:,index)=abs(x_dist).*scatter;
    y_dist = y_dist +electron(:,4).*dt.*~scatter;
    mfpy(:,index)=abs(y_dist).*scatter;
    electron(:,4)=electron(:,4).*~scatter - 2*electron(:,4).*check_top -2*electron(:,4).*check_bottom + randn()*(Vth/sqrt(2)).*~check_top.*~check_bottom.*scatter ; % Logical indexing for top and bottoms and also scattering condition
    electron(:,3)=electron(:,3).*~scatter + randn()*(Vth/sqrt(2)).*~check_top.*~check_bottom.*scatter; % Scattering condution for x 
    electron(:,1)=mod(electron(:,1)+electron(:,3)*dt,xlim); % electron x- position is equal to the modulus of electron x- position with 200E-9 so anything below 200E-9 will just be regular but if greater than 200E-9 it will start back at the start
    electron(:,2)=electron(:,2)+electron(:,4)*dt; % electron y co-ordinate is equal to electron y co-ordinate + speed
end