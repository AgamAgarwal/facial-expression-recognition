load('facesCell.mat');
load('processed_kanade_data.mat');
% generate_data;

%m = size(good_data,1);
un_label = unique(good_labels);
test_labels =[];
test_data = [];
train_labels = [];
train_data = [];
split_frac = 0.12;
for i= 1:numel(un_label)
    temp_good_data = good_data(good_labels == un_label(i),:);
    [j, k] = size(temp_good_data);
    t1 = randperm(j);
    test_data = [test_data; temp_good_data(1:floor(split_frac*j),:)];
    train_data = [train_data; temp_good_data(floor(split_frac*j)+1:end,:)];
    test_labels = [test_labels; ones(floor(split_frac*j),1)* double(un_label(i))];
    train_labels = [train_labels; ones(j-floor(split_frac*j),1)* double(un_label(i))];
    
end

models = trainClassifier(train_data,train_labels);
pred_labels = classify(test_data,models,7);
100*sum(pred_labels == test_labels)/size(test_labels,1)

pred_labels = classify(train_data,models,7);
sum(pred_labels ~= train_labels)