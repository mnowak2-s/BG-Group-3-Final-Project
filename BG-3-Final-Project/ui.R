library(shiny)

shinyUI(fluidPage(
    titlePanel("Rates of Anxiety or Depression Symptoms during Covid-19"),
    sidebarLayout(
        sidebarPanel(
            uiOutput("xValDisplay"),
            uiOutput("selectType")
        ),
        mainPanel(
            plotOutput("plot")
        )
    )
))
