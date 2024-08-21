clc; clear; format long G
%%
fid=fopen('fyz_zadani_31.txt');
fgets(fid);
data=fscanf(fid,'%f %f %f %f %f\n',[5 inf])';
fclose(fid);
fid=fopen('mat_zadani_31.txt');
fgets(fid);
data2=fscanf(fid,'%*f %f %f %f %f %f %f %f %f %f %f %f\n',[11 inf])';
fclose(fid);
%%
EOK2000=data(1:3,2:5);
AGA6=data(4:6,2:5);
AGA700=data(7:10,2:5);
matEOK=data2(1:3,:);
mataga6=data2(4:6,:);
mataga7=data2(7:10,:);
KEOK200=[0.900,740,15,0];
KAGA6=[0.550,730,-15,0];
KAGA7=[0.633,740,-15,0];
mer=data(:,1);
%% AGA6
[deltaBSAGA6]=BS_redukce(KAGA6,AGA6);
[r]=size(AGA6,1);
deltaFRAGA6=ones(r,1);
daga6=ones(r,1);
for n=1:r
    deltaFRAGA6(n,1)=309.2-109.46*(AGA6(n,2)/(273.2+AGA6(n,3)));
    daga6(n,1)=AGA6(n,1)+(((AGA6(n,1)/1000)*deltaBSAGA6(n,1))/1000);
end
[vdAGA6]=mat_red(daga6,mataga6);
%% AGA700
[deltaBSAGA7]=BS_redukce(KAGA7,AGA700);
[r]=size(AGA700,1);
deltaFRAGA7=ones(r,1);
daga7=ones(r,1);
for n=1:r
    deltaFRAGA7(n,1)=308.6-107.9*(AGA700(n,2)/(273.2+AGA700(n,3)));
    daga7(n,1)=AGA700(n,1)+(((AGA700(n,1)/1000)*deltaBSAGA7(n,1))/1000);
end
[vdAGA7]=mat_red(daga7,mataga7);
%% EOK2000
[deltaBSEOK]=BS_redukce(KEOK200,EOK2000);
[r]=size(EOK2000,1);
deltaFREOK2000=ones(r,1);
deok2=ones(r,1);
for n=1:r
    deltaFREOK2000(n,1)=270.54-77978.3/(273.15+EOK2000(n,3))*EOK2000(n,2)/740;
    deok2(n,1)=EOK2000(n,1)+(((EOK2000(n,1)/1000)*deltaBSEOK(n,1))/1000);
end
[vdEOK2]=mat_red(deok2,matEOK);
%%
deltaBS=[deltaBSEOK;deltaBSAGA6;deltaBSAGA7];
deltaFR=[deltaFREOK2000;deltaFRAGA6;deltaFRAGA7];
delka=[vdEOK2;vdAGA6;vdAGA7];
tisk=[mer,deltaBS,deltaFR,delka]';
%%
fid=fopen('prijmeni.txt','w');
fprintf(fid,'%%zadání č. 31\n');
fprintf(fid,'%%student: \n');
fprintf(fid,'%%úloha    redukce podle B.S.[ppm]     redukce podle firmeních rovnic[ppm]     délka po mat. redukci[m]\n');
fprintf(fid,' %3d            %8.3f                          %8.3f                        %12.3f\n',tisk);
fclose(fid);
type roucka.txt