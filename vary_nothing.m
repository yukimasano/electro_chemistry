%% sweep default picture


clear all

gamma=1;
alpha=0.5;
E0=0
k=1;
K0=0.1;
w_collection=[2*pi, 4*pi, 8*pi]
n= 100;
h=0.05;
dE= 0.1;
Times =1;

[Ca, Cb, I, E]= sweep();
figure 

h=plot(E(1,:), I(1,:));hold on
legend('\omega= 2\pi','\omega= 4\pi','\omega= 8\pi', 'Location','northwest', 'fontsize', 15);hold on
set(h,'linewidth',2);
ylabel('I(t)', 'fontsize', 20);hold on
xlabel('E(t)', 'fontsize', 20);hold on
title('Current vs Potential phase plane', 'fontsize', 20);hold on

set(gca,'FontName','Times');
%saveas(gcf,'vary_w.png','epsc')

%% 

% rescale surf plots wrt to time 0 to 40
surf(Ca(:, 1:1000:end)); hold on
surf(Cb(:, 1:1000:end)); hold on
xlabel('Time'); hold on
ylabel('position'); hold on
zlabel('C_a and C_b'); hold on
title('Sweeping','FontName','Times','FontSize',20); hold on   % put E0 and alpha and K0 in title and save figure accordingly

%saveas(gcf,'Ca_Cb_std.png','epsc')



