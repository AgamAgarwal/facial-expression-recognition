load('facesCell.mat');
generate_data;

s = RandStream('mt19937ar','Seed',0);
t1 = randperm(s,75,37);
t2 = 1:75;
test_data = data(t1',:);
test_labels = labels(t1',:);
train_labels = labels(setdiff(t2,t1)');
train_data = data(setdiff(t2,t1)',:);
models = trainClassifier(train_data,train_labels);
pred_labels = classify(test_data,models,5);
sum(pred_labels ~= test_labels)