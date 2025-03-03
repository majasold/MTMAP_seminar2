load azip.mat
load dzip.mat
load testzip.mat
load dtest.mat
z=azip; 
D=dzip;
A1=testzip; %z
D1=dtest; %znam

tocnost=zeros(5,5);

k=12;
p=30;
q=30;

for i=1:5
    for j=1:5
        tocnost(i,j)=algoritam2(z,D,A1, D1,k,p,q);
        q=q+10;
    end
    p=p+10;
end


   


