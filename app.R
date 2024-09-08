# Load necessary libraries
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(tidyverse)
library(lubridate)

# Source external R scripts and load data
source("global.R")  # Ensure this loads necessary libraries and sets up paths
source("www/MygrowthFun.R")  # Ensure this path is correct relative to your app's location
source("www/resource_files.R")  # Ensure this path is correct relative to your app's location

# Define the UI for the Shiny Dashboard
ui <- dashboardPage(
  dashboardHeader(title = "GrowthGuard", titleWidth = 350),
  dashboardSidebar(
    width = 350,
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("info-circle")),
      menuItem("Growth Chart", tabName = "growth_chart", icon = icon("chart-line"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")  # Link to the custom CSS
    ),
    tabItems(
      # Landing Page Tab
      tabItem(
        tabName = "home",
        fluidRow(
          box(
            title = "Welcome to GrowthGuard", 
            width = 12, 
            solidHeader = TRUE, 
            status = "primary",
            p("GrowthGuard is an interactive tool designed to help parents and caregivers track the growth of their children. 
              Using this app, you can input your child's height, weight, and other relevant information to generate personalized growth charts 
              based on CDC-WHO standards."),
            p("Please note that all inputs for height can be in inches and weight can be in pounds; the app will convert them automatically."),
            p("Features of the app include:"),
            tags$ul(
              tags$li("View personalized growth charts based on your child's data."),
              tags$li("Download growth data in CSV format for easy record-keeping."),
              tags$li("Download the generated growth chart as a PDF for your records."),
              tags$li("Easy-to-use interface with guidance to help you navigate the app.")
            ),
            p("To get started, navigate to the 'Growth Chart' tab, fill in the required fields, and click 'View Growth Chart'. 
              You can then download the growth data and chart for your records."),
            p(strong("Note:"), " Your data is not stored on our servers. All information entered is used only for generating the growth chart 
              and can be downloaded by you directly. This ensures your privacy and complies with HIPAA regulations.")
          )
        )
      ),
      
      # Growth Chart Tab
      tabItem(
        tabName = "growth_chart",
        fluidRow(
          box(
            width = 12,
            h2("Growth Chart"),
            wellPanel(
              tags$div(
                textInput("name", "Name", placeholder = "Enter the child's name"),
                title = "Enter the child's name"
              ),
              splitLayout(
                cellWidths = c("40%", "30%", "30%"),
                tags$div(
                  prettyRadioButtons(
                    inputId = "sex",
                    label = "Sex",
                    choices = c("Male", "Female"),
                    inline = FALSE
                  ),
                  title = "Select the child's gender"
                ),
                tags$div(
                  numericInput("height_inch", "Height (inches)", value = 40, min = 1, max = 100),
                  title = "Enter the child's height in inches"
                ),
                tags$div(
                  numericInput("weight_lbs", "Weight (pounds)", value = 20, min = 1, max = 300),
                  title = "Enter the child's weight in pounds"
                )
              ),
              splitLayout(
                tags$div(
                  dateInput("dob", label = "Date of Birth:", min = Sys.Date() %m-% years(18), 
                            max = Sys.Date(), format = "dd-mm-yyyy", startview = "year", 
                            weekstart = 0, language = "en"),
                  title = "Select the child's date of birth"
                ),
                tags$div(
                  dateInput("dov", label = "Date of Visit:", min = Sys.Date() %m-% years(18), 
                            max = Sys.Date(), format = "dd-mm-yyyy", startview = "year", 
                            weekstart = 0, language = "en"),
                  title = "Select the date of the visit"
                )
              ),
              wellPanel(
                splitLayout(
                  tags$div(
                    prettyRadioButtons(
                      inputId = "type",
                      label = "Chart Type",
                      choices = c("Height-Age", "Weight-Age"),
                      inline = FALSE
                    ),
                    title = "Choose the type of growth chart"
                  ),
                  tags$div(
                    prettyRadioButtons(
                      inputId = "org",
                      label = "Chart Org",
                      choices = c("CDC-WHO"),
                      selected = "CDC-WHO",
                      inline = FALSE
                    ),
                    title = "This field selects the CDC-WHO standard for growth charts"
                  )
                )
              ),
              br(),
              tags$div(
                actionBttn(
                  inputId = "addPlot",
                  label = "View Growth Chart",
                  color = "primary",
                  style = "material-flat",
                  block = TRUE,
                  size = "sm"
                ),
                title = "Click to generate and view the growth chart"
              ),
              br(),
              tags$div(
                downloadBttn(
                  outputId = "downloadData",
                  label = "Download Your Growth Data",
                  color = "success",
                  style = "material-flat",
                  block = TRUE,
                  size = "sm"
                ),
                title = "Click to download the growth data in CSV format"
              ),
              br(),
              tags$div(
                downloadBttn(
                  outputId = "downloadChart",
                  label = "Download Growth Chart",
                  color = "warning",
                  style = "material-flat",
                  block = TRUE,
                  size = "sm"
                ),
                title = "Click to download the growth chart as a PDF"
              ),
              br(),
              HTML("<p><strong>Note:</strong> Your data is not stored on our servers. All information entered is used only for generating the growth chart and can be downloaded by you directly. This ensures your privacy and complies with HIPAA regulations.</p>")
            ),
            plotOutput("growthPlot", height = 500)
          )
        )
      )
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  initialInputs <- isolate(reactiveValuesToList(input))
  
  # Observe initial input values
  observe({
    inputValues <- reactiveValuesToList(input)
    initialInputs <<- utils::modifyList(inputValues, initialInputs)
  })
  
  # Convert height and weight from inches and pounds to cm and kg
  height_cm <- reactive({
    input$height_inch * 2.54  # Convert inches to centimeters
  })
  
  weight_kg <- reactive({
    input$weight_lbs * 0.453592  # Convert pounds to kilograms
  })
  
  # Generate growth chart data
  awh <- eventReactive(input$addPlot, {
    validate(
      need(input$name != "", "Please enter a name."),
      need(height_cm() > 0, "Height must be greater than 0."),
      need(weight_kg() > 0, "Weight must be greater than 0.")
    )
    if (input$type == "Weight-Age") {
      data.frame(months = age(input$dob), weight = weight_kg())
    } else {
      data.frame(months = age(input$dob), length = height_cm())
    }
  })
  
  # Render growth chart plot
  output$growthPlot <- renderPlot({
    req(awh())  # Ensure data is ready before plotting
    plot_data <- awh()
    sex <- ifelse(input$sex == "Male", "m", "f")
    type <- ifelse(input$type == "Height-Age", "lac", "wac")
    MygrowthFun(
      sex = sex, 
      name = input$name, 
      state = input$org,
      date_visit = as.character(format(as.Date(input$dov), "%d-%m-%Y")),
      birth_date = as.character(format(as.Date(input$dob), "%d-%m-%Y")), 
      type = type, 
      mydataAA = plot_data
    )
  })
  
  # Download data as CSV
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("Growth_Chart_", gsub("[^A-Za-z0-9]", "_", input$name), "_", format(Sys.Date(), "%Y-%m-%d"), ".csv", sep = "")
    },
    content = function(file) {
      temp <- data.frame(
        "Date" = as.character(format(as.Date(input$dov), "%d-%m-%Y")),
        "Name" = input$name, 
        "Age (months)" = age(input$dob),
        "Sex" = input$sex, 
        "Weight (Kg)" = round(weight_kg(), 2), 
        "Height (cm)" = round(height_cm(), 2)
      )
      write.csv(temp, file, row.names = FALSE)
    }
  )
  
  # Download Growth Chart
  output$downloadChart <- downloadHandler(
    filename = function() {
      paste("Growth_Chart_", gsub("[^A-Za-z0-9]", "_", input$name), "_", format(Sys.Date(), "%Y-%m-%d"), ".pdf", sep = "")
    },
    content = function(file) {
      pdf(file, width = 11, height = 8)
      plot_data <- awh()
      sex <- ifelse(input$sex == "Male", "m", "f")
      type <- ifelse(input$type == "Height-Age", "lac", "wac")
      MygrowthFun(
        sex = sex, 
        name = input$name, 
        state = input$org,
        date_visit = as.character(format(as.Date(input$dov), "%d-%m-%Y")),
        birth_date = as.character(format(as.Date(input$dob), "%d-%m-%Y")), 
        type = type, 
        mydataAA = plot_data
      )
      dev.off()
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
