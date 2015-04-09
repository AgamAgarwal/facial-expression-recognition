function [featureBox, img] = getFaceFeature(I, feature, annotated)
% getFaceFeature
% @param I is cropped image of the face
% @param feature can be 'LeftEye', 'RightEye', 'Mouth', 'Nose' only (for now)

    img = I;
    detector = vision.CascadeObjectDetector(feature, 'MergeThreshold', 32);
    IMod = I;
    if strcmp(feature, 'LeftEye')
        IMod = I(:, 1:end/2);
    elseif strcmp(feature, 'RightEye')
        IMod = I(:, end/2:end);  
    elseif strcmp(feature, 'Mouth')
        IMod = I(end/2:end, :);
    elseif strcmp(feature, 'Nose')
        IMod = I(end/4:3*end/4, :);
    else
        error('Invalid feature');
    end
    
    boxes = step(detector, IMod);
    if size(boxes, 1) == 0
        featureBox = [];
        return;
    end
    
    face=I;
    if strcmp(feature, 'RightEye')
        boxes(:, 1) = boxes(:, 1) + size(face,1)/2;
    elseif strcmp(feature, 'Mouth')
        boxes(:, 2) = boxes(:, 2) + size(face,2)/2;
    elseif strcmp(feature, 'Nose')
        boxes(:, 2) = boxes(:, 2) + size(face,2)/4;
    end
  
    [~, index] = max(boxes(:,3) .* boxes(:,4));
    featureBox = boxes(index, :);

    if annotated == true
        img = insertObjectAnnotation(I, 'rectangle', boxes, feature);
    end
end