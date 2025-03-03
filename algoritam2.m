function [tocnost] = algoritam2 (z,D,A1, D1,k,p,q)

T=reshape(z,16,16,1707);
T2=reshape(A1,16,16,2007);

% Gaussovo zamucivanje
sigma = 0.9;
hsize = 5;
h = fspecial('gaussian', hsize, sigma);

T_blurred = zeros(20, 20, size(T, 3));
T_blurred2 = zeros(20,20,size(T,3));

for i = 1:size(T, 3)
    slice = T(:,:,i);
    blurred = imfilter(slice, h, 'replicate');
    T_blurred(:,:,i) = imresize(blurred, [20 20], 'bicubic');
end

for i = 1:size(T2, 3)
    slice = T2(:,:,i);
    blurred = imfilter(slice, h, 'replicate');
    T_blurred2(:,:,i) = imresize(blurred, [20 20], 'bicubic');
end
% matrica1 - za tenzor znamenki za treniranje

matrica1=reshape(T_blurred, 400, 1707); % jedan redak predstavlja jednu znamenku
d=reshape(T_blurred2, 400, 2007); % za testiranje

% faza treniranja %    

maks=0;
for i=1:10
    znam=i-1;
    ZJ=find(D==znam);
    [m,n]=size(ZJ);
    if n>maks
        maks=n; 
    end
end

% pravimo tenzor D, dimenzije: 400, ZJ, 10
tenzorD=zeros(400, maks, 10); % tenzorD = 0

B = cell(1,10);



for i=1:10
    znam=i-1;
    ZJ=find(D==znam);
    [m,n]=size(ZJ);
    tenzorD(:,1:n,i)=matrica1(:, ZJ); % grupiranje po znamenkama
end

[S, U1, U2, U3]=hosvd(tenzorD); % HOSVD
pom=mnozenje(tenzorD, (U1(:,1:p))', 1);
F=mnozenje(pom, (U2(:,1:q))', 2); % F je tenzor

for i=1:10
    [U, ~, ~]=svd(F(:,:,i));
    B{i}=U(:,1:k); % bazna matrica, k singularnih vektora
end

% faza testiranja %

R=zeros(10,1);
brojac=0;
for i=1:2007
    for j=1:10
        dp=(U1(:,1:p))'*d(:,i);
        R(j)=norm(dp-B{j}*(B{j})'*dp);
    end
    min_R=R(1);
    indeks=1;
    for j=2:10
        if R(j)<min_R
            min_R=R(j); % najmanja greska
            indeks=j; 
        end
    end
    znamenka=indeks-1; % znamenka koju je odredio algoritam

    if znamenka==D1(i)
        brojac=brojac+1;
    end
    
end

tocnost=brojac/2007;


