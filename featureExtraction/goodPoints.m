function [points,face,status] = goodPoints(I)
%GOODPOINTS 
%   @param  I: Input Image
%           face: return face image
%           points: return the good points to track in the face.(16x2)
%                   [nose(4); mouth(4);lefteye(4); righteye(4)] 
%           status: 0: not enough points, 
%                   1: 16 points. 

    status = 1;
    points =zeros(16,2);
    if (size(I,3)==3)
        I = rgb2gray(I);
    end
    % Detect Face
    temp_box = ViolaAndJones(I, false);
    
    
    if (size(temp_box,1) ~= 0)
        face_box = temp_box;
    else
        face = 0;
        status = 0;
        return;
    end
    face = I(face_box(2):face_box(2)+face_box(4), face_box(1):face_box(1)+face_box(3));
    %Face Size is always 128x128
    face = imresize(face,[128 128]);
    
    %Detect Nose
    %noseDetector = vision.CascadeObjectDetector('Nose');
    %nose_box = step(noseDetector,face);
    nose_box = getFaceFeature(face,'Nose',false);
    if (size(nose_box,1) == 0)
        disp('nose not detected');
        status = 0;
        return;
    else
        nose_box = nose_box(1,:);
        nose = face(nose_box(1,2):nose_box(1,2)+nose_box(1,4),nose_box(1,1):nose_box(1,1)+nose_box(1,3));
        try
            temp_nose = detectMinEigenFeatures(nose);
        catch
            disp('nose eigen feature');
            status=0;
            return;
        end
        temp_pt_nose = int32(temp_nose.selectStrongest(4).Location);
        %Arrange by x-coordiante value
        [~, sortorder] = sort(temp_pt_nose(:,1));
        temp_pt_nose = temp_pt_nose(sortorder,:);
        pt_nose = zeros(4,2); 
        pt_nose(1:size(temp_pt_nose,1),:) = temp_pt_nose;
        
        %Set invalid status for points that we don't have
        if size(temp_pt_nose,1) ~= 4
            status = 0;    
            disp('less nose points');
            return;
        end
        pt_nose(:,1) = pt_nose(:,1) + nose_box(1,1);
        pt_nose(:,2) = pt_nose(:,2) + nose_box(1,2);
        points(1:4,:) = pt_nose;
    end
    
    %Detect Mouth
    %mouthDetector = vision.CascadeObjectDetector('Mouth');
    %mouth_box = step(mouthDetector,face);
    mouth_box = getFaceFeature(face,'Mouth',false);
    
    if (size(mouth_box,1) == 0)
        disp('nose not detected');
        status = 0;
        return;
    else
        mouth_box = mouth_box(1,:);
        mouth = face(mouth_box(1,2):mouth_box(1,2)+mouth_box(1,4),mouth_box(1,1):mouth_box(1,1)+mouth_box(1,3));
        try
            temp_mouth = detectMinEigenFeatures(mouth);
        catch
            disp('mouth eigen feature');
            status=0;
            return;
        end
        temp_pt_mouth = int32(temp_mouth.selectStrongest(4).Location);
        %Arrange by x-coordiante value
        [~, sortorder] = sort(temp_pt_mouth(:,1));
        temp_pt_mouth = temp_pt_mouth(sortorder,:);
        pt_mouth = zeros(4,2); 
        pt_mouth(1:size(temp_pt_mouth,1),:) = temp_pt_mouth;
        
        %Set invalid status for points that we don't have
        if size(temp_pt_mouth,1) ~= 4
            status = 0;    
            disp('less mouth points');
            return;
        end
        pt_mouth(:,1) = pt_mouth(:,1) + mouth_box(1,1);
        pt_mouth(:,2) = pt_mouth(:,2) + mouth_box(1,2);
        points(5:8,:) = pt_mouth;
    end
    
    %Detect Left Eye
	%lefteyeDetector = vision.CascadeObjectDetector('LeftEye');
    %lefteye_box = step(lefteyeDetector,face);
    lefteye_box = getFaceFeature(face,'LeftEye',false);
    
    if (size(lefteye_box,1) == 0)
        disp('lefteye not detected');
        status = 0;
        return;
    else
        lefteye_box = lefteye_box(1,:);
        lefteye = face(lefteye_box(1,2):lefteye_box(1,2)+lefteye_box(1,4),lefteye_box(1,1):lefteye_box(1,1)+lefteye_box(1,3));
        try
            temp_lefteye = detectMinEigenFeatures(lefteye);
        catch
            disp('Lefteye eigen feature');
            status=0;
            return;
        end
        temp_pt_lefteye = int32(temp_lefteye.selectStrongest(4).Location);

        %Arrange by x-coordiante value
        [~, sortorder] = sort(temp_pt_lefteye(:,1));
        temp_pt_lefteye = temp_pt_lefteye(sortorder,:);
        pt_lefteye = zeros(4,2); 
        pt_lefteye(1:size(temp_pt_lefteye,1),:) = temp_pt_lefteye;
        
        %Set invalid status for points that we don't have
        if size(temp_pt_lefteye,1) ~= 4
            status = 0;    
            disp('less lefteye points');
            return;
        end
        pt_lefteye(:,1) = pt_lefteye(:,1) + lefteye_box(1,1);
        pt_lefteye(:,2) = pt_lefteye(:,2) + lefteye_box(1,2);
        points(9:12,:) = pt_lefteye;
    end
    
    %Detect Right Eye
	%righteyeDetector = vision.CascadeObjectDetector('RightEye');
    %righteye_box = step(righteyeDetector,face);
    righteye_box = getFaceFeature(face,'RightEye',false);
    
    if (size(righteye_box,1) == 0)
        disp('righteye not detected');
        status = 0;
        return;
    else
        righteye_box = righteye_box(1,:);
        righteye = face(righteye_box(1,2):righteye_box(1,2)+righteye_box(1,4),righteye_box(1,1):righteye_box(1,1)+righteye_box(1,3));
        try
            temp_righteye = detectMinEigenFeatures(righteye);
        catch
            disp('righteye eigen feature');
            status=0;
            return;
        end
        temp_pt_righteye = int32(temp_righteye.selectStrongest(4).Location);

        %Arrange by x-coordiante value
        [~, sortorder] = sort(temp_pt_righteye(:,1));
        temp_pt_righteye = temp_pt_righteye(sortorder,:);
        pt_righteye = zeros(4,2); 
        pt_righteye(1:size(temp_pt_righteye,1),:) = temp_pt_righteye;
        
        %Set invalid status for points that we don't have
        if size(temp_pt_righteye,1) ~= 4
            status = 0;    
            disp('less righteye points');
            return;
        end
        pt_righteye(:,1) = pt_righteye(:,1) + righteye_box(1,1);
        pt_righteye(:,2) = pt_righteye(:,2) + righteye_box(1,2);
        points(13:16,:) = pt_righteye;
    end 
end

