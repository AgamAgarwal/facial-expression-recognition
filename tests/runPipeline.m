% load('facesCell.mat');
% generate_data;

m = size(good_data,1);
t1 = randperm(m,40);
t2 = 1:m;
test_data = good_data(t1',:);
test_labels = good_labels(t1',:);
train_labels = good_labels(setdiff(t2,t1)');
train_data = good_data(setdiff(t2,t1)',:);
models = trainClassifier(train_data,train_labels);
pred_labels = classify(test_data,models,7);
100*sum(pred_labels == test_labels)/size(test_labels,1)

pred_labels = classify(train_data,models,7);
sum(pred_labels ~= train_labels)