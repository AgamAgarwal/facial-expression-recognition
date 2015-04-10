obj = videoinput('winvideo',1,'MJPG_640x480');
neutral = false;
while true
    cur = getsnapshot(obj);
    if ~neutral
        [points, face1,status] = goodPoints(cur);
        if points ~= zeros(16,2)
            disp('neutral image found');
            neutral = true;
        end
    else
        face_box = ViolaAndJones(cur, false);
        
        if (size(face_box,1) == 0)
            disp('No face for image2');
            img = cur;
        else
            face2 = cur(face_box(2):face_box(2)+face_box(4), face_box(1):face_box(1)+face_box(3),:);
            face2 = rgb2gray(face2);
            
            result = [];
            
            [x,y,angle,v] = extractFeatures(face1, face2, points,48,24);
            result = [x;y;angle;v]';
            
            label = classify(result, models, 7);
            %label = 'Face';
            img = insertObjectAnnotation(cur, 'rectangle', face_box, label);
        end
        
        imshow(img);
    end
    
end
