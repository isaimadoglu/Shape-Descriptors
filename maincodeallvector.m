
bwo=imread('bird0.jpg');
mask=rgb2gray(bw);
figure, imshow(mask);


eta_mat = SI_moment(bwo,mask); 
hu_arr = Hu_Moments(eta_mat);


bw=imread('bird0.jpg');
% bw8=bw;
% indisler=find(bw<255);
% bw8(indisler)=0;
bw1=rgb2gray(bw);

bw8=bw1;
indisler=find(bw1<165);
bw8(indisler)=0;

bw2=imbinarize(bw8);
b2 = bwareaopen(bw2,40);

bw3=1.-bw2;

bw3=imfill(bw3,'holes');
figure, imshow(bw3);

stats = regionprops(bw3,'Area','Eccentricity','Perimeter','EulerNumber');
vector=[stats.Area stats.Eccentricity stats.Perimeter stats.EulerNumber hu_arr]