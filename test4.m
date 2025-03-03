load azip.mat
load dzip.mat
load testzip.mat
load dtest.mat
z=azip; 
D=dzip;
A1=testzip; %z
D1=dtest; %znam

tocnost_test=zeros(10, 10);
p=64;
q=64;

for k=10:19

    tocnost_test(k-9, :)=algoritam2_modifikacija(z,D,A1, D1,k,p,q);

end


