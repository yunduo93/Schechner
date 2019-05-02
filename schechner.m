% -----------------------------
% Schechner yy 

clc,clear all,close all
% addpath('./Dehaze_Code/images');
[fname pname]=uigetfile({'*.png;*.jpg;*.tif','Figure(*.png,*.jpg,*.tif)'},'pick a file','F:\0-动笔系列\pic');
image1= imread([pname,fname]);
I_90 = im2double(image1);
[fname2 pname2]=uigetfile({'*.png;*.jpg;*.tif','Figure(*.png,*.jpg,*.tif)'},'pick a file','F:\0-动笔系列\pic');
image2= imread([pname2,fname2]);
I_0 = im2double(image2);

Imin = I_0-I_90;
Imax = I_0+I_90;
% figure,imshow(Imax),title('I');
p = Imin./Imax;  % 0.7附近
% pmean = mean2(p)

%% p,A0
e = 1.3;
A = Imin./(p*e);
Amax = max(max(Imax));

D_tmp = Imax-A;
    if(D_tmp<=0)
        D_tmp=nlfilter(D_tmp,[5 5],@mean_negtive);
    end
D_tmp=max(D_tmp,0);
figure,imshow(D_tmp);title('D_tmp');

t = 1-A./Amax;
t = max(t,0.01);  % t = max(t,0.01);
    if(t<=0)
        t=nlfilter(t,[5 5],@mean_negtive);
    end
figure,imshow(t);title('t');

L = D_tmp./t;
figure,imshow(L,[])

%% save the result
% fpath=pwd; % save current dialoge
% cd('C:\Users\zy128\Documents\GitHub\Single-Polarized-Imaging\result表3.1'); % change to the designate dialoge
% % mkdir result表3.1  % If don't have a folder, then New Folder
% imwrite(L,'L2_yy.jpg');
% cd(fpath)  % back to current dialoge

%% calculate the EME
% k1 = 10;
% k2 = 10;
% q=0.0001;
% d_yy=EME( L,k1,k2,q)

