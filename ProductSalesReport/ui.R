library(shiny)
monthlist <- list("January"=1, "February"=2, "March"=3, "April"=4, "May"=5,
                  "June"=6, "July"=7, "August"=8, "September"=9, "October"=10,
                  "November"=11, "December"=12)
group.name <- list("Cloth Clips","Tray & Plates","Lunch Box","Water Bottle", 
                   "Food Store Container & Bowls", "Other Items",
                   "Glasses", "Soap Case & Bath Tumblers", "Compass Box",
                   "Meal Set Items & Gift Set Items", "Stationery Items")

shinyUI(fluidPage(
  fluidRow(img(src="logo.png", height=62,width=322)),
  br(),
  p("HomeLine Products is a Manufacturing Firm that produces a wide variety of 
    plastic products. These products can be broadly classified into 11 different
    categories (Names of these categories can be found out from the Control
    Group Visibility widget)."),
  p("This app allows the user to see the sales of each product over a desired
    span of time and shows how much a particular product contributes to the 
    overall sales as well as the sales of the particular category to which the
    product belongs. The app contains data from January 2015 to March 2016."),
  strong("IMPORTANT NOTE- The sales numbers have been randomised and manipulated 
    in order to avoid disclosing confidential company data."),
  hr(),
  fluidRow(
    column(2,
           selectInput("id1", label = "Begning Month", choices = monthlist),
           selectInput("id2", label = "Begning Year", choices = list("2015"=2015,"2016"=2016)),
           actionButton("showbutton", "Show")),
    column(2,
           selectInput("id3", label = "Ending Month", choices = monthlist),
           selectInput("id4", label = "Ending Year", choices = list("2015"=2015,"2016"=2016))),
    column(6, offset = 1,
           selectizeInput(
             "group", "Control Group Visibility", choices = group.name, multiple = TRUE))
    ),
  hr(),
  DT::dataTableOutput("mytable")
  
))
