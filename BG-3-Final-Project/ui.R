library(shiny)

shinyUI(fluidPage(
    titlePanel("Rates of Anxiety or Depression Symptoms during Covid-19"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            uiOutput("xValDisplay"),
            uiOutput("selectType")
        ),
        mainPanel(
            plotOutput("plot")
        )
    )
))
