% Labels
% normal
% happy - 0
% sad - 1
% sleepy - 2
% surprised - 3
% wink - 4
data = zeros(75,64);
labels = repmat(1:5,1,15)';

for i=1:15
    [points, face1] = goodPoints(C{i}(:,:,1));
    for j=2:6
        i2 = C{i}(:,:,j);
        face_box = ViolaAndJones(i2,false);        
        face2 = i2(face_box(2):face_box(2)+face_box(4), face_box(1):face_box(1)+face_box(3),:);
        idx = (i-1)*5 + j - 1;
        [x,y,angle,v] = extractFeatures(face1, face2, points,48,24);       
        data(idx,:) = [x;y;angle;v]';
        if sum(isnan(data(idx,:))) ~= 0
            disp(idx);            
        end
    end
end