N         = input('´X¦hN: ');
n         = 1:N;
u         = 0:N-1;
cos_basis = zeros(N);
tic;
for i = u
    cos_basis(i+1,:) = sqrt(2/N).*cos((2.*(n-1)+1)*i*pi/(2*N));
end
cos_basis(1,:) = cos_basis(1,:)/sqrt(2);
cos_basis      = cos_basis';
toc;
Inner_Product  = zeros(N);
Inner_Product  = cos_basis' * cos_basis;
figure;
mesh(cos_basis);
x = zeros(1,N);
for i = 1 : N
    x(i) = rand(1);
end
y     = x * cos_basis  ; %DCT
x_bar = y * cos_basis' ; %IDCT
error = mean((x-x_bar).^2)