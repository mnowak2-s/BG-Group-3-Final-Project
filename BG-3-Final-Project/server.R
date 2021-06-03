library(shiny)
library(tidyverse)

source("Dataframes.R")

shinyServer(function(input, output) {
    
    ## Data for the histogram, need to figure out how to put widget data into this
    Sym_of_or_df <- dataframe %>% 
        filter(Group == "By State", Indicator == "Symptoms of Anxiety Disorder or Depressive Disorder", Phase != "-1") %>% 
        group_by(State) %>% 
        arrange(State, Phase) %>% 
        mutate(Diff_percent = Value - lag(Value), 
               Diff_time = Time.Period - lag(Time.Period),
               Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
               Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
  
    Sym_of_anx_df <- dataframe %>% 
        filter(Group == "By State", Indicator == "Symptoms of Anxiety Disorder") %>% 
        group_by(State) %>% 
        arrange(State, Phase) %>% 
        mutate(Diff_percent = Value - lag(Value), 
               Diff_time = Time.Period - lag(Time.Period),
               Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
               Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
    
    Sym_of_dep_df <- dataframe %>% 
        filter(Group == "By State", Indicator == "Symptoms of Depressive Disorder") %>% 
        group_by(State) %>% 
        arrange(State, Phase) %>% 
        mutate(Diff_percent = Value - lag(Value), 
               Diff_time = Time.Period - lag(Time.Period),
               Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
               Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
    
    # Plot outputs
    Sym_of_or_df <- Sym_of_or_df%>% group_by(State, Phase)%>% mutate(avg = mean(Value))
    output$plot_or <- renderPlot({
        small_or_df <- Sym_of_or_df%>% select(State, avg)%>%filter(Phase == input$orPhase)%>%group_by(State)%>%distinct()
        ggplot(data = small_or_df) + 
            geom_bar(mapping = aes(x = State, y = avg), stat = "identity",  show.legend = TRUE)+
            labs(y = "% of Respondees With Some Level of Anxiety or Depression") +
          theme(axis.text.x=element_text(angle = 45))
    })
    
    Sym_of_anx_df <- Sym_of_anx_df%>% group_by(State, Phase)%>% mutate(avg = mean(Value))
    output$plot_anx <- renderPlot({
        small_anx_df <- Sym_of_anx_df%>% select(State, avg)%>%filter(Phase == input$anxPhase)%>%group_by(State)%>%distinct()
        ggplot(data = small_anx_df) + 
            geom_bar(mapping = aes(x = State, y = avg), stat = "identity",  show.legend = TRUE) +
          labs(y = "% of Respondees With Some Level of Anxiety") +
          theme(axis.text.x=element_text(angle = 45))
    })
    
    Sym_of_dep_df <- Sym_of_dep_df%>% group_by(State, Phase)%>% mutate(avg = mean(Value))
    output$plot_dep <- renderPlot({
        small_dep_df <- Sym_of_dep_df%>% select(State, avg)%>%filter(Phase == input$depPhase)%>%group_by(State)%>%distinct()
        ggplot(data = small_dep_df) + 
            geom_bar(mapping = aes(x = State, y = avg), stat = "identity", show.legend = TRUE)+
          labs(y = "% of Respondees With Some Level of Depression") +
          theme(axis.text.x=element_text(angle = 45))
    })
    
    or_by_average <- reactive({
      Sym_of_dep_df <- Sym_of_dep_df %>% 
        filter(Phase == input$orPhase) %>% 
        select(State, Value) %>% 
        arrange(desc(Value))
    })
    output$or_printing <- renderText({
      paste0("The average percentage of respondants with some level of anxiety or depression across the country is ",
             round(mean(or_by_average()$Value),2), "%. The top 5 states are:")
    })

})