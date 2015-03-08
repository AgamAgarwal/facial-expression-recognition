function [points,face] = goodPoints(I)
%GOODPOINTS 
%   @param  I: Input Image
%           face: return face image
%           points: return the good points to track in the face.
%                   [nose(4); mouth(4);lefteye(4); righteye(4)]
    face_box = ViolaAndJones(I,false);
    face = I(face_box(2):face_box(2)+face_box(4), face_box(1):face_box(1)+face_box(3),:);
    points =[];
    %Detect Nose
    noseDetector = vision.CascadeObjectDetector('Nose');
    nose_box = step(noseDetector,face);
    nose = face(nose_box(1,2):nose_box(1,2)+nose_box(1,4),nose_box(1,1):nose_box(1,1)+nose_box(1,3));
    temp_nose = detectMinEigenFeatures(nose);
    pt_nose = int32(temp_nose.selectStrongest(4).Location);
    if size(pt_nose,1) ~= 4
        for i=1:4-size(pt_nose,1)
            pt_nose = [pt_nose; pt_nose(1,:)];
        end
    end
    pt_nose(:,1) = pt_nose(:,1) + nose_box(1,1);
    pt_nose(:,2) = pt_nose(:,2) + nose_box(1,2);
    points = [points; pt_nose];
    
    %Detect Mouth
    mouthDetector = vision.CascadeObjectDetector('Mouth');
    mouth_box = step(mouthDetector,face);
    mouth = face(mouth_box(1,2):mouth_box(1,2)+mouth_box(1,4),mouth_box(1,1):mouth_box(1,1)+mouth_box(1,3));
    temp_mouth = detectMinEigenFeatures(mouth);
    pt_mouth = int32(temp_mouth.selectStrongest(4).Location);
    if size(pt_mouth,1) ~= 4
        for i=1:4-size(pt_mouth,1)
            pt_mouth = [pt_mouth; pt_mouth(1,:)];
        end
    end
    pt_mouth(:,1) = pt_mouth(:,1) + mouth_box(1,1);
    pt_mouth(:,2) = pt_mouth(:,2) + mouth_box(1,2);
    points = [points; pt_mouth];
   
    %Detect Left Eye
	lefteyeDetector = vision.CascadeObjectDetector('LeftEye');
	lefteye_box = step(lefteyeDetector,face);
	lefteye = face(lefteye_box(1,2):lefteye_box(1,2)+lefteye_box(1,4),lefteye_box(1,1):lefteye_box(1,1)+lefteye_box(1,3));
	temp_lefteye = detectMinEigenFeatures(lefteye);
	pt_lefteye = int32(temp_lefteye.selectStrongest(4).Location);
    if size(pt_lefteye,1) ~= 4
        for i=1:4-size(pt_lefteye,1)
            pt_lefteye = [pt_lefteye; pt_lefteye(1,:)];
        end
    end
	pt_lefteye(:,1) = pt_lefteye(:,1) + lefteye_box(1,1);
	pt_lefteye(:,2) = pt_lefteye(:,2) + lefteye_box(1,2);
	points = [points; pt_lefteye];
    
    %Detect Right Eye
	righteyeDetector = vision.CascadeObjectDetector('RightEye');
	righteye_box = step(righteyeDetector,face);
	righteye = face(righteye_box(1,2):righteye_box(1,2)+righteye_box(1,4),righteye_box(1,1):righteye_box(1,1)+righteye_box(1,3));
	temp_righteye = detectMinEigenFeatures(righteye);
	pt_righteye = int32(temp_righteye.selectStrongest(4).Location);
    if size(pt_righteye,1) ~= 4
        for i=1:4-size(pt_rightteye,1)
            pt_righteye = [pt_righteye; pt_righteye(1,:)];
        end
    end
	pt_righteye(:,1) = pt_righteye(:,1) + righteye_box(1,1);
	pt_righteye(:,2) = pt_righteye(:,2) + righteye_box(1,2);
	points = [points; pt_righteye];   
end

