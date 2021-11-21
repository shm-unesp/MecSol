%--------------------------------------------------------------------------
%   Tra�ado do C�rculo de Mohr para um Estado Plano de Tens�es
%
% Autor: Samuel da Silva
% UNESP/Ilha Solteira
% Resist�ncia dos Materiais II
%--------------------------------------------------------------------------
clc; 
clear;
close all;
%--------------------------------------------------------------------------
% Tens�es aplicadas em um ponto
Sigma_x = 25;   % MPa
Sigma_y = 5;    % MPa
Tau_xy = 10;    % MPa

S_m = (Sigma_x+Sigma_y)/2;  % Tens�o m�dia
R = sqrt(((Sigma_x-Sigma_y)/2)^2+Tau_xy^2);    % Raio
Tau_max = R;    % M�xima tens�o de cisalhamento

% Tens�es Principais neste ponto
S_1 = S_m + R;  % Tens�o m�xima
S_2 = S_m - R;  % Tens�o m�nima
Theta = atand(-(Sigma_x-Sigma_y)/(2*Tau_xy'))/2; % dire��o principal
% �ngulo para rotacionar o tensor das tens�es para obter as tens�es
% principais

% Visualiza��o do c�rculo de Mohr
ds = 0.01*(S_1-S_2);
S_x = S_2:ds:S_1;
% (S_x - S_m)^2 + S_xy^2 = R^2
S_xy = sqrt(R^2-(S_x-S_m).^2);  % Equa��o da circunfer�ncia

font_size = 20;
figure(1)
plot(S_x,S_xy, 'b','linewidth',2); hold on
plot(S_x,-S_xy,'b','linewidth',2); grid on; grid minor
plot([Sigma_x,Sigma_y],[-Tau_xy,Tau_xy],'o--r','linewidth',2);
xlabel('$\sigma_x$ [MPa]','FontSize',font_size,'interpreter','latex');
ylabel('$\tau_{xy}$ [MPa]','FontSize',font_size,'interpreter','latex');
set(gca,'FontSize',font_size,'TickLabelInterpreter','latex')
saveas(gcf,'mohr','epsc') % Salvar figura em eps

%--------------------------------------------------------------------------
% Tens�es principais via problema de auto-valor
%--------------------------------------------------------------------------
% Tensor das Tens�es
S =[Sigma_x  Tau_xy
    Tau_xy    Sigma_y];

% Resolvendo o problema de autovalor
[u,v]=eig(S);

% Tens�es principais
Sigma_1 = max(diag(v));   % tens�o m�xima
Sigma_2 = min(diag(v));   % tens�o m�nima

% dire��o principal (�ngulos dos auto-vetores com eixo x)
alpha = atan2(u(1,1),u(1,2))*180/pi-180;

%--------------------------------------------------------------------------

