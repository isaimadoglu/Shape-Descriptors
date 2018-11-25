function [basariOrani] = fitnessFunction(kromozom)

load etiketli_output.mat
one_indices = find(kromozom(:)==1);
X=vector(1:60,one_indices);
Y=vector(1:60,7);
Mdl = fitcknn(X,Y);  % Datas are classed here.

image_folder='C:\Users\isaim\Documents\MATLAB\images\test';
file_names = dir(fullfile(image_folder,'*.jpg'));
total_images = numel(file_names);

for n=1:total_images
    f=fullfile(image_folder, file_names(n).name);
    orj_im = imread(f);
    gray_im=rgb2gray(orj_im);
    zernike_im=gray_im; % for zernike
    gray_im2=gray_im;
    
    eta_mat = SI_moment(orj_im,gray_im2);
    hu_arr = Hu_Moments(eta_mat);
    
    indisler=find(gray_im<50);
    gray_im2(indisler)=0;
    
    bin_im=imbinarize(gray_im2);
    bw_img=1.-bin_im;
    %         figure, imshow(bw_img); %figure
    silme_sayisi= round(length(find(bw_img==1))/3);
    bw_img = bwareaopen(bw_img,silme_sayisi);
    
    %         bw_img=imfill(bw_img,'holes');
    %          figure, imshow(bw_img); %figure
    
    %      Zernike
         n1 = 4; m = 2;           % Define the order and the repetition of the moment
         p = zernike_im;
         p = logical(not(p));
         [~, AOH, PhiOH] = Zernikmoment(p,n1,m);     % Call Zernikemoment fuction  % horizontal
    
    stats = regionprops(bw_img,'Area','Eccentricity','Perimeter','EulerNumber');
    cevre= stats.Perimeter;
    alan = stats.Area;
    compactness = 4*pi*alan/cevre^2;
    vector2(n,:)=[stats.Area stats.Eccentricity stats.Perimeter stats.EulerNumber hu_arr(7) PhiOH compactness];
    
end


%[label ,score, cost]=predict(Mdl,vector2)
one_indices = find(kromozom(:)==1);
%vector2(:,one_indices)
[label ,score,~]=predict(Mdl,vector2(:,one_indices));

% indicess = find(label(14:16)==5);
indicess = sum(length(find(label(1:3)==1))+length(find(label(4:6)==2))+length(find(label(7:10)==3))); % 
indicess = sum(length(find(label(11:13)==4))+length(find(label(14:16)==5))+length(find(label(17:19)==6))) + indicess;
basariOrani=(indicess/19)*100; % my fitness value
% disp('sistim');
%Mdl.ClassNames
%Mdl.Prior
end
