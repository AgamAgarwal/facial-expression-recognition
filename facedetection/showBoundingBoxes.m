function showBoundingBoxes( I, b )
%SHOWBOUNDINGBOXES Summary of this function goes here
%   Detailed explanation goes here

CC = bwconncomp(b,4);
numPixels = cellfun(@numel, CC.PixelIdxList);
figure(1), imshow(I);
for i=1:size(numPixels,2)
    %[~, idx] = max(numPixels);
    b(:,:) = 0;
    %b(CC.PixelIdxList{idx}) = 1;
    b(CC.PixelIdxList{i}) = 1;
    stats = regionprops(b, 'BoundingBox');

    rectangle('Position',[stats.BoundingBox(1),stats.BoundingBox(2),stats.BoundingBox(3),stats.BoundingBox(4)],'EdgeColor', 'r','LineWidth',2);
end

end

