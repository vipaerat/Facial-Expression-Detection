close all;
clear all;
clc;

% load('jaffe.mat');
load('cohnkanade.mat');

[N,M] = size(trainX);

rng(2);

% number of epochs for training
nEpochs = 100;

% number of hidden layer units
H = 16;

% learning rate
eta = 0.01;

% training the MLP using the generated sample dataset
[w, v, trainerror] = mlptrain(trainX,trainY, H, eta, nEpochs);

% plot the train error againt the number of epochs
figure;
plot(real(1:nEpochs), real(trainerror),'LineWidth', 1);
xlabel('Epochs'),ylabel('TrainError');

checkacc(trainX,trainY,w,v,0);
checkacc(testX,testY,w,v,1);

% save('jaffeparam.mat','w','v','H','nEpochs');
save('cohnparam.mat','w','v','H','nEpochs');
clear all;
