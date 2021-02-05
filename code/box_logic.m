function [box_log,ax1] = box_logic(electron,dt,nParticles,box)
 %Does logic to check box interaction
 global ax1
 error=1e-9;
 box_log=zeros(nParticles,1);
    for i=1:size(box,1)
        for j= 1:nParticles  
            move_x=(electron(j,1)+electron(j,3)*dt*2);
            move_y=(electron(j,2)+electron(j,4)*dt*2);
            if( move_x> box(i,1) && move_x < box(i,2) && move_y > box(i,3) && move_y < box(i,4))
                box_log(j,1)=1;
                check1= abs(electron(j,1)-box(i,1));
                check2= abs(electron(j,1)- box(i,2));
                ax1(j,1)=check1 < error || check2 <error;
            end
        end 
    end
end