function [ newPopulation ]= elitism(population, Er)

Elite_no= round(length(population.Chromosomes)*Er);

[max_val, indx]= sort([population.Chromosomes(:).fitness], 'descend');

for k=1: Elite_no
    
    newPopulation.Chromosomes(k).Gene = population.Chromosomes(indx(k)).Gene;
    newPopulation.Chromosomes(k).fitness  = population.Chromosomes(indx(k)).fitness;
end

for k = Elite_no+1 : length(population.Chromosomes)
    newPopulation.Chromosomes(k).Gene = population.Chromosomes(k).Gene;
    newPopulation.Chromosomes(k).fitness  = population.Chromosomes(k).fitness;
end

end