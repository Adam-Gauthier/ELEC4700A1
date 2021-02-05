clear all; close all;
% Adam Gauthier 100947233
%% Part 2 Collisions with Mean Free Path (MFP) 
global mfpx mfpy x_dist y_dist t_count mft
% Constants
m0 = 9.109E-31; % electron mass (kg)
mn = 0.26*m0; % effective electron mass (kg)
kB = 1.3806E-23; % Boltzmann Constant (m^2kgs^-2K^-1)
T = 300; % system temperature (K)
Vth = (kB*T/mn)^0.5; % Thermal Velocity (m/s)
col_time = 0.2e-12; % Time between collisions (s)
mfp = col_time*Vth;% Mean Free Path (m)

% Parameters
nParticles = 1000; % Number of particles
iterations =200; % Maximum Iterations (500)
ylimit=100E-9;%Vertical limit
xlimit=200E-9;%Horizontal limit
dt= ylimit/(Vth*100);% simulation time step
num_to_plot =10;% Number of particls to plot
color=hsv(num_to_plot);% Choose colormap

% The scattering probability
% $Pscattering = 1-(e^{-\frac{dt}{T}})$
%
ps = zeros(nParticles,1);
ps(:,1)= 1 - (exp(1)^(-1*dt/col_time));
% Mean Free Path and Time storage matrices
x_dist =zeros(nParticles,1);
mfpx=zeros(nParticles,iterations);
y_dist =zeros(nParticles,1); 
mfpy=zeros(nParticles,iterations);
t_count=zeros(nParticles,1); 
mft=zeros(nParticles,iterations); 

%Initialize electron and position array, each with random position/velocity
for i=1:nParticles 
      electron(i,:)=boltz_elec(Vth);
      position(i,:)=get_position(electron,i);
end

MB_velocities = sqrt(electron(:,3).^2 + electron(:,4).^2);
average_velocity = mean(MB_velocities);

figure(3)
hold on;
histogram(MB_velocities);
title(sprintf('Average Speed = %d',average_velocity));
xlabel('Speed (m/s)');
ylabel('Number of electrons');
hold off;

figure(4)
xlim([0 xlimit]);
ylim([0 ylimit]);
title('Electron movement')
xlabel('100 (m)')
ylabel('200 (m)')
hold on    

% Time loop
for index=1:iterations
    %Move electron and compute BCs
    electron = move_electron2(electron,dt,xlimit,ylimit,Vth,ps,nParticles,index); 
    %Compute electron temperature for 2D velocity and store
    temp(index) = (sum(electron(:,3).^2) + sum(electron(:,4).^2))*mn/(kB*nParticles); 
    for i=1:nParticles
        % Don't display jump across xlimits
          if abs(position(i,1) - electron(i,1))>ylimit; 
            position(i,1)=electron(i,1); 
          end
          if(i<num_to_plot) 
             plot([position(i,1) electron(i,1)],[position(i,2) electron(i,2)],'Color',color(i,:))
%              pause(0.001)
          end
    end
    position(:,1)=electron(:,1);
    position(:,2)=electron(:,2);

end
hold off;


figure(5)
hold on
time = dt:dt:iterations*dt;
plot(time,temp)
title('Temperature over Time')
xlabel('Time (s)')
ylabel('Temperature (K)') 
full_path = mean_free_path(mfpx,mfpy,nParticles,iterations);
full_time = mean_free_time(mft,nParticles);


figure(6)
plot(full_path,'o');
hold on;
line([0 nParticles],[mfp,mfp],'Color','red','LineStyle','-','LineWidth',5);
legend('Average mean free path per particle',sprintf('Theoretical Mean Free Path %d (m)',mfp));
title('Mean Free Path of Each Electron')
xlabel ('Electron Index')
ylabel('Mean Free Path (m)')
xlim([0 nParticles]);
ylim([0 max(full_path)]);


figure(7)
plot(full_time,'o','Color','r');
hold on
line([0 nParticles],[col_time,col_time],'Color','blue','LineStyle','-','LineWidth',5);
title('Mean Free Time of Each Electron')
legend('Average mean free time per particle',sprintf('Theoretical Mean Free Time %d (s)',col_time));
xlabel ('Electron Index')
ylabel('Mean Free Time (s)')
xlim([0 nParticles]);
ylim([0 max(full_time)]);