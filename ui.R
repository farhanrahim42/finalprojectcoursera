### Data Science Capstone : Course Project
### ui.R file for the Shiny app
### Github repo : https://github.com/justusfrantz/capstone

suppressWarnings(library(shiny))
suppressWarnings(library(markdown))
shinyUI(navbarPage("Peer-graded Assignment: Final Project Submission
                   ",
                   tabPanel("Predict the Next Word",
                            HTML("<strong>Author: MUHAMAD FARHAN BIN ABD RAHIM</strong>"),
                            br(),
                            HTML("<strong>Date: 16 June 2017</strong>"),
                            br(),
                            ##img(src = "./headers.png"),
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Type a phrase in the input box for the prediction"),
                                textInput("inputString", "Enter a phrase here",value = ""),
                                br(),
                                br(),
                                br(),
                                br()
                              ),
                              mainPanel(
                                h2("Predicted Next Word"),
                                verbatimTextOutput("prediction"),
                                strong("Sentence Input:"),
                                tags$style(type='text/css', '#text1 {background-color: rgba(255,255,0,0.40); color: blue;}'), 
                                textOutput('text1'),
                                br(),
                                strong("Note:"),
                                tags$style(type='text/css', '#text2 {background-color: rgba(255,255,0,0.40); color: black;}'),
                                textOutput('text2')
                              )
                            )
                            
                   ),
                   tabPanel("About",
                            HTML("<strong>The goal of this exercise is to create a product to highlight the prediction algorithm that you have built and to provide an interface that can be accessed by others. For this project you must submit:</strong>"),
                            br(),
                            br(),
                            HTML("1. A Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word."),
                            br(),
                            HTML("2. A slide deck consisting of no more than 5 slides created with R Studio Presenter https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations pitching your algorithm and app as if you were presenting to your boss or an investor."),
                            br(),
                            br(),
                            br(),
                            br(),
                            HTML("<strong>Review criteria Data Product</strong>"),
                            br(),
                            br(),
                            HTML("1. link lead to a Shiny app with a text input box that is running on shinyapps.io"),
                            br(),
                            HTML("2. app load to the point where it can accept input"),
                            br(),
                            HTML("3. type a phrase in the input box and get a prediction of a single word after pressing submit and/or a suitable delay for the model to compute the answer"),
                            br(),
                            HTML("4. Put five phrases drawn from Twitter or news articles in English leaving out the last word. Did it give a prediction for every one"),
                            mainPanel(

                              #img(src = "./headers.png"),
                              #includeMarkdown("about.md")  
                            )
                   )
)
)