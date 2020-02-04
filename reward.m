function rew = reward(x)
f=5*10^9:0.2*10^9:15*10^9;
omega=2*pi*f;
pol=0;
Theta=15;
No_of_Layer=2;
Nf=length(f);
 Layer(1,:)= [2.5*10^-3 1.92 1.15 7.08 0.36 0];
 Layer(2,:)= [2.5*10^-3 .12 2.5 5.63 2.41 0]; 
n=No_of_Layer+2;
mu(1)= 4*pi*10^-7;
eps(1)=8.854*10^-12; % medium property(air)
RI(1)=1;
for q=2:(n-1)
    t(q)=Layer(q-1,1); %thickness
    mureal(q)=Layer(q-1,2);
    muimag(q)=Layer(q-1,3);
    epsreal(q)=Layer(q-1,4);;
    epsimag(q)=Layer(q-1,5);
    sigma(q)=Layer(q-1,6);
    mu(q)=(mureal(q)-(j*muimag(q)))*mu(1);
    eps(q)=(epsreal(q)-(j*epsimag(q)))*eps(1);
end
for N=2:(n-1)
    RI(N)=sqrt((mureal(N)-(j*muimag(N)))*(epsreal(N)-(j*epsimag(N))));
 end
theta(1)=Theta;

 for N=2:(n-1)
 theta(N)= asind((abs(RI(N-1))*sind(theta(N-1)))/abs(RI(N)));
 end
 for qq=1:Nf


 for N=1:(n-1)
 k(N)=omega(qq)*sqrt(mu(N)*eps(N));
 kz(N)=k(N)*cosd(theta(N));
 end
for N=1:(n-2)
 if pol==1
Rbar(n-1)=1;
 R(N)=((eps(N+1)*kz(N))-(eps(N)*kz(N+1)))/((eps(N+1)*kz(N))+(eps(N)*kz(N+1)));
 end
 if pol==0
Rbar(n-1)=-1;
 R(N)=((mu(N+1)*kz(N))-(mu(N)*kz(N+1)))/((mu(N+1)*kz(N))+(mu(N)*kz(N+1)));
 end
 end

 for N=(n-2):-1:1
Rbar(N)=(R(N)+(Rbar(N+1)*exp(-1i*2*(kz(N+1))*t(N+1))))/(1+(R(N)*Rbar(N+1)*exp(-1i*2*(kz(N+1))*t(N+1))));
 end
 RbarF(qq) = Rbar(1); %Reflection coefficient
 end
Reflectivity=(abs(RbarF)).^2; %Reflectivity
plot(f,Reflectivity); 
avgR = mean(Reflectivity);
M = max(Reflectivity);
th = sum(x);
if M > 0.3162
    rew = 0;
else
    rew =(1/(th/10))*(1+((1-(avgR/0.3162)^2)^0.5));
end

