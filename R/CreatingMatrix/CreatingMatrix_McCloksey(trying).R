
paper<- "McCloskey2018"
data <- read_csv(file.path(getwd(), "data-in", paste0(paper, ".csv")))   
species <- "Ecoli_K12"
selective_pressure<- c("pgi", "tpiA", "gnd", "sdhCB", "ptsHIcrr", "eco")

pgi<- data %>% filter(str_detect(Population, "Evo04pgi"))
tpiA<- data %>% filter(str_detect(Population,"Evo04tpiA"))
gnd<- data %>% filter(str_detect(Population,"Evo04gnd"))
sdhCB<- data %>% filter(str_detect(Population,"Evo04sdhCB"))
ptsHIcrr<- data %>% filter(str_detect(Population,"Evo04ptsHIcrr"))
evo<-data %>% filter(str_detect(Population,"Evo04Evo"))


multipressure_c_hyper <- function(paper, environment, species, selective_pressure, numGenes = NA){
library(stringr)
library(tidyverse)
library(readr)
library(devtools)
library(dgconstraint)
library(Hmisc)

geneNumbers <- read_csv(file.path(getwd(),"data-in/GeneDatabase.csv"))


if (species %in% geneNumbers$Species){
  numGenes <- filter(geneNumbers, Species == species)$NumGenes  
}

if(is.na(numGenes)){
  prompt <- "Your species is unspecified or not in our database. How many genes does it have? \n"
  numGenes <- as.numeric(readline(prompt))
}
  
numLineages <- c()
num_parallel_genes <- c()
num_non_parallel_genes <- c()
parallel_genes <- c()
c_hyper <- c()
p_chisq <- c()
estimate <- c()

data.1 <- data %>% 
  arrange(Gene) %>%
  drop_na(Gene) %>%
  drop_na(Population)%>% 
  select(Population, Gene, frequency)  
  

for(j in selective_pressure) {
  print(j)
  data.j <- data.1 %>% 
    filter(Population == j)
  
  num_genes <- length((unique(data.j$Gene)))
  num_lineages <- length(unique(data.j$Population))
  data.array <- array(0, dim =c(num_genes, num_lineages), dimnames = list(unique(data.j$Gene), unique(data.j$Population)))
  
  for(i in 1:num_lineages) {
    sub <- subset(data.j, data.j$Population == unique(data.j$Population)[i])
    sub2 <- subset(sub, frequency > 0)
    geneRows <- which(row.names(data.array) %in% sub2$Gene)
    data.array[geneRows, i] <- 1
    num_parallel <- data.frame(data.array, Count=rowSums(data.array, na.rm = FALSE, dims = 1), Genes = row.names(data.array))
  }
  
  genes_parallel <- num_parallel %>% 
    as_tibble() %>% 
    filter(Count > 1)
  num_parallel_genes_j <- nrow(genes_parallel)
  
  Non_genes_parallel <- num_parallel %>% 
    as_tibble() %>% 
    filter(Count == 1)
  num_non_parallel_genes_j <- nrow(Non_genes_parallel)
  total_genes <- num_non_parallel_genes_j + num_parallel_genes_j
  
  num_parallel_genes <- append(num_parallel_genes, num_parallel_genes_j)
  num_non_parallel_genes <- append(num_non_parallel_genes, num_non_parallel_genes_j)
  parallel_genes <- append(parallel_genes, paste0(genes_parallel$Genes, collapse=", ")) 
  
  
  full_matrix <- rbind(data.array, array(0,c(numGenes-total_genes,ncol(data.array))))
  
  newdir <- file.path(getwd(), "data-out")
  if (!file.exists(newdir)){
    dir.create(newdir, showWarnings = FALSE)
    cat(paste("\n\tCreating new directory: ", newdir), sep="")
  }
  
  filename1 <- file.path(getwd(), "data-out", paste0("/", paper, "_", j, ".csv"))
  write.csv(data.j, file=filename1, row.names=FALSE)
  
  c_hyper <- append(c_hyper, pairwise_c_hyper(full_matrix))
  p_chisq <- append(p_chisq, allwise_p_chisq(full_matrix, num_permute = 200))
  estimate <- append(estimate, estimate_pa(full_matrix,ndigits = 4, show.plot = T))
  
  c_hyper[c_hyper <= 0] <- 0
  c_hyper[c_hyper == "NaN"] <- 0
}
  df <- tibble( paper = paper, environment = selective_pressure, c_hyper = round(c_hyper, 3), p_chisq, estimate = round(estimate, 3) ,N_genes.notParallel= num_non_parallel_genes, N_genes.parallel=num_parallel_genes, parallel_genes)
  
  filename2 <- file.path(getwd(), "data-out", paste(paper, "_Analysis.csv", sep=""))
  write.csv(df, file=filename2, row.names=FALSE)
  }
  