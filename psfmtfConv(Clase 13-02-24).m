%Imagen original
f=imread('radiograph1.jpg');
imshow(f)
%%
%Imagen alterada
f=f(:,:,1);
imshow(f);
%%
f=double(f)/255;
imshow(f);
%%
f=imresize(f,0.25);

figure(1);
subplot(2,2,1);
imshow(f,[]);
subplot(2,2,2);
mesh(f);
%%
%Distorsion
%h=10*fspecial('disk',10);
h=fspecial('gaussian',7,2);
subplot(2,2,3);
%imshow(h,[]);
mesh(h);

sum=(sum(h));

%Convolusion
g=conv2(f,h,"same");
subplot(2,2,4);
imshow(g,[]);
%mesh(g);
%%  
F=fft2(f,sz(1),sz(2));
subplot(2,2,4);
imshow(fftshift(log(abs(F))),[]);

%%
sz=size(f);
f=zeros(sz(1));
f(int16(sz(1)/2),int16(sz(2)/2))=1;
f(int16(sz(1)/3),int16(sz(2)/2))=1;
f(int16(sz(1)/2),int16(sz(2)/3))=1;
subplot(2,2,2);
imshow(f,[]);

h=fspecial("gaussian",7,2);
subplot(2,2,3); 
mesh(h);

g=conv2(f,h,"same");
subplot(2,2,4);
imshow(g,[]);
%mesh(g);

%%

for x=1:sz(1)
    for y=1:sz(2)
        f(y,x)=sin(y*0.07)*sin(x*0.05);
    end
end
subplot(2,2,1);
imshow(f,[]);

%%

F=fft2(f,sz(1),sz(2));
subplot(2,2,2);

imshow(fftshift(log(abs(F))),[]);
subplot(2,2,3);

imshow(fftshift((abs(F))),[]);
%%
f=imresize(f,0.25);
h=fspecial('disk',10);
H=fft2(h,sz(1),sz(2));
G=F.*H;
g=abs(ifft2(G));

subplot(2,2,2);
imshow(g,[]);

G=F.*abs(H);
g=abs(ifft2(G));
subplot(2,2,3);
imshow(g,[]);
g2 = conv2(f,h,'same');

subplot(2,2,4);
imshow(g2,[]);
