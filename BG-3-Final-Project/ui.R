library(shiny)

shinyUI(navbarPage("Rates of Anxiety or Depression Symptoms during Covid-19",
                   tabPanel("Introduction", 
                            includeMarkdown("DataIntro.Rmd")),
                   tabPanel("Total Plot and Insight",
                            sidebarLayout(
                                sidebarPanel(
                                    uiOutput("xValDisplay"),
                                    uiOutput("selectType")
                                ),
                                mainPanel(
                                    plotOutput("plot_or")
                                )
                            )),
                   tabPanel("Anxiety Plot and Insight",
                            sidebarLayout(
                              sidebarPanel(
                                
                              ),
                              mainPanel(
                                plotOutput("plot_anx")
                              )
                            )),
                   tabPanel("Depression Plot and Insight",
                            sidebarLayout(
                              sidebarPanel(
                                
                              ),
                              mainPanel(
                                plotOutput("plot_dep")
                              )
                            )),
                   tabPanel("Conclusion",
                            includeMarkdown("DataConclusion.Rmd"))
)
)