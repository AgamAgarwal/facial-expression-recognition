function [ labels ] = classify( TestSet, models,numClasses )
%CLASSIFY Summary of this function goes here
%   Detailed explanation goes here

labels = zeros(size(TestSet,1),1);
for j=1:size(TestSet,1)
    for k=1:numClasses
        if(svmclassify(models(k),TestSet(j,:))) 
            break;
        end
    end
    labels(j) = k;
end

end

