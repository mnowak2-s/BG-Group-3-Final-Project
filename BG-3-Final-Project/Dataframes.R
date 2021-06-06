library(dplyr)

dataframe <- read.csv("Anxiety_Depression_rates_Covid_19.csv")

nrow(dataframe) # number of rows 
ncol(dataframe)
names(dataframe) # variable names

unique(dataframe[c("Indicator")])

Sym_of_anx_df <- dataframe %>% 
  filter(Group == "By State", Indicator == "Symptoms of Anxiety Disorder", Phase >= 0) %>% 
  group_by(State) %>% 
  arrange(State, Phase) %>% 
  mutate(Diff_percent = Value - lag(Value), 
         Diff_time = Time.Period - lag(Time.Period),
         Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
         Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
  


Sym_of_dep_df <- dataframe %>% 
  filter(Group == "By State", Indicator == "Symptoms of Depressive Disorder", Phase >= 0) %>% 
  group_by(State) %>% 
  arrange(State, Phase) %>% 
  mutate(Diff_percent = Value - lag(Value), 
         Diff_time = Time.Period - lag(Time.Period),
         Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
         Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))


Sym_of_or_df <- dataframe %>% 
  filter(Group == "By State", Indicator == "Symptoms of Anxiety Disorder or Depressive Disorder", Phase >= 0) %>% 
  group_by(State) %>% 
  arrange(State, Phase) %>% 
  mutate(Diff_percent = Value - lag(Value), 
         Diff_time = Time.Period - lag(Time.Period),
         Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
         Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
