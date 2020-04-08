%% Program to train ANN to create proxy forward modeling
%% Davood Moghadas
%% Brandenburg University of Technology Cottbus-Senftenberg
%% email: moghadas@b-tu.de
%% Ahmad. A. Behroozmand
%% Stanford University
%% email: behroozmand60@gmail.com
%% version: 08.04.2020
%%
clear all; clc;
%% setting
hiddenLayerSize=7;      %%% number of neurons 
trainFcn='trainbr';     %%% Bayesian regularization
rng default             %%% for reproducibility
%% load data
load Tdata
%% get data
fnames=fieldnames(Tdata);
for i=1:length(fnames)
    param=fnames{i};
    eval([param '=Tdata.' param ';'])
end
%% make input output
input=EC;                   %%% 1D electrical conductivity models (S/m)    
output=[ECa_hcp;ECa_perp];  %%% Calculated apparent electrical conductivity models (S/m)    
%% make train, validate and test data
input_tr=input(:,ind_tr);
input_val=input(:,ind_val);
input_te=input(:,ind_te);
%% Create a Fitting Network
net=feedforwardnet(hiddenLayerSize,trainFcn);
net.divideFcn='divideind';       %%% divide the data manually
net.divideParam.trainInd=ind_tr; %%% training data indices 
net.divideParam.valInd=ind_val;  %%% validation data indices 
net.divideParam.testInd=ind_te;  %%% testing data indices
%% Train the Network hcp
net=train(net,input,output);
%% Recalculate Training, Validation and Test Performance
output_tr=sim(net,input_tr);
output_val=sim(net,input_val);
output_te=sim(net,input_te);
%% make out put
ML_output.input=input;
ML_output.output=output;    
ML_output.output_tr=output_tr;
ML_output.output_val=output_val;
ML_output.output_te=output_te;
ML_output.net=net;
%% save output
save ML_output ML_output
