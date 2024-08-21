function [vd]=mat_red(d,data)
%funkce pro zavedení matematické redukce
%vstup:
%   d-délky pro fyzikální redukci
%   data-údaje pro zavedení matematické redukce
%výstup:
%   vd-výsledná délka
R=6380000;
a=6377397.15508;
e=0.00667437223;
er=0.006719218798;
R0=1298039;
[r1]=size(data,1);
vd=ones(r1,1);
for n=1:r1
    L=d(n,1)-(2*data(n,9)-data(n,9)^2)*(d(n,1)^3/(24*R^2));
    N=a/sqrt(1-e*sind(data(n,10))^2);
    Ra=N/(1+er*cosd(data(n,10))^2*cosd(data(n,11))^2);
    Ha=data(n,3)+data(n,7);
    Hb=data(n,6)+data(n,8);
    l=sqrt((L^2-(Ha-Hb)^2)/(((1+(Ha)/Ra))*(1+(Hb)/Ra)));
    s=l+((l^3)/(24*R^2));
    se=s-(Hb)*(d(n,1)/R)*er*cosd(data(n,10))^2*cosd(data(n,11))^2;
    Dr1=sqrt(data(n,1)^2+data(n,2)^2)-R0;
    Dr2=sqrt(data(n,4)^2+data(n,5)^2)-R0;
    Dr3=sqrt(((data(n,4)+data(n,1))/2)^2+(((data(n,2)+data(n,5))/2)^2))-R0;
    m1=0.9999+10^(-14)*Dr1^2*(1.22822-Dr1*10^(-7)*(3.154-Dr1*10^(-6)*(1.848-Dr1*10^(-6)*1.15)));
    m2=0.9999+10^(-14)*Dr2^2*(1.22822-Dr2*10^(-7)*(3.154-Dr2*10^(-6)*(1.848-Dr2*10^(-6)*1.15)));
    m3=0.9999+10^(-14)*Dr3^2*(1.22822-Dr3*10^(-7)*(3.154-Dr3*10^(-6)*(1.848-Dr3*10^(-6)*1.15)));
    vd(n,1)=se*1/6*(m1+m2+4*m3);
end
