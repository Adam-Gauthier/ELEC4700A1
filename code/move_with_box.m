function[electron] = move_with_box(electron,Vth,dt,xlim,ylim,ps,nParticles,diff,spec,box)
    global ax
    %Check if exceeds top or bottom
    check_top= electron(:,2)+electron(:,4)*dt*2 >ylim;
    check_bottom =electron(:,2)+electron(:,4)*dt*2<0;
    %scatter
    scatter_chance=rand(nParticles,1);
    Scatter = ps(:,1) >scatter_chance;
    %box logic
    indices=zeros(nParticles,1);
    [indices(:,1),ax]=box_logic(electron,dt,nParticles,box);

    %Scatter probs
    r1 = rand()*10;
    if r1 >5
      r1= r1/5;
    end
    r2 = rand()*10;
    if r2>5
      r2=r2/5;
    end

    %logical indexing for box conditions and scattering (yx)
    electron(:,4)=electron(:,4).*~Scatter-2*electron(:,4).*check_top.*spec -2*electron(:,4).*check_bottom.*spec- r1*electron(:,4).*check_top.*diff -r2*electron(:,4).*check_bottom.*diff+randn()*(Vth/sqrt(2)).*~check_top.*~check_bottom.*Scatter.*~indices(:,1)-2*electron(:,4).*indices(:,1).*~ax(:,1).*spec-r1*electron(:,4).*indices(:,1).*~ax(:,1).*diff ;
    electron(:,3)=electron(:,3).*~Scatter+ randn()*(Vth/sqrt(2)).*~check_top.*~check_bottom.*Scatter.*~indices(:,1)-2*electron(:,3).*indices(:,1).*ax(:,1).*spec- r2*electron(:,3).*indices(:,1).*ax(:,1).*diff ;
    %update position
    electron(:,1)=mod(electron(:,1)+electron(:,3)*dt,xlim);  
    electron(:,2)=electron(:,2)+electron(:,4)*dt;
end


