% Hill Model
% Force vs Length Graph
subplot(2,2,1)
LO=1;
L=linspace(0.6*LO,1.4*LO,10000);
Fl=-6.25*(L/LO).^2+12.5.*(L/LO)-5.25;
plot(L,Fl,"b")
title("Force vs Length")
xlabel('Length')
ylabel('Force')
grid on

% Force vs Velocity Graph
subplot(2,2,2)
Vo=1;
V=linspace(0,-Vo,10000);
Fv = (1 + V./Vo) ./ (1 - V./(0.23*Vo));
plot(V,Fv,"r")
title("Force vs Velocity")
xlabel('Velocity')
ylabel('Force')
grid on

% 3D Graph
LO = 1;
Vo = 1;
L = linspace(0.6*LO, 1.4*LO, 100);
V = linspace(-Vo, 0, 100);
[Lm, Vm] = meshgrid(L, V);
Fl = -6.25*(Lm/LO).^2 + 12.5*(Lm/LO) - 5.25;         
Fv = (1 + Vm./Vo) ./ (1 - Vm./(0.23*Vo));             
F_total = Fl .* (Fv / max(Fv(:)));
subplot(2,2,3)
surf(Lm, Vm, F_total)
title('Hill Model: Force as a function of Length and Velocity')
xlabel('Length (L)')
ylabel('Velocity (V)')
zlabel('Force')
colormap('turbo')
shading interp
colorbar
grid on

% Total Length Graph
% Length parameters
LO = 1;  
L = linspace(0.6*LO, 1.8*LO, 10000); 

% Active force
Fl_activa = -6.25 * (L/LO).^2 + 12.5 * (L/LO) - 5.25;
Fl_activa(Fl_activa < 0) = 0;  

% Parameters
L = linspace(0.4, 1.8, 500);  
L0 = 1.0;                    

% Active force (Gaussian curve type)
w = 0.25;
F_activa = exp(-((L - L0) / w).^2);

% Passive force (Exponential for L > L0)
k = 0.05;
a = 6.0;
F_pasiva = zeros(size(L));
F_pasiva(L > L0) = k * (exp(a * (L(L > L0) - L0)) - 1);

% Total force
F_total = F_activa + F_pasiva;

% Plots
subplot(2,2,4)
plot(L, F_activa, 'Color', [1 0.5 0], 'LineWidth', 2); hold on;  % Orange
plot(L, F_pasiva, 'b', 'LineWidth', 2);                          % Blue
plot(L, F_total, 'r', 'LineWidth', 2);                           % Red

% Styling
xlabel('Muscle Length (L / L_0)', 'FontSize', 12);
ylabel('Force (F)', 'FontSize', 12);
title('Muscle Force-Length Relationship', 'FontSize', 14);
legend('Active force', 'Passive force', 'Total force', 'Location', 'NorthWest');
grid on;
xlim([0.4 1.8]);
ylim([0 1.5]);
