% load('facesCell.mat');
% generate_data;


t1 = randperm(276,40);
t2 = 1:276;
test_data = good_data(t1',:);
test_labels = good_labels(t1',:);
train_labels = good_labels(setdiff(t2,t1)');
train_data = good_data(setdiff(t2,t1)',:);
models = trainClassifier(train_data,train_labels);
pred_labels = classify(test_data,models,7);
sum(pred_labels ~= test_labels)