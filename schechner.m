% -----------------------------
% Schechner yy 

clc,clear all,close all
% addpath('./Dehaze_Code/images');
I_90 = im2double(imread('por90_2.jpg'));
I_0 = im2double(imread('por0_2.jpg'));
Imin = I_0-I_90;
Imax = I_0+I_90;
figure,imshow(Imax),title('I');
p = Imin./Imax;  % 0.7¸½½ü
% pmean = mean2(p)

%% p,A0
e = 1.3;
A = Imin./(p*e);
figure,imshow(A,[])
Amax = max(max(Imax));
% D_tmp = Imax-A*e;

D_tmp = Imax-A;
figure,imshow(D_tmp,[])

for i=1:3
    if(D_tmp<=0)
        D_tmp=nlfilter(D_tmp,[5 5],@mean_negtive);
    end
end
D_tmp=max(D_tmp,0);
figure,imshow(D_tmp);title('D_tmp');
t = 1-A./Amax;
t = max(t,0.01);
for i=1:3
    if(t<=0)
        t=nlfilter(t,[5 5],@mean_negtive);
    end
end
figure,imshow(t);title('t');

L = D_tmp./t;

figure,imshow(L),title('L');
imwrite(L,'L.jpg');

%% read the area
pos = load('pos_xian.mat');
pos = pos.pos;
I_crop = imcrop(L,pos);
figure,imshow(I_crop,[]);
imwrite(I_crop,'y_crop.jpg');
%% calculate the EME
% k1 = 10;
% k2 = 10;
% q=0.0001;
% d_yy=EME( L,k1,k2,q)

