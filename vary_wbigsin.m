%% sweep varying w picture


clear all

gamma=1;
alpha=0.5;
E0=0
k=1;
K0=0.001
ww=1
w=ww*pi;
n= 2000;
h=0.025;
dt=0.5*h
dE=3;
[~,~, I, E, Edc]= sweep_steps2(K0, E0, alpha, gamma, n,h,dE,w);

[~,~, Idc, ~,  ~]= sweep_steps2(K0, E0, alpha, gamma, n,h,0,0);
figure 

dh=plot(Edc, I);hold on
legend('\omega= 2\pi', 'Location','northwest', 'fontsize', 15);hold on
set(dh,'linewidth',2);
ylabel('I(t)', 'fontsize', 20);hold on
xlabel('E(t)', 'fontsize', 20);hold on
title('Current vs Potential phase plane', 'fontsize', 20);hold on
set(gca,'FontName','Times');
saveas(gcf,['Phase', num2str(dE),'_w', num2str(ww),'alpha_',num2str(alpha),'K0_', num2str(K0), 'pi_std5.png'])

%%
figure
u=plot(I,'b');hold on
legend('I(t)', 'Location','northwest', 'fontsize', 15);hold on
set(u,'linewidth',1.5);
ylabel('I(t)', 'fontsize', 20);hold on
xlabel('Time', 'fontsize', 20);hold on
title('Current I(t)', 'fontsize', 20);hold on
set(gca,'FontName','Times');
saveas(gcf,['I2_dE', num2str(dE),'_w', num2str(ww), 'pi_std5.png'])

figure
u=plot(E,'r');hold on
legend('E(t)', 'Location','northwest', 'fontsize', 15);hold on
set(u,'linewidth',1.5);
ylabel('E(t)', 'fontsize', 20);hold on
xlabel('Time', 'fontsize', 20);hold on
title('E(t)', 'fontsize', 20);hold on
set(gca,'FontName','Times');
saveas(gcf,['E2_dE', num2str(dE),'_w', num2str(ww), 'pi_std5.png'])
%%
figure

L= length(I);


% stuff for KDC
KDC= fft(I-Idc);
P2 = (KDC(1:L/2));
%P1 = P2(1:L/2+1);
%P1(2:end-1) = 2*P1(2:end-1);


f = linspace(0,1,(L/2))/(dt);

% for checking
%plot(f(1:h),abs(P3(1:h)*10));hold on
%plot(f(1:h),abs(P6(1:h) ))

plot(f,abs(P2),'b-');hold on
l=1./f;
%plot(f(15:end),l(15:end)*4*w*dE/(dt*2*pi*K0/10),'r')
%plot(f(45:end),l(45:end)*8*w,'r')
%plot(f(1:h),abs(P1(1:h)-P6(1:h)) ,'rx-');hold on
legend({'I(t)','$$\frac{\Delta E}{ \omega/2 }\frac{1}{\pi}\frac{1}{f}$$'},'Interpreter', 'Latex', 'Fontsize',13);hold on
title(['Spectrum of I(t) (I_{dc} substracted), \omega=' num2str(ww) '\pi', ', \alpha=',num2str(alpha)],'fontsize',15);hold on
xlabel('f (Hz)' ,'fontsize', 20);hold on
set(gca,'XTick',[0:5:80])
ylabel('|P(f)|','fontsize', 20);hold on
%ylim([0, 0.008])
set(gca,'FontName','Times');
saveas(gcf,['Spectrum_dE', num2str(dE),'_w', num2str(ww),'K0_', num2str(K0),'alpha_',num2str(alpha), 'pi_std.png'])


%% 
oops
close all
clear var K
doub=1
if doub
    Times=2
    P=length(I)/(20*Times*5);
    for i=1:(20*Times*2.5)
        (i+1)*P
        K(i,:)=I(i*P:(i+1)*P);
    end
    [X,Y]=meshgrid(linspace(-10,10,P+1),linspace(0,20,P*2-1))
    surf(X,Y,K)
    ylabel('Time'); hold on
    xlabel('E_{dc}'); hold on
    xlim([-10,10])
    zlabel('I(t)'); hold on
    title('Forced oscillations','FontName','Times','FontSize',20); hold on   % put E0 and alpha and K0 in title and save figure accordingly
    set(gca,'FontName','Times','Fontsize', 15);
   % saveas(gcf,['Surf_doub2', num2str(dE),'_w', num2str(ww), '_std.png'])
else
    Times=1
    P=length(I)/(20*Times);
    for i=1:(20*Times -1)
        K(i,:)=I(i*P:(i+1)*P);
    end
    [X,Y]=meshgrid(linspace(-10,10,P+1),linspace(0,20,P/2-1))
    surf(X,Y,K)
    ylabel('Time'); hold on
    xlabel('E_{dc}'); hold on
    %xlim([-10,10])
    zlabel('I(t)'); hold on
    title('Forced oscillations','FontName','Times','FontSize',20); hold on   % put E0 and alpha and K0 in title and save figure accordingly
    set(gca,'FontName','Times','Fontsize', 15);
    %saveas(gcf,['Surf', num2str(dE),'_w', num2str(ww), 'pi_std.png'])
end




