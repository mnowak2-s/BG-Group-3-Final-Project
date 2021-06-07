library(shiny)
library(tidyverse)

source("Dataframes.R")

shinyServer(function(input, output) {
    # Plot outputs
    Sym_of_or_df <- Sym_of_or_df %>% 
      group_by(State, Phase) %>% 
      mutate(avg = mean(Value))
    
    output$plot_or <- renderPlot({
        small_or_df <- Sym_of_or_df %>% 
          select(State, avg) %>%
          filter(Phase == input$orPhase) %>%
          group_by(State) %>%
          distinct()
        
        ggplot(data = small_or_df) + 
          geom_bar(mapping = aes(x = reorder(State, avg), y = avg), stat = "identity",  show.legend = TRUE)+
          labs(x = "State", y = "% of Respondees With Some Level of Anxiety or Depression") +
          theme(axis.text.x=element_text(angle = 45))

    })
    
    Sym_of_anx_df <- Sym_of_anx_df %>% 
      group_by(State, Phase) %>% 
      mutate(avg = mean(Value))
    
    output$plot_anx <- renderPlot({
        small_anx_df <- Sym_of_anx_df %>% 
          select(State, avg) %>%
          filter(Phase == input$anxPhase) %>%
          group_by(State) %>%
          distinct()
        
        ggplot(data = small_anx_df) + 
            geom_bar(mapping = aes(x = reorder(State, avg), y = avg), stat = "identity",  show.legend = TRUE) +
          labs(x = "State", y = "% of Respondents With Some Level of Anxiety") +
          theme(axis.text.x=element_text(angle = 45))
    })
    
    Sym_of_dep_df <- Sym_of_dep_df%>% group_by(State, Phase)%>% mutate(avg = mean(Value))
    output$plot_dep <- renderPlot({
        small_dep_df <- Sym_of_dep_df%>% select(State, avg)%>%filter(Phase == input$depPhase)%>%group_by(State)%>%distinct()
        ggplot(data = small_dep_df) + 
            geom_bar(mapping = aes(x = reorder(State, avg), y = avg), stat = "identity", show.legend = TRUE)+
          labs(x = "State", y = "% of Respondees With Some Level of Depression") +
          theme(axis.text.x=element_text(angle = 45))
    })
    
    or_by_average <- reactive({
      Sym_of_or_df <- Sym_of_or_df %>% 
        filter(Phase == input$orPhase) %>% 
        select(State, Value) %>% 
        arrange(desc(Value))
    })
    output$phaseTime_or <- renderText({
      paste0("Phase 1 (Apr 23 - Jul 21, 2020), Phase 2 (Aug 19 - Oct 26, 2020), Phase 3 (Oct 28 - Dec 21, 2020), 
             Phase 3 (Jan 6 - Mar 29, 2021), Phase 3.1 (Apr 14 - Apr 26, 2021)")
    })
    output$or_printing <- renderText({
      paste0("The average percentage of respondants with some level of anxiety or depression across the country is ",
             round(mean(or_by_average()$Value),2), "%. These values are expected to be higher since they are accounting
             for both people experiencing anxiety syptoms and people experiencing depression symptoms.
             Between phases one and two, the rate increases, and as the data goes into the beginning of phase 3, the data
             spikes, probably due to people thinking about the holidays and not being able to spend it with the people 
             they love. It is also the midpoint, meaning the luxuries the pandemic did give have faded and there is uncertanty
             for how much longer it will go on. With the start of a new year, the rates drop slightly as a wave of optimism 
             comes with the potential of a better year. They furthur drop as news of a vaccine appears and regulations start slightly lifting.")
    })
    
    
    anx_by_average <- reactive({
      Sym_of_anx_df <- Sym_of_anx_df %>% 
        filter(Phase == input$anxPhase) %>% 
        select(State, Value) %>% 
        arrange(desc(Value))
    })
    output$phaseTime_anx <- renderText({
      paste0("Phase 1 (Apr 23 - Jul 21, 2020), Phase 2 (Aug 19 - Oct 26, 2020), Phase 3 (Oct 28 - Dec 21, 2020), 
             Phase 3 (Jan 6 - Mar 29, 2021), Phase 3.1 (Apr 14 - Apr 26, 2021)")
    })
    output$anx_printing <- renderText({
      paste0("The average percentage of respondants with some level of anxiety across the country is ",
             round(mean(anx_by_average()$Value),2), "%. The percentage of people with anxiety symptoms is higher overall than 
             the other two categories, with a peak value of 36.18%. During phase 1, it begins at 30.69%, 6% higher than both people
             depressive symptoms or either combined. With all of the uncertainty that erupted with the start of the pandemic, it it
             logical that this value would be larger. It follow the same trend as the prior tab: increasing from phase 1,peaking at
             the Phase 3 starting in January and then declining after that.")
    })
    
    dep_by_average <- reactive({
      Sym_of_dep_df <- Sym_of_dep_df %>% 
        filter(Phase == input$depPhase) %>% 
        select(State, Value) %>% 
        arrange(desc(Value))
    })
    output$phaseTime_dep <- renderText({
      paste0("Phase 1 (Apr 23 - Jul 21, 2020), Phase 2 (Aug 19 - Oct 26, 2020), Phase 3 (Oct 28 - Dec 21, 2020), 
             Phase 3 (Jan 6 - Mar 29, 2021), Phase 3.1 (Apr 14 - Apr 26, 2021)")
    })
    output$dep_printing <- renderText({
      paste0("The average percentage of respondants with some level of depression across the country is ",
             round(mean(dep_by_average()$Value),2), "%. The percentages overall of people experiencing depressive symptoms is lower
             than the other two, but is still a significant amount, around 25%. It also follows the same pattern as the other two, 
             peaking at the beginning of phase 3 and then going down again inside of 2021.")
    })
})