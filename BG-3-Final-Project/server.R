library(shiny)
library(tidyverse)

source("Dataframes.R")

shinyServer(function(input, output) {
    
    ## Data for the histogram, need to figure out how to put widget data into this
    edit_or_data <- reactive({
        if(is.null(input$typeData)){
            Sym_of_or_df %>% 
            filter(Group == "By State", Indicator == input$typeData) %>% 
            group_by(State) %>% 
            arrange(State, Phase) %>% 
            mutate(Diff_percent = Value - lag(Value), 
                Diff_time = Time.Period - lag(Time.Period),
                Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
                Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
        } else {
            dataframe%>% 
            filter(Group == "By State", Indicator == input$typeData) %>% 
            group_by(State) %>% 
            arrange(State, Phase) %>% 
            mutate(Diff_percent = Value - lag(Value), 
                Diff_time = Time.Period - lag(Time.Period),
                Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
                Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
        }
    })
    
    output$plot <- renderPlot({
        ggplot(data = edit_or_data(), aes(x = State, y = Diff_percent)) +
            geom_bar(stat = "identity", fill = edit_or_data()$Phase, show.legend = TRUE) + 
            geom_abline(mapping = NULL, data = NULL, slope = 0, intercept = 0, col = "white")
    })
    
    # Still needs to be implemented to work with graph
    output$xValDisplay <- renderUI({
        radioButtons("xValTypes", label = "Categories of data", 
                     choices = unique(dataframe$Group), selected = "By State")
    })
    
    output$selectType <- renderUI({
        selectInput("typeData", label = "Type of data", 
                    choices = unique(dataframe$Indicator))
    })
})
