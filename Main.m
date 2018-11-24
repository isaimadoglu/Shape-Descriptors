% main

clearvars; clc;

%% Controlling Parameters of the GA Algorithm

obj = @fitnessFunction;

M = 10;   % number of chromosomes (candidate solutions)
N = 6;    % number of genes(variables)
MaxGen = 4;
Pc = 0.85;
Pm = 0.01;
Er = 0.2;

[BestChrom] = GeneticAlgorithm(M, N, MaxGen, Pc, Pm, Er, obj);

disp('*******Best Chromosome******** ');
disp(BestChrom.Gene);

disp('Fitness= ');
disp(BestChrom.fitness);
