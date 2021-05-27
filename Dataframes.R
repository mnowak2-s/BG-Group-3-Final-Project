library(dplyr)

dataframe <- read.csv('Anxiety_Depression_rates_Covid_19.csv')

nrow(dataframe) # number of rows 
ncol(dataframe)
names(dataframe) # variable names

unique(dataframe[c("Indicator")])

Sym_of_anx_df <- dataframe %>% 
  filter(Indicator == "Symptoms of Anxiety Disorder")


Sym_of_dep_df <- dataframe %>% 
  filter(Indicator == "Symptoms of Depressive Disorder")


Sym_of_or_df <- dataframe %>% 
  filter(Indicator == "Symptoms of Anxiety Disorder or Depressive Disorder")

