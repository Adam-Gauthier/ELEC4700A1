clear all; close all;
% Adam Gauthier 100947233
%% Part 1 Electron Modelling
% Constants
m0 = 9.109E-31; % electron mass (kg)
mn = 0.26*m0; % effective electron mass (kg)
kB = 1.3806E-23; % Boltzmann Constant (m^2kgs^-2K^-1)
T = 300; % system temperature (K)
Vth = (kB*T/mn)^0.5; % Thermal Velocity (m/s)
col_time = 0.2e-12; % Time between collisions (s)
mfp = col_time*Vth;% Mean Free Path (m)

% Parameters
nParticles = 100; % Number of particles
iterations = 500; % Maximum Iterations (500)
ylimit=100E-9; %Vertical limit
xlimit=200E-9; %Horizontal limit
dt= ylimit/(Vth*100); % simulation time step 
num_to_plot=10; % Number of particls to plot
color=hsv(num_to_plot); % Choose colormap


%Initialize electron and position array, each with random position/velocity
for i=1:nParticles
      electron(i,:)=elecProperties(Vth,xlimit,ylimit);
      position(i,:)=get_position(electron,i);
end

figure(1);
xlim([0 xlimit]);
ylim([0 ylimit]);
xlabel(sprintf('%d (m)',xlimit))
ylabel(sprintf('%d (m)',ylimit))
hold on

% Time loop
for step=1:iterations
    %Move electron and compute BCs
    electron = move_electron(electron,dt,xlimit,ylimit);
    %Compute electron temperature for 2D velocity and store
    temp(step) = (sum(electron(:,3).^2) + sum(electron(:,4).^2))*mn/(kB*2*nParticles); 
    
    
    for i=1:nParticles
        % Don't display jump across xlimits
        if abs(position(i,1) - electron(i,1))>ylimit; 
            position(i,1)=electron(i,1); 
        end
        % Plot subfraction of total electrons
        if(i<num_to_plot)
            %plot line between old and new position
            plot([position(i,1) electron(i,1)],[position(i,2) electron(i,2)],'Color',color(i,:)) ;
            pause(0.01)
        end 
    end
    %store/update position
    position(:,1)=electron(:,1);
    position(:,2)=electron(:,2);
    %display temp on plot
    title(sprintf('Temperature = %d',temp(step)))
    
end
hold off;

time = 1:iterations;
time=time*dt;
figure(2)
plot(time,temp);
title('Temperature plot')
xlabel('Time (s)')
ylabel('Temperature (K)')