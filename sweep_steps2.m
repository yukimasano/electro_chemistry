 function [Ca, Cb, I, E,Edc] = sweep_steps(K0, E0, alpha,gamma, n,h,dE ,w) 
 %this is a function to be called somewhere else. 
 % This does sweeping steps
    if nargin==0
        n= 1e2
        gamma=1;
        K0=15;
        alpha=0.5;
        E0=0;
        h =  0.05; % works until roughly K0 ~0.4
        w1=5;
        w2=0.5;
    end    
    Estart=-10;
    dt=0.5*h;   % delta t or 0.5*h^2
    
    %% CONSTRUCT OPERATOR 
     % Ka for Ca and Kb  for Cb
     % NSDE lecture 13
    myu=dt/(h^2);
    Ka = (1+2*myu)* diag ( ones (n ,1)) - 1*myu* diag ( ones (n -1 ,1) , -1) - 1*myu* diag ( ones (n -1 ,1) ,+1);
    Ka(end, :)= [ zeros(1,n-1), 1];
    %Ka (1,1:2) = [-1/h, 1/h]; 
    %Ka (1,1:2) = [-(dt/h + h/(2)), dt*h^(-1)]; 

    %
    Kb = (1+2*myu)* diag ( ones (n ,1)) - 1*myu* diag ( ones (n -1 ,1) , -1) - 1*myu* diag ( ones (n -1 ,1) ,+1);
    Kb(end, :)= [ zeros(1,n-1), 1];
    Kb (1 ,1:2) = [1, 0]; 
    %% 
    maxTime= 20;
    maxIter=ceil(maxTime/dt)
    Ca=ones(n,2); % c_A is one everywhere at t=0
    Cb=zeros(n,2); % c_B is zero everywhere at t=0
    E=zeros(maxIter,1);
    I=zeros(maxIter,1);
    I(1)=0.;
    E(1)=-10;
    Edc(1)=-10;
    l=1
    for i=2:maxIter
        t(i)=i*dt;
        Edc(i)=Estart + t(i);
        E(i)=Estart + t(i) +dE* (-1)^floor(w*t(i));
        deltaE= E(i)-E0;
        ba= zeros(n ,1);
        bb= zeros(n ,1);

%%%% using centered difference at zero and fully implicit %%%%%%
        l=K0*(dt/h)*exp(-alpha*deltaE);
        ba(1)= -l -0.5*Ca(1,1);
        first=-myu-0.5-l*(exp(deltaE)+1.0);
        Ka(1,1:2) = [first, myu]; 
        

%%%% what we had before %%%%%%
%         AB=K0*(dt)*(Ca(1,1)*exp(1*deltaE)- (1-Ca(1,1)) )*exp(-alpha*deltaE);
%         ba(1)= AB -0.5*(h)*Ca(1,1);
%         Ka(1,1:2) = [-dt/h-h/2, dt/h]; 
        
%%%% using NOT centered difference at zero and fully implicit %%%%%%        
%         l2=K0*exp(-alpha*deltaE);
%         first2=-1/h -l2*(exp(deltaE)+1);
%         Ka(1,1:2) = [first2, myu];
%         ba(1)=-l2;

        ba(2:n)= Ca(2:n,1);
        ba(n)= 1.0;
        Ca(:,2) = Ka\ba;
        I(i)= Ca(2,2)/h-Ca(1,2)/h;
%         bb(1)=  (1. -Ca(1,2))/gamma;
%         bb(2:n)= Cb(2:n, 1);
%         bb(n)= 0;
%         Cb(:,2)= Kb\ bb;

        % dont forget this one!
        Ca(:,1)=Ca(:,2);
        Cb(:,1)=Cb(:,2);
        if ba(1)>1000
            disp(i)
            ba(1)
            disp('something went wrong here, sorry')
            break
        end
    end
end
