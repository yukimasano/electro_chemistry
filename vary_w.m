%% sweep varying w picture


clear all

gamma=1;
alpha=0.5;
E0=0
k=1;
K0=0.1;
w_collection=[2*pi]%, 4*pi, 8*pi];
w=2*pi
n= 1000;
dE_c=[5,2]
h=0.05;
dE=2;

for dE=dE_c
    [~,~, I(k,:), E(k,:), Edc(k,:)]= sweep_sin(K0, E0, alpha, gamma, n,h,w,dE,1);
    k=k+1
end

[~,~, Ik, E(k,:), Edc(k,:)]= sweep_sin(K0, E0, alpha, gamma, n,h,w,0,1);
%%
figure 
for i=1:2
    h=plot(Edc(i,:), I(i,:));hold on
   % n=legend('\omega= 2\pi','\omega= 4\pi','\omega= 8\pi', 'Location','Best', 'fontsize', 15);hold on
    set(h,'linewidth',2);
   % set(n,'fontsize',15)
    ylabel('I(t)', 'fontsize', 20);hold on
    xlabel('E(t)', 'fontsize', 20);hold on
    title('Varying \DeltaE, \omega=2\pi', 'fontsize', 20);hold on
end
plot(Edc(i,:),Ik,'linewidth',2)
l=legend('\DeltaE=5','\DeltaE=2','\DeltaE=0')
set(l,'fontsize',15,'Location','Best')
set(gca,'FontName','Times');
saveas(gcf,'vary_dE.png')


