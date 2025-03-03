load azip.mat
load dzip.mat
load testzip.mat
load dtest.mat
A=azip;
D=dzip;
A1=testzip; %z
D1=dtest; %znam
clear azip dzip testzip dtest
AC=cell(1,10);
UC=cell(1,10);
for i=1:10
    z=i-1;
    ZJ=find(D==z);
    AC{i}=A(:, ZJ);
    [UC{i}, S, ~]=svd(AC{i}, 0);
end

brojac=0;
k=14;

for i=1:2007
    z=A1(:, i);
    U=UC{1};
    U=U(:,1:k);
    min=norm(z-U*U'*z);
    znam=0;
    for j=2:10
        U=UC{j};
        U=U(:,1:k);
        temp=norm(z-U*U'*z);
        if temp<min
            min=temp;
            znam=j-1;
        end
    end
    if znam==D1(i)
        brojac=brojac+1;
    end
end

tocnost=brojac/2007;

