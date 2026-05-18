%Modelo  de hill
%Grafica de F vs longitud
subplot(2,2,1)
LO=1;
L=linspace(0.6*LO,1.4*LO,10000);
Fl=-6.25*(L/LO).^2+12.5.*(L/LO)-5.25;
plot(L,Fl,"b")
title("Fuerza vs longitud")
xlabel('Longitud')
ylabel('Fuerza')
grid on
%Grafica de fuerza vs velocidad
subplot(2,2,2)
Vo=1;
V=linspace(0,-Vo,10000);
Fv = (1 + V./Vo) ./ (1 - V./(0.23*Vo));
plot(V,Fv,"r")
title("Fuerza vs velocidad")
xlabel('Velocidad')
ylabel('Fuerza')
grid on

%Grafica 3d
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
title('Modelo de Hill: Fuerza en función de Longitud y Velocidad')
xlabel('Longitud (L)')
ylabel('Velocidad (V)')
zlabel('Fuerza ')
colormap('turbo')
shading interp
colorbar
grid on

%Grafica de lontiud total
% Parámetros de longitud
LO = 1;  
L = linspace(0.6*LO, 1.8*LO, 10000); 

% Fuerza activa
Fl_activa = -6.25 * (L/LO).^2 + 12.5 * (L/LO) - 5.25;
Fl_activa(Fl_activa < 0) = 0;  

% Parámetros
L = linspace(0.4, 1.8, 500);  
L0 = 1.0;                    

% Fuerza activa (curva tipo gaussiana)
w = 0.25;
F_activa = exp(-((L - L0) / w).^2);

% Fuerza pasiva (exponencial para L > L0)
k = 0.05;
a = 6.0;
F_pasiva = zeros(size(L));
F_pasiva(L > L0) = k * (exp(a * (L(L > L0) - L0)) - 1);

% Fuerza total
F_total = F_activa + F_pasiva;

% Graficas
subplot(2,2,4)
plot(L, F_activa, 'Color', [1 0.5 0], 'LineWidth', 2); hold on;  % Naranja
plot(L, F_pasiva, 'b', 'LineWidth', 2);                          % Azul
plot(L, F_total, 'r', 'LineWidth', 2);                           % Rojo

% Estética
xlabel('Longitud muscular (L / L_0)', 'FontSize', 12);
ylabel('Fuerza (F ', 'FontSize', 12);
title('Relación Fuerza-Longitud del Músculo', 'FontSize', 14);
legend('Fuerza activa', 'Fuerza pasiva', 'Fuerza total', 'Location', 'NorthWest');
grid on;
xlim([0.4 1.8]);
ylim([0 1.5]);
