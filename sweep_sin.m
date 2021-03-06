function [Ca, Cb, I, E,Edc] = sweep_sin(K0, E0, alpha,gamma, n,h ,w,dE,Times) 
 % this is a function to be called somewhere else. 
 % this is a function for the sin sweep
 % K0 is base reaction rate
 % E0 is dc component
 % alpha is transfer coefficient
 % gamma is the ratio of diffusion constants (D_b/D_a)
 % dE is the amplitude of the oscillation
 % w is the frequency
 % n is number of steps
 % h is stepsize
 
    if nargin==0
        n= 1e2
        gamma=1;
        K0=15;
        alpha=0.5;
        E0=0;
        h =  0.05; % works until roughly K0 ~0.4
        w=2*pi;
        dE=0.1;
        Times=1;
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
    maxTime= 20*Times;
    maxIter=ceil(maxTime/dt);
    Ca=ones(n,2); % c_A is one everywhere at t=0
    Cb=zeros(n,2); % c_B is zero everywhere at t=0
    E=zeros(maxIter,1);
    I=zeros(maxIter,1);
    I(1)=0.;
    E(1)=-10;
    Edc(1)=-10;
    for i=2:maxIter
        t(i)=i*dt;
        if t(i)<=20
            E(i)=Estart + t(i) + dE * sin(w*t(i));
            Edc(i)=Estart + t(i);
        else
            E(i)=Estart + 20+dE *sin(w*0) - (t(i)-20-dE *sin(w*0)) + dE * sin(w*(t(i)-20));
            Edc(i)=Estart+ 20+dE *sin(w*0)  - (t(i)-20-dE *sin(w*0));
        end
       % if t(i)==maxTime/Times
       %     Estart=-10*(Times+k) +sin(w*20) ;
       %     k= k+1
      %  end
        deltaE= E(i)-E0;
        ba= zeros(n ,1);
        bb= zeros(n ,1);

%%%% using centered difference at zero and fully implicit %%%%%%
        l=K0*(dt/h)*exp(-alpha*deltaE);
        ba(1)= -l -0.5*Ca(1,1);
        first=-myu-0.5-l*(exp(deltaE)+1.0);
        Ka(1,1:2) = [first, myu]; 
        
        ba(2:n)= Ca(2:n,1);
        ba(n)= 1.0;
        Ca(:,2) = Ka\ba;
        I(i)= Ca(2,2)/h-Ca(1,2)/h;
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
