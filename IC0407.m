N = input('How many base:');
x =zeros(N);
for i = 1 : N
    for j =1 : N
        x(i,j) = rand(1);
    end
end
n         = 1:N;
u         = 0:N-1;
tic;
cos_basis = zeros(N);
for i = u
    cos_basis(i+1,:) = sqrt(2/N).*cos((2.*(n-1)+1)*i*pi/(2*N)); % B'
end
cos_basis(1,:) = cos_basis(1,:)/sqrt(2); %B'
cos_basis      = cos_basis'; %B
toc;
%----------------------------method 1 ------------------------------------%
% method 1: DCT
%{
Inner_Product  = zeros(N);
Inner_Product  = cos_basis' * cos_basis;
figure;
mesh(cos_basis);
y     = cos_basis'  * x ; %DCT  y = B' * x
x_bar = cos_basis   * y ; %IDCT x = B  * y
error = mean(mean((x-x_bar).^2))
%}
%----------------------------method 2 ------------------------------------%
% method 2: Outer_Product
Outer_Product  = zeros(N,N,N.^2);
for i = 1 : N
    for j = 1 : N
        Outer_Product(:,:,(i-1)*N+j) =  cos_basis(:,i) * cos_basis(:,j)';
        subplot(N,N,(i-1)*N+j); imshow(Outer_Product(:,:,(i-1)*N+j),[]);
    end
end
y     = (cos_basis' * x  * cos_basis)' ;
% metrix representation : x_hat =  cos_basis  * y' * cos_basis'  ;
%------------------------summation representation-------------------------%
x_hat = zeros(N);
for i = 1 : N*N
   x_hat = x_hat + y(i) * Outer_Product(:,:,i);
end
error = mean(mean((x-x_hat).^2))