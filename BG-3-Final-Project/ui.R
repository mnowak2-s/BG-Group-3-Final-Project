library(shiny)

shinyUI(navbarPage("Rates of Anxiety or Depression Symptoms during Covid-19",
                   tabPanel("Introduction", 
                            includeMarkdown("DataIntro.Rmd")),
                   tabPanel("Total Plot and Insight"),
                   tabPanel("Anxiety Plot and Insight",
                            sidebarLayout(
                                sidebarPanel(
                                    uiOutput("xValDisplay"),
                                    uiOutput("selectType")
                                ),
                                mainPanel(
                                    plotOutput("plot")
                                )
                            )),
                   tabPanel("Depression Plot and Insight")
)
)