% non serve per il programma principale

%%
%calculation of the average percentage of intensive care needed
%on the total number of hospitalized patients
xi=zeros(465,1);
for i=1:465
    xi(i)=100*(Italiatrendgiornaliero(i,2)/Italiatrendgiornaliero(i,1)); 
    %calculation of the percentage of intensive care
    %needed considering daily data from 02.24.2020 al 06.02.2021: 
    %Italiatrendgiornaliero(differenza_terapie_intensive, differenza_ricoverati)   
end
xim=sum(xi)/465

%%
%calculation of economic value lost due to a covid death
w=29984;                                      %PIL pro-capite updated to 2019 (pre-covid),data source: http://dati.istat.it/Index.aspx?QueryId=12006
Ar=[50.5 40.5 30.5 20.5 10.5 2.5];            %remaining years of work, in the hypothesis of a pension at 70 yo and considering the average age by age group
n=[953 3917 5627 7103 4672 696];              %number of workers (in thousands) by age group (data updated to the fourth quarter 2020, data source: http://dati.istat.it/Index.aspx?QueryId=26852
m=[0.0010 0.0015 0.0055 0.0220 0.0685 0.1770]; %percentage of deaths adjusted by age group (data updated to 06.01.2021), data source: ISS

num=0;
den=sum(n);
for i=1:6
    num=num+(w*Ar(i)*n(i)*m(i));
end

gamma=num/den
%%