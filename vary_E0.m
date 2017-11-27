%% varying E0
clear all

gamma=1;
alpha=0.5;
E0_collection=[-5, -2, 0, 2, 5];
k=1;
K0=0.1;

n= 500;
h=0.1;
for E0=E0_collection
    [~,~, I(k,:), E(k,:)]= sweep2(K0, E0, alpha, gamma, n,h);
    k=k+1
end

%%
figure

for i=1:length(E0_collection)
    h=plot(E(i,:), I(i,:));hold on
    n=legend('E0= -5','E0= -2','E0= 0','E0= 2','E0= 4.5', 'Location','northwest', 'fontsize', 15);hold on
    set(h,'linewidth',2);
    set(n,'fontsize', 15)
    ylabel('I(t)', 'fontsize', 20);hold on
    xlabel('E(t)', 'fontsize', 20);hold on
    title('Varying E_0', 'fontsize', 20);hold on
end
set(gca,'FontName','Times');
saveas(gcf,'vary_E0.png')
