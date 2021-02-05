clear all; close all;
% Adam Gauthier 100947233
%% Part 3 Enhancements
global ax1 ax

% Constants
m0 = 9.109E-31; % electron mass (kg)
mn = 0.26*m0; % effective electron mass (kg)
kB = 1.3806E-23; % Boltzmann Constant (m^2kgs^-2K^-1)
T = 300; % system temperature (K)
Vth = (kB*T/mn)^0.5; % Thermal Velocity (m/s)
col_time = 0.2e-12; % Time between collisions (s)
mfp = col_time*Vth;% Mean Free Path (m)

% Parameters
nParticles = 1000; 
iterations =200; 
ylimit=100e-9;
xlimit=200e-9;
Vth=(kB*T/mn)^0.5; 
dt= ylimit/(Vth*100);
num_to_plot=15; % # of electrons to plot
color=hsv(num_to_plot);

ax =zeros(nParticles,1);
ax1=zeros(nParticles,1);

% Specular or diffusive reflection
spec_on=0;
diff_on=1;

% Scattering probability
ps = zeros(nParticles,1);
ps(:,1)= 1 - (exp(1)^(-1*dt/col_time));



figure(8)
hold on
xlim([0 xlimit]);
ylim([0 ylimit]);
box = 1e-9.*[80 120 0 40; 80 120 60 100];
for j=1:size(box,1)
           plot([box(j, 1) box(j, 1) box(j, 2) box(j, 2) box(j, 1)],...
               [box(j, 3) box(j, 4) box(j, 4) box(j, 3) box(j, 3)], 'k-');
end

for i=1:nParticles 
      electron(i,:)=box_electron(Vth,box,xlimit,ylimit);
      position(i,:)=get_position(electron,i);
      
end

for j=1:iterations
    electron = move_with_box(electron,Vth,dt,xlimit,ylimit,ps,nParticles,diff_on,spec_on,box);
    for i=1:nParticles
          if abs(position(i,1) - electron(i,1))>ylim; 
            position(i,1)=electron(i,1); 
          end
          if(i<num_to_plot) 
             plot([position(i,1) electron(i,1)],[position(i,2) electron(i,2)],'Color',color(i,:)) 
            % pause(0.0001)
          end
    end
    position(:,1)=electron(:,1);
    position(:,2)=electron(:,2);

end

figure(8)
title('electron paths')
xlabel('x (m)')
ylabel('y (m)')

particle_matrix = zeros(100,100);
temperature_matrix = zeros(100,100);



for x=1:100
    for y=1:100
        for i = 1:nParticles
            if((electron(i,1) <= (xlimit*(x/100))) && (electron(i,1) > (xlimit*((x-1)/100))) && (electron(i,2) <= (ylimit*(y/100))) && (electron(i,2) > (ylimit*((y-1)/100))))
                particle_matrix(x,y) =+ 1;
                temperature_matrix(x,y) =+ (electron(i,4)^2)*mn/(2*kB);
            end
        end
    end
end

for i=1:100
    temperature_matrix(i,:) = mod(temperature_matrix(i,:),1000);
    temperature_matrix(i,:) = mod(temperature_matrix(i,:),10000);
    temperature_matrix(i,:) = mod(temperature_matrix(i,:),100);
    temperature_matrix(i,:)=temperature_matrix(i,:)*3;
end

figure(10)
surf(particle_matrix)
view(2)
xlim([0 100]);
ylim([0 100]);
title('Particle Map')

figure(11)
xlim([0 100]);
ylim([0 100]);
surf(temperature_matrix)
view(2)
zlabel('Temperature (K)')
title('Temperature Map')
