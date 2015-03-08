function [diff_im]=diffImage( im1, im2 )
%DIFFIMAGE Function returns the difference of the two given images
%
%	@param im1: Ist image
%	@param im2: IInd image

%convert Ist image to grayscale
if size(im1, 3)>1
	g1=rgb2gray(im1);
else
	g1=im1;
end

%convert IInd image to grayscale
if size(im2, 3)>1
	g2=rgb2gray(im2);
else
	g2=im2;
end

%find the difference of the two images
diff_im=g2-g1;

end

