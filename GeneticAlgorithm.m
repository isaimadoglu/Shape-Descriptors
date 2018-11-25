function [BestChrom] = GeneticAlgorithm (M, N, MaxGen, Pc, Pm, Er, obj)


%% Initialization
% Initialize the population
[ population ] = initialization(M, N);
% Calculate the fitness values
for i = 1 : M
    population.Chromosomes(i).fitness=obj(population.Chromosomes(i).Gene(:));
end

[max_val, indx]= sort([population.Chromosomes(:).fitness], 'descend');

disp(['Generation #', num2str(1)]);
globalBest= max_val(1);
disp('Global Best Chromosome= ');
disp(population.Chromosomes(indx(1)).Gene);
disp('Global Best Fitness= ');
disp(globalBest);

%% Main loop
for g = 2 : MaxGen
    disp(['Generation #', num2str(g)]);
    
    for k = 1: 2 : M
        % Selection
        [parent1,parent2] = selection(population);
        
        % Crossover
        crossoverName = 'single';
        [child1, child2] = crossover(parent1, parent2, Pc, crossoverName);
        
        % Mutation
        [child1]= mutation(child1, Pm);
        [child2]= mutation(child2, Pm);
        
        while ((sum(child1.Gene(:))==0) || (sum(child2.Gene(:))==0))
            % Crossover
            crossoverName = 'single';
            [child1, child2] = crossover(parent1, parent2, Pc, crossoverName);
            
            % Mutation
            [child1]= mutation(child1, Pm);
            [child2]= mutation(child2, Pm);
        end
        newPopulation.Chromosomes(k).Gene = child1.Gene;
        newPopulation.Chromosomes(k+1).Gene = child2.Gene;
        
    end  % end of Chromosomes loop
    
    for i = 1 : M
        newPopulation.Chromosomes(i).fitness=obj(population.Chromosomes(i).Gene(:));
    end
    
    % Elitism
    [ newPopulation, globalBest ]= elitism(newPopulation, Er, globalBest);
    
    population = newPopulation;
    
end   % end of Generation loop

for i = 1 : M
    population.Chromosomes(i).fitness=obj(population.Chromosomes(i).Gene(:));
end

[~ , indx]= sort([population.Chromosomes(:).fitness], 'descend');

BestChrom.Gene = population.Chromosomes(indx(1)).Gene;
BestChrom.fitness = population.Chromosomes(indx(1)).fitness;

% if globalBest>BestChrom.fitness
%     disp('Global Best is better than Best Chromosome.');
% end


end
