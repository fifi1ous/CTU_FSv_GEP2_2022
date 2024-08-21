function [delta]=BS_redukce(k,p)
%vstup:
    %k-konstrukční podmínky λ[µm] p[torr] t[°C] e[%]
    %p-pracovní podmínky D[m] p[torr] t[°C] e[%]
%výstup:
    %delta-ppm
 
[r]=size(p,1);
alpha=1/273.16;
delta=ones(r,1);
Onsk=287.604+3*(1.6288/(k(1,1)^2))+5*(0.0136/(k(1,1)^4));
for n=1:r
    Nskk=Onsk*(k(1,2)/760)*(1/(1+alpha*k(1,3)))-(((5.5*10^(-2))/(1+alpha*k(1,3)))*k(1,4));
    Nskp=Onsk*(p(n,2)/760)*(1/(1+alpha*p(n,3)))-(((5.5*10^(-2))/(1+alpha*p(n,3)))*p(n,4));
    Pn=1+Nskp*10^(-6);
    delta(n,1)=((Nskk-Nskp)/Pn);
end
end


