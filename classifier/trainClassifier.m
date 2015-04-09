function [ models ] = trainClassifier(TrainingSet,Labels)
%TRAINCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

u=unique(Labels);
numClasses=length(u);

for k=1:numClasses
    %1 is the current class and 0 is all other classes
    G1vAll=(Labels==u(k));
    models(k) = svmtrain(TrainingSet,G1vAll,'kernel_function','rbf');
end

end

