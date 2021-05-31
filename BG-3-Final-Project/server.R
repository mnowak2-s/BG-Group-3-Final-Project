library(shiny)
library(tidyverse)

source("Dataframes.R")

shinyServer(function(input, output) {
    output$distPlot <- renderPlot({
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    edit_or_data <- Sym_of_or_df %>% 
        filter(Group == "By State")
    edit_or_data$Phase <- as.factor(edit_or_data$Phase)
    output$plot <- renderPlot({
        ggplot(data = edit_or_data, aes(x = State, y = Value), stat=identity) +
            geom_bar(stat = "identity", fill = edit_or_data$Phase)
    })
})
