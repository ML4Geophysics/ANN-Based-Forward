%% Program to read training models and split data for ANN training
%% written by Davood Moghadas
%% Brandenburg University of Technology Cottbus-Senftenberg
%% email: moghadas@b-tu.de
%% Ahmad. A. Behroozmand
%% email: behroozmand60@gmail.com
%% version: 27.03.2020
%%  
clear all; clc;
%% setting
tr_perc=60;   %%% percentage of training
val_perc=20;  %%% percentage of validation
rng default   %%% for reproducibility
%% load data
load Data
%% get information
ECa_hcp=Data.ECa_hcp;    %%% ECa (HCP mode-S/m)
ECa_perp=Data.ECa_perp;  %%% ECa (PERP mode-S/m)
N=Data.nsample;          %%% number of 1D models
%% index of training, validation and test data              
N_tr=round(N.*tr_perc/100);    %%% number of training data 
NN=N-N_tr;
N_val=round(NN./2);            %%% number of validation data
N_te=N-(N_tr+N_val);           %%% number of test data

ind=1:N;
ind_tr=ind(1:N_tr); ind(1:N_tr)=[];
ind_val=ind(1:N_val); ind(1:N_val)=[];
ind_te=ind;
%% make output
Tdata.EC=Data.RL;
Tdata.ECa_hcp=ECa_hcp;
Tdata.ECa_perp=ECa_perp;
Tdata.N=N;
Tdata.N_tr=N_tr;
Tdata.N_val=N_val;
Tdata.N_te=N_te;
Tdata.ind_tr=ind_tr;
Tdata.ind_val=ind_val;
Tdata.ind_te=ind_te;
%% save data
save Tdata Tdata
