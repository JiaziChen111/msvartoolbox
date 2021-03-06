%% housekeeping
clear;
clc;
close all
addpath(genpath('../'))

load sim_for_mmu

%% specify the empirical model
N = 2; p = 2; M = 2;
model.N = 2;
model.p = 2;
model.K = model.N*model.p+1;
model.T = length(regimes);

%% specify priors
priors.mmu_mean = zeros(N*M,1);
priors.mmu_cov = 1e5*eye(N*M);
priors.pphi_mean = zeros(N*N*p,1);
priors.pphi_cov = 1e5*eye(N*N*p);
priors.Ssigma_SSR = 0;
priors.Ssigma_nnu = 0;


%% specify options for the Gibbs sampler
options.burnin = 2e4;
options.R = 5e4;
options.pphi_init = zeros(p*N*N,1);
options.mmu_init = zeros(N,1);
options.Ssigma_array_init = zeros(N,N,M);


tic
draws = dummyVAR_Gibbs(y',regimes,model,priors,options);
toc
%% look at result
median(draws.Ssigma_array,4)
mean(draws.pphi,3)
mean(draws.mmu,3)
