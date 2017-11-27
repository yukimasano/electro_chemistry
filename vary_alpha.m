%% varying alpha
clear all
n= 100;
gamma=1;
alpha=0.5;
E0=0;
k=1;
K0=0.1;
alpha_collection= [0.1, 0.5, 0.8, 0.999] %0.1

n= 500;
h=0.1;
for alpha=alpha_collection 
    [~,~, I(k,:), E(k,:)]= sweep2(K0, E0, alpha, gamma, n,h);
    k=k+1
end
%%

figure

for i=1:length(alpha_collection)
    h=plot(E(i,:), I(i,:));hold on
    n=legend('\alpha= 0.1','\alpha= 0.5','\alpha= 0.8','\alpha= 0.999' ,'Location','Best', 'fontsize', 15);hold on % '\alpha= 0.1',
    set(h,'linewidth',2);
    set(n, 'fontsize', 15)
    ylabel('I(t)', 'fontsize', 20);hold on
    xlabel('E(t)', 'fontsize', 20);hold on
    title('Varying \alpha', 'fontsize', 20);hold on
end
set(gca,'FontName','Times');
saveas(gcf,'vary_alpha_longer.png')