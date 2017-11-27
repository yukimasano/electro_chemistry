%% Echem Sweep various parameters


%% varying K0
clear all

gamma=1;
alpha=0.5;
E0=0;
k=1;
K0_collection=[0.001, 0.1, 1, 5, 30];
K0=0.1;

n= 1000;
h=0.05;

for K0=K0_collection
    [~,~, I(k,:), E(k,:)]= sweep2(K0, E0, alpha, gamma, n,h);
    k=k+1
end


%%
figure
for i=1:length(K0_collection)
    h=plot(E(i,:), I(i,:));hold on
    n=legend('k_0= 0.001','k_0= 0.1','k_0= 1','k_0= 5','k_0= 30', 'Location','Best','linewidth',5, 'fontsize', 15);hold on
    ylabel('I(t)','FontSize',20);hold on
    xlabel('E(t)','FontSize',20);hold on
    set(h,'linewidth',2);
    set(n,'fontsize',12)
    title('Varying k_0','FontSize',20);hold on
end

set(gca,'FontName','Times');
saveas(gcf,'vary_K0_longer.png')


