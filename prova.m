load azip.mat
load dzip.mat
load testzip.mat
load dtest.mat
z=azip; 
D=dzip;
A1=testzip; %z
D1=dtest; %znam

% faza treniranja %

T=reshape(z,256,1,1707); 

AC = cell(1,10);
U1 = cell(1,10);
U2 = cell(1,10);
U3 = cell(1,10);
S = cell(1,10);
F = cell(1,10);
A = cell(1,10);
B = cell(1,10);

k=14;
p=20;
q=15;

for i=1:10
    znam=i-1;
    ZJ=find(D==znam);
    AC{i}=T(:, :, ZJ); % grupiranje po znamenkama
    [S{i}, U1{i}, U2{i}, U3{i}]=hosvd(AC{i}); % HOSVD
    pom=mnozenje(AC{i}, (U1{i}(:,1:p))', 1);
    F{i}=mnozenje(pom, (U2{i}(:,1:q))', 2); % F




    % Reshape F{i} to a 2D matrix
    F_reshaped = reshape(F{i}, p*q, []);
    
    % Perform SVD on the reshaped F
    [U, ~, ~] = svd(F_reshaped, 'econ');
    
    % Take the k most significant left singular vectors
    B{i} = U(:, 1:k);
 

    % normalizacija prvih k sliceva po trećem indeksu
    %for v = 1:k
     %   M{i}(:,:,v) = M{i}(:,:,v) / norm(M{i}(:,:,v), 'fro');
    %end

end

% faza testiranja %

R=zeros(10,1);
d=reshape(A1,256,1,2007);
brojac=0;
for i=1:2007
    for j=1:10
        dp=(U1{j}(:,1:p))'*d(:,:,i);
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