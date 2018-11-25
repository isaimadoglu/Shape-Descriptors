function [ newPopulation, globalBest ]= elitism(population, Er, globalBest)

Elite_no= round(length(population.Chromosomes)*Er);

[max_val, indx]= sort([population.Chromosomes(:).fitness], 'descend');

if max_val(1)>globalBest
    globalBest= max_val(1);
    disp('Global Best Chromosome= ');
    glopopulation.Chromosomes.Gene = population.Chromosomes(indx(1)).Gene;
    disp(glopopulation.Chromosomes.Gene);
    disp('Global Best Fitness= ');
    disp(globalBest);
else
    disp('Global Best Chromosome= ');
    glopopulation.Chromosomes.Gene = population.Chromosomes(indx(1)).Gene;
    disp(glopopulation.Chromosomes.Gene);
    disp('Global Best Fitness= ');
    disp(globalBest);
end

for k=1: Elite_no
    %     disp('Elite Chromosome= ');
    %     disp(population.Chromosomes(indx(k)).Gene);
    
    %     disp('Fitness= ');
    %     disp(population.Chromosomes(indx(k)).fitness);
    
    newPopulation.Chromosomes(k).Gene = population.Chromosomes(indx(k)).Gene;
    newPopulation.Chromosomes(k).fitness  = population.Chromosomes(indx(k)).fitness;
end

for k = Elite_no+1 : length(population.Chromosomes)
    newPopulation.Chromosomes(k).Gene = population.Chromosomes(k).Gene;
    newPopulation.Chromosomes(k).fitness  = population.Chromosomes(k).fitness;
end

end
