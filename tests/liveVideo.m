obj = videoinput('winvideo',1,'MJPG_160x120');

while true
    first = getsnapshot(obj);
    [points, face1,status] = goodPoints(first);
    if points ~= zeros(16,2)
        disp('neutral image found');
        break
    end
end

while true
    cur = getsnapshot(obj);
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
        switch label
            case 1
                txt='anger';
            case 2
                txt='contempt';
            case 3
                txt='disgust';
            case 4
                txt = 'fear';
            case 5
                txt= 'happy';
            case 6
                txt = 'sadness';
            case 7
                txt = 'surprise';
        end
        disp(txt);
        %label = 'Face';
        img = insertObjectAnnotation(cur, 'rectangle', face_box, txt);
    end
    
    imshow(img);
end
