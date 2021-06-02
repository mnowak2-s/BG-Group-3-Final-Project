library(shiny)
library(tidyverse)

source("Dataframes.R")

shinyServer(function(input, output) {
    
    ## Data for the histogram, need to figure out how to put widget data into this
    edit_or_data <- reactive({
        dataframe %>% 
            filter(Group == "By State", Indicator == input$typeData) %>% 
            group_by(State) %>% 
            arrange(State, Phase) %>% 
            mutate(Diff_percent = Value - lag(Value), 
                   Diff_time = Time.Period - lag(Time.Period),
                   Rate_percent = (Diff_time / Diff_percent)/lag(Time.Period)*100,
                   Diff_percent = case_when(row_number() == 1 ~ Value, TRUE ~ Diff_percent))
    })
    
    outVar <- reactive({
        
    })
    
    # Plot output
    output$plot_anx <- output$plot_dep <- output$plot_or <- renderPlot({
        ggplot(data = edit_or_data(), aes(x = State, y = Diff_percent)) +
            geom_bar(stat = "identity", fill = edit_or_data()$Phase, show.legend = TRUE) + 
            geom_abline(mapping = NULL, data = NULL, slope = 0, intercept = 0, col = "white")
    })
    
    # Which data widget (keep as label)
    output$selectType_or <- output$selectType_anx <- output$selectType_dep <- renderUI({
        selectInput("typeData", label = "Type of data", 
                    choices = unique(dataframe$Indicator), 
                    selected = "Symptoms of Anxiety Disorder or Depressive Disorder")
    })
})