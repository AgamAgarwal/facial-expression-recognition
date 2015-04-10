function [x_displacement, y_displacement,angle,velocity] = extractFeatures( face1, face2, points, window, fps)
%EXTRACTFEATURES Summary of this function goes here
%   @param  face1:  Fist Face
%           face2:  Second Face
%           points: Feature points of first face
%           window: Sampling each windowTH frame.
%           fps:    Video fps
    if sum(size(face1) ~= size(face2)) ~= 0
        face2 = imresize(face2,[size(face1,1) size(face1,2)]);
    end
    
    

    [x_diff, y_diff] = HS(face1, face2, 1, 100, [],[], 0,[]);
    x_displacement = x_diff(sub2ind(size(x_diff),points(:,1),points(:,2)));
    y_displacement = y_diff(sub2ind(size(y_diff),points(:,1),points(:,2)));
    x_zero = (x_displacement==0);
    y_zero = (y_displacement==0);
    angle = atan(y_displacement./x_displacement);
    angle(x_zero) = pi/2;
    angle(y_zero) = 0;    
    velocity = sqrt(y_displacement.^2 + x_displacement.^2)/(window/fps);
    
    %imshow(face1); hold on; 
    %plot(points(:,1),points(:,2),'ro');
    %plot(int32(points(:,1))+int32(x_displacement),int32(points(:,2))+int32(y_displacement),'bo');
    %arrayfun(@(x,y,dx,dy) plot([x x+int32(dx)],[y y+int32(dy)]),int32(points(:,1)), int32(points(:,2)), x_displacement, y_displacement);
	%pause;
end

