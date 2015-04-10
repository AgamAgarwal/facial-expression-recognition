% Labels
% 1=anger
% 2=contempt
% 3=disgust
% 4=fear
% 5=happy
% 6=sadness
% 7=surprise

load('cohn-kanade-faces.mat');
train_size=size(Final_images, 1);
data = zeros(train_size,64);
j = [];

for i=1:train_size
    disp(i)
    [points, face1,status] = goodPoints(OG_images{i,1});
    if (status ==0)
        j = [j; i];
        continue;
    else
        i2 = Final_images{i,1};
        face_box = ViolaAndJones(i2,false);
        if (size(face_box,1) == 0)
            disp('No face for image2');
            j = [j; i];
            continue;
        else
            face_box = face_box(1,:);
            face2 = i2(face_box(2):face_box(2)+face_box(4), face_box(1):face_box(1)+face_box(3),:);
            [x,y,angle,v] = extractFeatures(face1, face2, points,48,24);
            data(i,:) = [x;y;angle;v]';
            if sum(isnan(data(i,:))) ~= 0
                disp(i);
            end
        end
    end
end
idx = setdiff(1:327,j)';
good_data = data(idx,:);
good_labels = labels(idx,:);
