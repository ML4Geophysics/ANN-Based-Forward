%% Program to calculate EMI forward response from ANN-based forward model
%% Davood Moghadas
%% Brandenburg University of Technology Cottbus-Senftenberg
%% email: moghadas@b-tu.de
%% Ahmad. A. Behroozmand
%% Stanford University
%% email: behroozmand60@gmail.com
%% version: 08.04.2020
%%
clear all; clc;
%% load data
load ML_output 
%% calc forward
net=ML_output.net;
sigma=[10,15,20,25,30,35,40,45,50,55,60,65]'*1e-3;
ECa=net(sigma);