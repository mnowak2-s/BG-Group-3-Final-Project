library(shiny)

shinyUI(navbarPage("Rates of Anxiety or Depression Symptoms during Covid-19",
                   
                   tabPanel("Introduction", 
                            includeMarkdown("DataIntro.Rmd")),
                   tabPanel("Anxiety Or Depression Plot and Insight",
                            sidebarLayout(
                                sidebarPanel(
                                  radioButtons("orPhase", label = "Phase of Pandemic", 
                                               choices = unique(Sym_of_or_df$Phase), 
                                               selected = "1")
                                ),
                                mainPanel(
                                    plotOutput("plot_or"),
                                    textOutput("phaseTime_or"),
                                    textOutput("or_printing")
                                )
                            )),
                   tabPanel("Anxiety Plot and Insight",
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons("anxPhase", label = "Phase of Pandemic", 
                                             choices = unique(Sym_of_anx_df$Phase), 
                                             selected = "1")
                       
                              ),
                              mainPanel(
                                plotOutput("plot_anx"),
                                textOutput("phaseTime_anx"),
                                textOutput("anx_printing")
                              )
                            )),
                   tabPanel("Depression Plot and Insight",
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons("depPhase", label = "Phase of Pandemic", 
                                             choices = unique(Sym_of_dep_df$Phase), 
                                             selected = "1")
                              ),
                              mainPanel(
                                plotOutput("plot_dep"), 
                                textOutput("phaseTime_dep"),
                                textOutput("dep_printing")
                              )
                            )),
                   tabPanel("Conclusion",
                            includeMarkdown("DataConclusion.Rmd"))
)
)