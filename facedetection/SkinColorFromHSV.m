function [ bounding_boxes ] = SkinColorFromHSV( image )
%SKINCOLORFROMHSV Function returns a matrix of bounding boxes for skin
%   color regions of size no_of_boxes x 4.
%
%	@param bounding_boxes:  [x, y, width, height]
%	@param image: Path to image file or MATLAB image object

    I = image;
    if ischar(I)
        if exist(I, 'file') ~= 2
            error('File does not exist');
        end
        I = imread(I);
    end
    [~,skin_region]=face(I);
    CC = bwconncomp(skin_region);
    no_of_objects = CC.NumObjects;
    bounding_boxes = zeros(no_of_objects,4);
    
    for i=1:no_of_objects
        b(:,:) = 0;
        b(CC.PixelIdxList{i}) = 1;
        stats = regionprops(b, 'BoundingBox');
        bounding_boxes(i,:) = stats.BoundingBox;
    end


end

