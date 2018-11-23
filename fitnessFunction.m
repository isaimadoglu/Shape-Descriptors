function [basariOrani] = fitnessFunction(kromozom)

%% section1
% image_folder='C:\Users\isaim\Documents\MATLAB\images';
% file_names = dir(fullfile(image_folder,'*.jpg'));
% total_images = numel(file_names);
% 
% for n=1:total_images
%    f=fullfile(image_folder, file_names(n).name);
%     orj_im = imread(f);
%    gray_im=rgb2gray(orj_im);
% gray_im2=gray_im;
% indisler=find(gray_im<165);
% gray_im2(indisler)=0;
% bin_im=imbinarize(gray_im2);
% bin_im_removed = bwareaopen(bin_im,40);
% bw_img=1.-bin_im_removed;
% bw_img=imfill(bw_img,'holes');
% %figure, imshow(bw_img);
% 
% % stats = regionprops(bw_img,'Area','Eccentricity','Perimeter','EulerNumber');
% % vector(n,:)=[stats.Area stats.Eccentricity stats.Perimeter stats.EulerNumber];
% stats = regionprops(bw_img,'Eccentricity');
% vector(n,:)=[ stats.Eccentricity];
%    
% end
%% section2

load etiketli_output.mat
one_indices = find(kromozom(:)==1);
X=vector(1:19,one_indices);
Y=vector(1:19,5);
% X=vector(1:19,1);
% Y=vector(1:19,2);
Mdl = fitcknn(X,Y);  %BURADA HALLETTIK KARDES

image_folder='C:\Users\isaim\Documents\MATLAB\images\test';
file_names = dir(fullfile(image_folder,'*.jpg'));
total_images = numel(file_names);

for n=1:total_images
    f=fullfile(image_folder, file_names(n).name);
    orj_im = imread(f);
    gray_im=rgb2gray(orj_im);
    gray_im2=gray_im;
    indisler=find(gray_im<165);
    gray_im2(indisler)=0;
    bin_im=imbinarize(gray_im2);
    bin_im_removed = bwareaopen(bin_im,40);
    bw_img=1.-bin_im_removed;
    bw_img=imfill(bw_img,'holes');
    %figure, imshow(bw_img);
    
    stats = regionprops(bw_img,'Area','Eccentricity','Perimeter','EulerNumber');
    vector2(n,:)=[stats.Area stats.Eccentricity stats.Perimeter stats.EulerNumber];
    % stats = regionprops(bw_img,'Eccentricity');
    % vector2(n,:)=[ stats.Eccentricity];
    
end


%[label ,score, cost]=predict(Mdl,vector2)
one_indices = find(kromozom(:)==1);
%vector2(:,one_indices)
[label ,score,~]=predict(Mdl,vector2(:,one_indices));

indicess = find(label(1:3)==1); % because the label of horses is 1
basariOrani=(length(indicess)/3)*100; % my fitness value

%Mdl.ClassNames
%Mdl.Prior
end
