library(here)
library(dgconstraint)
library(tidyverse)
library(R.utils)
sourceDirectory(here("R", "functions"))
source("dgconstraint/functions/multiple_wide.R")
source("dgconstraint/functions/multiple_long.R")

############################
#multiple generations
############################
#function(paper, generations, environment, species = NA)

### Tenaillon2016
# This paper originally had two clones sequenced for each timepoint. Collapse the two columns and save the resulting dataset.


#####working##################################################
Tenaillon2016 <- read_csv(here("data_in", "raw", "Tenaillon2016_original.csv"))
Tenaillon2016<- Tenaillon2016 %>%
  replace(is.na(.), 0) %>% 
  filter(Details != "intergenic") %>%
  transmute(gene = Tenaillon2016$Gene, population = Tenaillon2016$Population, "g500" = `g500 I1 R1`+ `g500 I2 R1`, "g1000" = `g1000 I1 R1`+ `g1000 I2 R1`, "g1500" = `g1500 I1 R1`+ `g1500 I2 R1`, "g2000" =  `g2000 I1 R1` + `g2000 I2 R1`, "g5000" = `g5000 I1 R1`+ `g5000 I2 R1`, "g10000" = `g10000 I1 R1`+ `g10000 I2 R1`, "g15000" = `g15000 I1 R1`+ `g15000 I2 R1`, "g20000" = `g20000 I1 R1`+`g20000 I2 R1`, "g30000" = `g30000 I1 R1`+`g30000 I2 R1`, "g40000" = `g40000 I1 R1`+`g40000 I2 R1`, "g50000" = `g50000 I1 R1`+`g50000 I2 R1`)
write_csv(Tenaillon2016, "data-in/Tenaillon2016.csv")
  
Tenaillon2016 <- read_csv(here("data_in", "raw", "Tenaillon2016_raw.csv"))
Tenaillon2016 <- Tenaillon2016 %>% 
  replace(is.na(.), 0) %>% 
  filter(Details != "intergenic") %>% 
  transmute(gene = Tenaillon2016$Gene, population = Tenaillon2016$Population, g500 = `500 I1 R1`+`500 I2 R1`, g1000 = `1000 I1 R1`+`1000 I2 R1`, g1500 =`1500 I1 R1`+`1500 I2 R1`, g2000 = `2000 I1 R1`+`2000 I2 R1`, g5000 = `5000 I1 R1`+`5000 I2 R1`, g10000 = `10000 I1 R1`+`10000 I2 R1`, g15000 = `15000 I1 R1`+`15000 I2 R1`, g20000 = `20000 I1 R1`+`20000 I2 R1`, g30000 = `30000 I1 R1`+`30000 I2 R1`, g40000 = `40000 I1 R1`+`40000 I2 R1`, g50000 = `50000 I1 R1`+`50000 I2 R1`) 
write_csv(Tenaillon2016, "data-in/Tenaillon2016.csv")

library(janitor)
Tenaillon2016 <- read_csv(here("data_in", "raw", "Tenaillon2016_raw.csv"))
Tenaillon2016<-clean_names(Tenaillon2016)
Tenaillon2016 <- Tenaillon2016 %>% 
  replace(is.na(.), 0) %>% 
  filter(details != "intergenic") %>% 
  transmute(gene = gene, population = population, "g500" = `x500_i1_r1`+`x500_i2_r1`, "g1000" =`x1000_i1_r1`+`x1000_i2_r1`, "g1500" =`x1500_i1_r1`+`x1500_i2_r1`,  "g2000"= `x2000_i1_r1`+`x2000_i2_r1`, "g5000"=`x5000_i1_r1`+`x5000_i2_r1`, "g10000"= `x10000_i1_r1`+`x10000_i2_r1`, "g15000"=`x15000_i1_r1`+`x15000_i2_r1`,"g20000"=`x20000_i1_r1`+`x20000_i2_r1`,"g30000"= `x30000_i1_r1`+`x30000_i2_r1`,"g40000"=`x40000_i1_r1`+`x40000_i2_r1`,"g50000"=`x50000_i1_r1`+`x50000_i2_r1`)

write_csv(Tenaillon2016, "data_in/Tenaillon2016.csv")
###################################################

#THIS ISN'T WORKING
Tenaillon2016 <- Tenaillon2016 %>% 
  rename(gene = Gene, population = Population) %>% 
  replace(is.na(.), 0) %>% 
  transmute(gene = gene, population = population, details = Tenaillon2016$Details, "g500" = "g500 I1 R1"+ "g500 I2 R1", "g1000" = "g1000 I1 R1"+ "g1000 I2 R2", "g1500" = "g1500 I1 R1"+ "g1500 I2 R1", "g2000" =  "g2000 I1 R1" + "g2000 I2 R1")

Tenaillon2016 <- Tenaillon2016 %>% 
  remove_empty("rows") %>% 
  transmute(gene = Tenaillon2016$gene, population = Tenaillon2016$population, details = Tenaillon2016$Details, "g500" = "g500 I1 R1"+ "g500 I2 R1", "g1000" = "g1000 I1 R1"+ "g1000 I2 R2", "g1500" = "g1500 I1 R1"+ "g1500 I2 R1", "g2000" =  "g2000 I1 R1" + "g2000 I2 R1", "g5000" = "g5000 I1 R1"+ "g5000 I2 R1", "g10000" = "g10000 I1 R1"+ "g10000 I2 R1", "g15000" = "g15000 I1 R1"+ "g15000 I2 R1", "g20000" = "g20000 I1 R1"+"g20000 I2 R1", "g30000" = "g30000 I1 R1"+"g30000 I2 R1", "g40000" = "g40000 I1 R1"+"g40000 I2 R1", "g50000" = "g50000 I1 R1"+"g50000 I2 R1") %>% 
  replace(is.na(.), 0) %>% 
  filter(Details != "intergenic")


Tenaillon2016 <- read_csv(here("data-in", "Tenaillon2016.csv"))
Tenaillon2016 <- Tenaillon2016 %>% 
  transmute(Gene = Tenaillon2016$Gene, Population = Tenaillon2016$Population, Details = Tenaillon2016$Details, `500` = `500 I1 R1`+`500 I2 R1`, `1000` = `1000 I1 R1`+`1000 I2 R1`, `1500` =`1500 I1 R1`+`1500 I2 R1`, `2000` = `2000 I1 R1`+`2000 I2 R1`, `5000` = `5000 I1 R1`+`5000 I2 R1`, `10000` = `10000 I1 R1`+`10000 I2 R1`, `15000` = `15000 I1 R1`+`15000 I2 R1`, `20000` = `20000 I1 R1`+`20000 I2 R1`, `30000` = `30000 I1 R1`+`30000 I2 R1`, `40000` = `40000 I1 R1`+`40000 I2 R1`, `50000` = `50000 I1 R1`+`50000 I2 R1`) %>% replace(is.na(.), 0) 
write_csv(Tenaillon2016, "data-in/Tenaillon2016.csv")


multiple_wide("Tenaillon2016", c("g500", 'g1000', 'g1500', 'g2000', 'g5000', 'g10000', 'g20000', 'g30000', 'g40000','g50000'), "David minimal medium", "Ecoli_K12",)

### Lang2014
#filter out intergenics before running the code

Lang2014 <-read_csv(here("data_in", "raw", "Lang2014_raw.csv"))

Lang2014 <-read_csv(here("data-in", "Lang2014.csv"))

Lang2014 <- Lang2014 %>%
  filter(Gene != "Intergenic") %>% 
  rename(gene = Gene, population = Population)

write_csv(Lang2014, here("data_in", "Lang2014.csv"))

multigen_c_hyper("Lang2014",c("0","140","240","335",'415','505','585','665','745','825','910','1000'),"YPD", "Sac")

### Sherlock2013
multigen_c_hyper("Sherlock2013" ,c("7","70", "133","196","266", "322","385","448"), "YPD","Sac")

### Sherlock2013
multigen_c_hyper("Sherlock2019",c("0","50","100","150","200" ,"250","300","350","400","450","500"),"Davids minimal medium" ,"Ecoli_K12")

### Kacar2017
#filter out intergenics
Kacar2017 <-read_csv(here("data_in", "Kacar2017.csv"))
Kacar2017 <- Kacar2017 %>% 
            filter(`Nature of the change` != "Intergenic")

multiple_wide("Kacar2017", c("500", "1000", "1500", "2000"),"Minimal glucose medium","Ecoli_K12")

###Tonoyan_2019
#filter out intergenics

Tonoyan2019 <-read_csv(here("data_in", "raw", "Tonoyan2019_raw.csv"))

Tonoyan2019 <-read_csv(here("data-in", "Tonoyan2019.csv"))

Tonoyan2019 <-Tonoyan2019  %>% 
              filter(Gene != "Intergenic")
write_csv(Tonoyan2019, here("data_in", "Tonoyan2019.csv"))

multigen_c_hyper("Tonoyan_2019",c("1", "14", "20"), "LB medium","Ecoli_ATCC")

### Wielgoss2016-mucoid
#filter out intergenics

Wielgoss2016_mucoid <-read_csv(here("data_in", "raw",  "Wielgoss2016-mucoid_raw.csv"))
Wielgoss2016_mucoid<- Wielgoss2016_mucoid %>% 
                filter(Gene != "Intergenic")
write_csv(Wielgoss2016_mucoid, here("data_in", "Wielgoss2016_mucoid.csv"))

multiple_wide("Wielgoss2016_mucoid",c("0", "10"), "lysogeny broth", "Ecoli_K12")

### Wielgoss2016-nonMucoid
#filter out intergenics
Wielgoss2016_nonMucoid <-read_csv(here("data_in", "raw", "Wielgoss2016-nonMucoid_raw.csv"))
Wielgoss2016_nonMucoid<- Wielgoss2016_nonMucoid%>% 

Wielgoss2016-mucoid <-read_csv(here("data-in", "Wielgoss2016-mucoid.csv"))
Wielgoss2016-mucoid<- Wielgoss2016-mucoid%>% 
                filter(Gene != "Intergenic")
write_csv(Wielgoss2016_nonMucoid, here("data_in", "Wielgoss2016_nonMucoid.csv"))
### Sandberg2016
multiple_wide("Sandberg2016", c("Flask 23", "Flask 58", "Flask 133"), "Davids minimal medium", "Ecoli_K12")


#####################################
# multiple selective pressures
####################################
#multiple_long <- function(paper, selective_pressure, environment, species  = NA)
### Hong2014
## filter out unwanted mutations

Hong2014 <-read_csv(here("data_in", "raw", "Hong2014_raw.csv"))

Hong2014 <-read_csv(here("data-in", "Hong2014.csv"))

Hong2014 <-Hong2014 %>% 
  filter( type != 'DIP', type !='WCA', type != 'IND', type != 'AMP')
write_csv(Hong2014, here("data_in", "Hong2014.csv"))

multiple_long("Hong2014", c("Ammonium", "Arginine", "Urea", "Allantoin"), c("Ammonium", "Arginine", "Urea", "Allantoin"),"Sac")

### Jersion2017
#for this data set there were multiple different ways to run an analysis and so each of the following code chunks will results in a different anlysis.
#interested only in the populations or clones in "OT"
Jerison2017 <- read_csv(here("data-in", "Jerison2017.csv"))
Jerison2017<-Jerison2017 %>% 
  filter(Gene != "Intergenic") %>% 
  filter(selective_pressure == "OT")
Founder <- unique(data$Founder)

#interested only in the populations or clones in "OT"
Jerison2017 <- read_csv(here("data-in", "Jerison2017.csv"))
Jerison2017<-Jerison2017 %>% 
  filter(Gene != "Intergenic") %>% 
  filter(selective_pressure == "HT")
Founder <- unique(data$Founder)

#interested in the difference in c-hyper between the two selectve pressures.
Jerison2017 <- read_csv(here("data-in", "Jerison2017.csv"))
Jerison2017<-Jerison2017 %>% 
  filter(Gene != "Intergenic")
Founder <- unique(data$Founder)

multiple_long("Jersion2017",c("OT", "HT"),c("OT", "HT"),"Sac")

### Payen2016
#There are a few ways to run this analysis
#filter out the clones and analyze between the selective pressure whether the ploidy
Payen2016 <- read_csv(here("data-in", "Payen2016.csv"))
Payen2016 <- Payen2016 %>% 
            filter(frequency != "clone")%>% 
            drop_na(frequency) 

#analyze between the selective pressures for only the diploid genes
Payen2016 <- read_csv(here("data-in", "Payen2016.csv"))
Payen2016 <- Payen2016 %>% 
              filter(Ploidy == "diploid") %>% 
            filter(frequency != "clone")%>% 
            drop_na(frequency) 

#analyze between the selective pressures for only the haploid genes 
Payen2016 <- read_csv(here("data-in", "Payen2016.csv"))
Payen2016 <- Payen2016 %>% 
            filter(Ploidy == "diploid") %>% 
            filter(frequency != "clone")%>% 
            drop_na(frequency) 

multiple_long("Payen2016",c("phosphate", "sulfate", "glucose"), c("phosphate", "sulfate", "glucose"),"Sac")

##############################
# Single Generation Matrix
#############################
#function(paper, environment, population, species = NA, collapseMutations = TRUE)
### Wannier2018
# This paper originally had two clones sequenced for each population. Collapse the two columns and save the resulting dataset. And filter out the intergenic
Wannier2018 <- read_csv(here("data_in/raw", "Wannier2018_raw.csv"))
Wannier2018<- Wannier2018 %>% transmute(Gene = Wannier2018$Gene, Details= Wannier2018$Details, A1= `A1 F1 I1 R1`+ `A1 F1 I2 R1`, A2 = `A2 F1 I1 R1`+ `A2 F1 I2 R1`, A3 = `A3 F1 I1 R1`+ `A3 F1 I2 R1`, A4 = `A4 F1 I1 R1`+ `A4 F1 I2 R1`, A5 = `A5 F1 I1 R1`+ `A5 F1 I2 R1`, A6 = `A6 F1 I1 R1`+ `A6 F1 I2 R1`, A7 = `A7 F1 I1 R1`+ `A7 F1 I2 R1`, A8 = `A8 F1 I1 R1`+ `A8 F1 I2 R1`, A9 = `A9 F1 I1 R1`+ `A9 F1 I2 R1`, A10 = `A10 F1 I1 R1`+ `A10 F1 I2 R1`,A11 = `A1 F1 I1 R1`+ `A11 F1 I2 R1`, A12 = `A12 F1 I1 R1`+ `A12 F1 I2 R1`, A13 = `A13 F1 I1 R1`+ `A13 F1 I2 R1`, A14 = `A14 F1 I1 R1`+ `A14 F1 I2 R1`) %>% replace(is.na(.), 0) 
population <- c("A1" , "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14")
Wannier2018 <-Wannier2018 %>% filter(Details != "intergenic") 
Wannier2018.1<-Wannier2018 %>% select(population)
Wannier2018.matrix<- as.matrix(Wannier2018.1)
Wannier2018.matrix[Wannier2018.matrix > 0] <-1
Wannier201<- cbind(as.data.frame(Wannier2018.matrix), Wannier2018$Gene)

            
singlematrix_c_hyper("Wannier2018","Glucose Mininal Medium", c("A1" , "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14"),"Ecoli_K12")

### Long2017
singlematrix_c_hyper("Long2017", "Glucose minimal media", c("ALE1", "ALE2", "ALE3", "ALE4", "ALE5", "ALE6", "ALE7", "ALE8", "ALE9", "ALE10"),"Ecoli_K12")

### Sandberg2014
singlematrix_c_hyper("Sandberg2014","Glucose minimal media",c("ALE1", "ALE2", "ALE3", "ALE4", "ALE5", "ALE6", "ALE7", "ALE8", "ALE9", "ALE10"),"Ecoli_K12")

### Creamer2016
#filter out the intergenics
Creamer2016 <-read_csv(here("data-in", "Creamer2016.csv"))
Creamer2016 <-Creamer2016 %>% 
              filter(Annotation!= "intergenic")

singlematrix_c_hyper( "Creamer2016","LBK medium",c("K0001","K0011","K0002","K0003","K0014","K0015","KB026","K0022","K0023","K0006","K0007","K0010", "K0020","K0019","K0031","K0030"),"Ecoli_K12")

################################
#Single Generation NonMatrix
################################
#function(paper, environment, species = NA)

### Deatherage2017
#This paper originally had three clones sequenced for each population. Collapse the three columns and save the resulting dataset. And filter out the intergenic
data<- data %>% transmute(Gene = data$Gene, Details = data$Details, Population = data$Population, frequency= `F1 I1 R1` +`F1 I2 R1`+`F1 I3 R1`) %>% 
  filter(Details != "intergenic") %>%
  replace(is.na(.), 0)

singlegen_c_hyper("Deatherage2017", "glucose minimal medium", "Ecoli_K12")

### McCloskey2018
#trying to find a better way with a single function to do all of the following functions
#for gnd, filter out everything thats not gnd
data<- data %>% 
  filter(Population!="Evo04pgiEvo02EP",Population!="Evo04Evo01EP",Population!="Evo04Evo02EP",Population!="Evo04pgiEvo01EP",Population!="Evo04pgiEvo03EP",Population!="Evo04pgiEvo04EP",Population!="Evo04pgiEvo05EP",Population!="Evo04pgiEvo06EP",Population!="Evo04pgiEvo07EP",Population!="Evo04pgiEvo08EP",Population!="Evo04ptsHIcrrEvo01EP",Population!="Evo04ptsHIcrrEvo02EP",Population!="Evo04ptsHIcrrEvo03EP", Population!="Evo04ptsHIcrrEvo04EP",Population!= "Evo04sdhCBEvo02EP",Population!="Evo04sdhCBEvo03EP",Population!="Evo04tpiAEvo01EP",Population!="Evo04tpiAEvo02EP",Population!="Evo04tpiAEvo04EP",Population!="Evo04tpiAEvo03EP",Population!="Evo04sdhCBEvo01EP")

singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

#for pgi, filter out everything thats not pgi
data<-data %>% 
  filter(Population!="Evo04Evo01EP",Population!="Evo04Evo02EP",Population!="Evo04gndEvo01EP",Population!="Evo04gndEvo02EP",Population!="Evo04gndEvo03EP",Population!="Evo04ptsHIcrrEvo01EP",Population!="Evo04ptsHIcrrEvo02EP",Population!="Evo04ptsHIcrrEvo03EP", Population!="Evo04ptsHIcrrEvo04EP",Population!= "Evo04sdhCBEvo02EP",Population!="Evo04sdhCBEvo03EP",Population!="Evo04tpiAEvo01EP",Population!="Evo04tpiAEvo02EP",Population!="Evo04tpiAEvo04EP",Population!="Evo04tpiAEvo03EP",Population!="Evo04sdhCBEvo01EP")

singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

#for ptsHIcrr, filter out everything thats not ptsHIcrr
data<-data %>% 
  filter(Population!="Evo04pgiEvo02EP",Population!="Evo04Evo01EP",Population!="Evo04Evo02EP",Population!="Evo04gndEvo01EP",Population!="Evo04gndEvo02EP",Population!="Evo04gndEvo03EP",Population!="Evo04pgiEvo01EP",Population!="Evo04pgiEvo03EP",Population!="Evo04pgiEvo04EP",Population!="Evo04pgiEvo05EP",Population!="Evo04pgiEvo06EP",Population!="Evo04pgiEvo07EP",Population!="Evo04pgiEvo08EP",Population!= "Evo04sdhCBEvo02EP",Population!="Evo04sdhCBEvo03EP",Population!="Evo04tpiAEvo01EP",Population!="Evo04tpiAEvo02EP",Population!="Evo04tpiAEvo04EP",Population!="Evo04tpiAEvo03EP",Population!="Evo04sdhCBEvo01EP")

singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

#for sdhCBE, filter out everything thats not sdhCBE
data<-data %>% 
  filter(Population!="Evo04pgiEvo02EP",Population!="Evo04Evo01EP",Population!="Evo04Evo02EP",Population!="Evo04gndEvo01EP",Population!="Evo04gndEvo02EP",Population!="Evo04gndEvo03EP",Population!="Evo04pgiEvo01EP",Population!="Evo04pgiEvo03EP",Population!="Evo04pgiEvo04EP",Population!="Evo04pgiEvo05EP",Population!="Evo04pgiEvo06EP",Population!="Evo04pgiEvo07EP",Population!="Evo04pgiEvo08EP",Population!="Evo04ptsHIcrrEvo01EP",Population!="Evo04ptsHIcrrEvo02EP",Population!="Evo04ptsHIcrrEvo03EP", Population!="Evo04ptsHIcrrEvo04EP",Population!="Evo04tpiAEvo01EP",Population!="Evo04tpiAEvo02EP",Population!="Evo04tpiAEvo04EP",Population!="Evo04tpiAEvo03EP")

singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

#for tpiAE, filter out everything thats not tpiAE
data<-data %>% 
  filter(Population!="Evo04pgiEvo02EP",Population!="Evo04Evo01EP",Population!="Evo04Evo02EP",Population!="Evo04gndEvo01EP",Population!="Evo04gndEvo02EP",Population!="Evo04gndEvo03EP",Population!="Evo04pgiEvo01EP",Population!="Evo04pgiEvo03EP",Population!="Evo04pgiEvo04EP",Population!="Evo04pgiEvo05EP",Population!="Evo04pgiEvo06EP",Population!="Evo04pgiEvo07EP",Population!="Evo04pgiEvo08EP",Population!="Evo04ptsHIcrrEvo01EP",Population!="Evo04ptsHIcrrEvo02EP",Population!="Evo04ptsHIcrrEvo03EP", Population!="Evo04ptsHIcrrEvo04EP",Population!= "Evo04sdhCBEvo02EP",Population!="Evo04sdhCBEvo03EP",Population!="Evo04sdhCBEvo01EP")

singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

#for the reference(evo), filter out everything thats not evo
data<-data %>% 
  filter(Population!="Evo04pgiEvo02EP",Population!="Evo04gndEvo01EP",Population!="Evo04gndEvo02EP",Population!="Evo04gndEvo03EP",Population!="Evo04pgiEvo01EP",Population!="Evo04pgiEvo03EP",Population!="Evo04pgiEvo04EP",Population!="Evo04pgiEvo05EP",Population!="Evo04pgiEvo06EP",Population!="Evo04pgiEvo07EP",Population!="Evo04pgiEvo08EP",Population!="Evo04ptsHIcrrEvo01EP",Population!="Evo04ptsHIcrrEvo02EP",Population!="Evo04ptsHIcrrEvo03EP", Population!="Evo04ptsHIcrrEvo04EP",Population!= "Evo04sdhCBEvo02EP",Population!="Evo04sdhCBEvo03EP",Population!="Evo04tpiAEvo01EP",Population!="Evo04tpiAEvo02EP",Population!="Evo04tpiAEvo04EP",Population!="Evo04tpiAEvo03EP",Population!="Evo04sdhCBEvo01EP")

singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

#or just run as one function,each being an individiual population
singlegen_c_hyper("McCloskey2018", "M9 minimal medium", "Ecoli_K12")

### ADD HERRON 2013
