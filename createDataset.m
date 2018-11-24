%% Creating Dataset

clearvars; clc;

image_folder='C:\Users\isaim\Desktop\images';
file_names = dir(fullfile(image_folder,'*.jpg'));
total_images = numel(file_names);

for n=1:total_images
    f=fullfile(image_folder, file_names(n).name);
    orj_im = imread(f);
%     figure, imshow(orj_im);
    
    gray_im=rgb2gray(orj_im);
    gray_im2=gray_im;
    
    eta_mat = SI_moment(orj_im,gray_im2);
    hu_arr = Hu_Moments(eta_mat);
    
    indisler=find(gray_im<165);
    gray_im2(indisler)=0;
    
    bin_im=imbinarize(gray_im2);
    bw_img=1.-bin_im;
%     figure, imshow(bw_img); %figure
    silme_sayisi= round(length(find(bw_img==1))/3);
    bw_img = bwareaopen(bw_img,silme_sayisi);

%     bw_img=imfill(bw_img,'holes');
%     figure, imshow(bw_img); %figure
    
    
    stats = regionprops(bw_img,'Area','Eccentricity','Perimeter','EulerNumber');
    cevre= stats.Perimeter;
    alan = stats.Area;
    compactness = 4*pi*alan/cevre^2;
    disp([stats.EulerNumber]);
    vector(n,:)=[stats.Area stats.Eccentricity stats.Perimeter stats.EulerNumber hu_arr(7) compactness];
    
end


% bwo=imread('bird0.jpg');
% mask=rgb2gray(bw);
%
% eta_mat = SI_moment(bwo,mask);
% hu_arr = Hu_Moments(eta_mat);