library(shiny)

shinyUI(fluidPage(
    titlePanel("Rates of Anxiety or Depression Symptoms during Covid-19"),
    sidebarLayout(
        sidebarPanel(
            uiOutput("xValDisplay"),
            uiOutput("selectType")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Introduction",
                         includeMarkdown("DataIntro.Rmd")
                         ## Introduction to data set and the project
                ), 
                tabPanel("Plot and insight",
                         plotOutput("plot")
                         ## explanation of findings 
                ),
                tabPanel("Conclusion",
                         #Conclusion R markdown file here
                         )
            )
        )
    )
))