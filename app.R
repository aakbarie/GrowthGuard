# Load necessary libraries
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(tidyverse)
library(lubridate)
library(shinyjs)

# Optional packages for enhanced UI
if (requireNamespace("shinycssloaders", quietly = TRUE)) {
  library(shinycssloaders)
  use_spinners <- TRUE
} else {
  use_spinners <- FALSE
  cat("Note: shinycssloaders not installed. Install with: install.packages('shinycssloaders')\n")
}

# Optional markdown rendering support
has_markdown <- requireNamespace("markdown", quietly = TRUE)
if (!has_markdown) {
  cat("Note: markdown package not installed. Install with: install.packages('markdown') for proper Markdown rendering.\n")
}

# Language Support System
source("translations.R", local = TRUE)

# Source external R scripts and load data
source("global.R")  # Ensure this loads necessary libraries and sets up paths
source("R/MygrowthFun.R")  # Source plotting orchestration function from R/
# Note: Do not source plotting scripts at startup; they execute plotting code.
# The plotting code is sourced on-demand inside `MygrowthFun`.
# source("www/resource_files.R")

# Define the UI for the Shiny Dashboard
ui <- dashboardPage(
    dashboardHeader(
      title = uiOutput("app_title"),
      titleWidth = 300,
      # GitHub link in navbar
      tags$li(class = "dropdown",
        a(href = "https://github.com/aakbarie/GrowthGuard", target = "_blank", class = "github-link",
          icon("github"), span("GitHub")
        )
      ),
      # Language selector
      tags$li(class = "dropdown",
        style = "margin: 8px 15px; color: white;",
        div(
          selectInput("language",
            label = NULL,
            choices = list("English" = "en", "Español" = "es"),
            selected = "en",
            width = "120px"
          )
        )
      )
    ),
    dashboardSidebar(
      width = 300,
      sidebarMenuOutput("sidebar")
    ),
    dashboardBody(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$link(href = "https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;500;600;700&family=Source+Code+Pro:wght@400;500&display=swap", rel = "stylesheet"),
      tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
      tags$script(HTML("
        // Add smooth scrolling and loading animations
        document.addEventListener('DOMContentLoaded', function() {
          // Add fade-in animation to content
          $('.content-wrapper').addClass('fade-in');
        });
      "))
    ),
    tabItems(
      # Welcome Page Tab
      tabItem(
        tabName = "home",
        # Hero Section
        div(id = "main_content",
          fluidRow(
            column(12,
              div(class = "hero-section",
                uiOutput("hero_content")
              )
            )
          )
        ),

        fluidRow(
          # Features Grid
          column(4,
            div(class = "feature-card",
              div(class = "feature-icon",
                icon("chart-area", class = "fa-2x")
              ),
              h4("Personalized Charts"),
              p("Generate growth charts tailored to your child's data using CDC-WHO standards")
            )
          ),
          column(4,
            div(class = "feature-card",
              div(class = "feature-icon",
                icon("shield-alt", class = "fa-2x")
              ),
              h4("Privacy First"),
              p("Your data never leaves your device. HIPAA compliant with no server storage")
            )
          ),
          column(4,
            div(class = "feature-card",
              div(class = "feature-icon",
                icon("download", class = "fa-2x")
              ),
              h4("Export & Save"),
              p("Download charts as PDF and data as CSV for your medical records")
            )
          )
        ),

        fluidRow(
          column(12,
            box(
              title = "How It Works",
              width = 12,
              status = "primary",
              div(class = "steps-container",
                div(class = "step",
                  div(class = "step-number", "1"),
                  h4("Enter Information"),
                  p("Input your child's basic details: name, birth date, and current measurements")
                ),
                div(class = "step",
                  div(class = "step-number", "2"),
                  h4("Generate Chart"),
                  p("Our tool creates a personalized growth chart using CDC-WHO standards")
                ),
                div(class = "step",
                  div(class = "step-number", "3"),
                  h4("Track & Export"),
                  p("View results instantly and download for your medical records")
                )
              )
            )
          )
        )
      ),
      
      # Growth Chart Tab
      tabItem(
        tabName = "growth_chart",
        # Progress Indicator
        fluidRow(
          column(12,
            uiOutput("progress_indicator")
          )
        ),

        # Step 1: Child Information
        div(id = "step1", class = "form-step active",
          fluidRow(
            column(8, offset = 2,
              box(
                title = div(
                  icon("child", class = "step-icon"),
                  "Child Information"
                ),
                width = 12,
                status = "primary",

                # Child's Name
                div(class = "form-section",
                  h4("What's your child's name?"),
                  textInput("name",
                    label = NULL,
                    placeholder = "Enter child's full name",
                    width = "100%"
                  ),
                  div(class = "form-help", "This will appear on the growth chart")
                ),

                # Gender Selection
                div(class = "form-section",
                  h4("Gender"),
                  div(class = "gender-selection",
                    prettyRadioButtons(
                      inputId = "sex",
                      label = NULL,
                      choices = list(
                        "Male" = "Male",
                        "Female" = "Female"
                      ),
                      inline = TRUE,
                      icon = icon("check"),
                      bigger = TRUE,
                      status = "info",
                      animation = "jelly"
                    )
                  )
                ),

                # Current Measurements
                div(class = "form-section",
                  h4("Current Measurements"),
                  fluidRow(
                    column(6,
                      div(class = "measurement-input",
                        numericInput("height_inch",
                          label = "Height (inches)",
                          value = NULL,
                          min = 10,
                          max = 84,
                          step = 0.25
                        ),
                        div(class = "input-help", "For example: 36.5 inches")
                      )
                    ),
                    column(6,
                      div(class = "measurement-input",
                        numericInput("weight_lbs",
                          label = "Weight (pounds)",
                          value = NULL,
                          min = 5,
                          max = 300,
                          step = 0.1
                        ),
                        div(class = "input-help", "For example: 28.5 pounds")
                      )
                    )
                  )
                ),

                # Important Dates
                div(class = "form-section",
                  h4("Important Dates"),
                  fluidRow(
                    column(6,
                      div(class = "date-input",
                        dateInput("dob",
                          label = "Date of Birth",
                          min = Sys.Date() - years(18),
                          max = Sys.Date(),
                          format = "mm/dd/yyyy",
                          startview = "year"
                        ),
                        div(class = "input-help", "When was your child born?")
                      )
                    ),
                    column(6,
                      div(class = "date-input",
                        dateInput("dov",
                          label = "Measurement Date",
                          value = Sys.Date(),
                          min = Sys.Date() - years(18),
                          max = Sys.Date(),
                          format = "mm/dd/yyyy"
                        ),
                        div(class = "input-help", "When were these measurements taken?")
                      )
                    )
                  )
                ),

                # Navigation
                div(class = "form-navigation",
                  actionBttn(
                    inputId = "next_step1",
                    label = "Continue to Chart Options",
                    style = "gradient",
                    color = "primary",
                    size = "md",
                    icon = icon("arrow-right"),
                    block = FALSE
                  )
                )
              )
            )
          )
        ),

        # Step 2: Chart Options
        div(id = "step2", class = "form-step",
          fluidRow(
            column(8, offset = 2,
              box(
                title = div(
                  icon("chart-line", class = "step-icon"),
                  "Chart Options"
                ),
                width = 12,
                status = "primary",
                # Chart Type Selection
                div(class = "form-section",
                  h4("What type of growth chart do you need?"),
                  div(class = "chart-type-selection",
                    prettyRadioButtons(
                      inputId = "type",
                      label = NULL,
                      choices = list(
                        "Height for Age" = "Height-Age",
                        "Weight for Age" = "Weight-Age"
                      ),
                      inline = FALSE,
                      icon = icon("check"),
                      bigger = TRUE,
                      status = "info",
                      animation = "jelly"
                    )
                  ),
                  div(class = "form-help", "Height-for-age tracks linear growth, while weight-for-age tracks weight gain")
                ),

                # Standards Selection
                div(class = "form-section",
                  h4("Growth Standards"),
                  div(class = "standards-info",
                    div(class = "standard-card selected",
                      div(class = "standard-header",
                        icon("check-circle", class = "standard-icon"),
                        h5("CDC-WHO Standards")
                      ),
                      p("Internationally recognized growth charts combining CDC and WHO data for comprehensive tracking")
                    )
                  ),
                  hidden(
                    textInput("org", label = NULL, value = "CDC-WHO")
                  )
                ),

                # Navigation
                div(class = "form-navigation",
                  actionBttn(
                    inputId = "back_step2",
                    label = "Back",
                    style = "simple",
                    color = "default",
                    size = "md",
                    icon = icon("arrow-left")
                  ),
                  actionBttn(
                    inputId = "generate_chart",
                    label = "Generate Growth Chart",
                    style = "gradient",
                    color = "success",
                    size = "md",
                    icon = icon("chart-line")
                  )
                )
              )
            )
          )
        ),

        # Step 3: Results
        div(id = "step3", class = "form-step",
          fluidRow(
            column(12,
              box(
                title = div(
                  icon("chart-area", class = "step-icon"),
                  "Growth Chart Results"
                ),
                width = 12,
                status = "success",

                # Chart Display
                div(class = "chart-container",
                  if (use_spinners) {
                    withSpinner(
                      plotOutput("growthPlot", height = "500px"),
                      type = 6,
                      color = "#2563eb"
                    )
                  } else {
                    plotOutput("growthPlot", height = "500px")
                  }
                ),

                # Action Buttons
                div(class = "results-actions",
                  fluidRow(
                    column(6,
                      downloadBttn(
                        outputId = "downloadData",
                        label = "Download Data (CSV)",
                        style = "gradient",
                        color = "success",
                        size = "md",
                        icon = icon("download"),
                        block = TRUE
                      )
                    ),
                    column(6,
                      downloadBttn(
                        outputId = "downloadChart",
                        label = "Download Chart (PDF)",
                        style = "gradient",
                        color = "warning",
                        size = "md",
                        icon = icon("file-pdf"),
                        block = TRUE
                      )
                    )
                  )
                ),

                # Privacy Notice
                div(class = "privacy-notice",
                  div(class = "privacy-icon",
                    icon("shield-alt")
                  ),
                  div(class = "privacy-text",
                    strong("Privacy Protected: "),
                    "Your data is processed locally and never stored on our servers. This tool is HIPAA compliant."
                  )
                ),

                # Navigation
                div(class = "form-navigation",
                  actionBttn(
                    inputId = "new_calculation",
                    label = "New Calculation",
                    style = "simple",
                    color = "primary",
                    size = "md",
                    icon = icon("plus")
                  )
                )
              )
            )
          )
        )
      ),

      # About Tab
      tabItem(
        tabName = "about",
        fluidRow(
          column(8, offset = 2,
            box(
              title = uiOutput("about_title"),
              width = 12,
              status = "info",
              uiOutput("about_md")
            )
          )
        )
      ),

      # Medical Information Tab - Pediatrician Reviewed
      tabItem(
        tabName = "medical_info",
        fluidRow(
          column(10, offset = 1,

            # Medical Advisory section removed per request

            # Comprehensive Medical Disclaimer
            box(
              title = "⚠️ Comprehensive Medical Disclaimer",
              width = 12,
              status = "danger",
              solidHeader = TRUE,
              uiOutput("disclaimer_md")
            ),

            # Data Quality and Sources
            box(
              title = "📊 Data Quality & Medical Standards",
              width = 12,
              status = "info",
              uiOutput("data_quality_md")
            )
          )
        )
      )
    ) # End tabItems
  ) # End dashboardBody
  ) # End dashboardPage

# Define the server logic
server <- function(input, output, session) {

  # Reactive values for step management
  values <- reactiveValues(
    current_step = 1,
    form_valid = FALSE,
    disclaimer_acknowledged = FALSE,
    current_language = "en"
  )

  # Helper for translations in server (after values is defined)
  tr <- function(key) t(key, values$current_language)

  # Language Management
  observe({
    if (!is.null(input$language)) {
      values$current_language <- input$language
    }
  })

  # Dynamic header title
  output$app_title <- renderUI({
    span(tr("app_title"))
  })

  # Dynamic About title
  output$about_title <- renderUI({
    span(tr("about_title"))
  })

  # Dynamic sidebar menu
  output$sidebar <- shinydashboard::renderMenu({
    shinydashboard::sidebarMenu(id = "tabs", selected = "home",
      shinydashboard::menuItem(tr("nav_welcome"), tabName = "home", icon = icon("house")),
      shinydashboard::menuItem(tr("nav_tracker"), tabName = "growth_chart", icon = icon("chart-line")),
      shinydashboard::menuItem(tr("nav_about"), tabName = "about", icon = icon("info-circle")),
      shinydashboard::menuItem(tr("nav_medical_info"), tabName = "medical_info", icon = icon("user-md"))
    )
  })

  # Dynamic hero content
  output$hero_content <- renderUI({
    div(class = "hero-content text-center",
      h1(class = "hero-title", tr("hero_title")),
      p(class = "hero-subtitle lead", tr("hero_subtitle")),
      div(class = "hero-actions",
        shinyWidgets::actionBttn(
          inputId = "start_tracking",
          label = tr("hero_cta"),
          style = "gradient",
          color = "primary",
          size = "lg",
          icon = icon("chart-line")
        )
      )
    )
  })

  # Dynamic progress indicator
  output$progress_indicator <- renderUI({
    div(class = "progress-indicator",
      div(class = "progress-step active", `data-step` = "1", tr("progress_step1")),
      div(class = "progress-step", `data-step` = "2", tr("progress_step2")),
      div(class = "progress-step", `data-step` = "3", tr("progress_step3"))
    )
  })

  # Helper to include markdown by language
  include_md_lang <- function(base) {
    lang <- values$current_language %||% "en"
    path <- file.path("content", sprintf("%s.%s.md", base, lang))
    if (file.exists(path)) {
      if (has_markdown) {
        includeMarkdown(path)
      } else {
        HTML(paste(readLines(path, warn = FALSE), collapse = "\n"))
      }
    } else {
      HTML(sprintf("<em>Content not found: %s</em>", path))
    }
  }

  # About page markdown
  output$about_md <- renderUI({
    include_md_lang("about")
  })

  # Medical advisory removed

  # Comprehensive disclaimer markdown
  output$disclaimer_md <- renderUI({
    include_md_lang("disclaimer")
  })

  # Data quality markdown
  output$data_quality_md <- renderUI({
    include_md_lang("data_quality")
  })


  # Lightweight event logging (tempdir() only)
  log_event <- function(event_type, lang, user_name = NA_character_) {
    req <- session$request
    user_agent <- if (!is.null(req$HTTP_USER_AGENT)) req$HTTP_USER_AGENT else if (!is.null(session$clientData$http_user_agent)) session$clientData$http_user_agent else NA
    ip <- if (!is.null(req$HTTP_X_FORWARDED_FOR)) req$HTTP_X_FORWARDED_FOR else if (!is.null(req$REMOTE_ADDR)) req$REMOTE_ADDR else NA
    record <- data.frame(
      timestamp = as.character(Sys.time()),
      event = event_type,
      session_id = if (!is.null(session$token)) session$token else NA,
      language = lang,
      user = user_name,
      ip = ip,
      user_agent = user_agent,
      stringsAsFactors = FALSE
    )
    path <- file.path(tempdir(), "disclaimer_log.csv")
    if (!file.exists(path)) {
      try(utils::write.csv(record, path, row.names = FALSE), silent = TRUE)
    } else {
      try(utils::write.table(record, path, sep = ",", col.names = FALSE, row.names = FALSE, append = TRUE), silent = TRUE)
    }
  }


  # Show startup medical disclaimer as a modal (once)
  observeEvent(TRUE, {
    showModal(modalDialog(
      title = tr("medical_disclaimer_title"),
      size = "m",
      easyClose = FALSE,
      footer = tagList(
        actionBttn(
          inputId = "acknowledge_disclaimer",
          label = if (values$current_language == "es") "Entiendo - Continuar" else "I Understand - Continue",
          style = "gradient",
          color = "warning",
          size = "sm",
          icon = icon("check")
        )
      ),
      div(class = "disclaimer-content",
        p(tr("medical_disclaimer_main"))
      )
    ))
  }, once = TRUE)

  # Medical Disclaimer Acknowledgment
  observeEvent(input$acknowledge_disclaimer, {
    values$disclaimer_acknowledged <- TRUE
    removeModal()
    # Log acknowledgement (note: tempdir() on shinyapps.io is ephemeral)
    log_event("modal_ack", values$current_language)
    showNotification(
      if (values$current_language == "es") {
        "Gracias por reconocer el descargo de responsabilidad médica."
      } else {
        "Thank you for acknowledging the medical disclaimer."
      },
      type = "message",
      duration = 3
    )
  })

  # Step Navigation Logic
  observeEvent(input$start_tracking, {
    updateTabItems(session, "tabs", selected = "growth_chart")
    # Initialize steps when entering growth tab
    shinyjs::show("step1")
    shinyjs::hide("step2")
    shinyjs::hide("step3")
    values$current_step <- 1
    shinyjs::removeClass(selector = ".progress-step", class = "active")
    shinyjs::removeClass(selector = ".progress-step", class = "completed")
    shinyjs::addClass(selector = ".progress-step[data-step='1']", class = "active")
  })

  # Step 1 validation and navigation
  observeEvent(input$next_step1, {
    # Validate required fields
    if (!is.null(input$name) && input$name != "" &&
        !is.null(input$sex) &&
        !is.null(input$height_inch) && input$height_inch > 0 &&
        !is.null(input$weight_lbs) && input$weight_lbs > 0 &&
        !is.null(input$dob) && !is.null(input$dov)) {

      # Record consent by name entry
      log_event("name_consent", values$current_language, input$name)

      # Move to step 2
      shinyjs::hide("step1")
      shinyjs::show("step2")
      values$current_step <- 2

      # Update progress indicator
      shinyjs::removeClass(selector = ".progress-step[data-step='1']", class = "active")
      shinyjs::addClass(selector = ".progress-step[data-step='1']", class = "completed")
      shinyjs::addClass(selector = ".progress-step[data-step='2']", class = "active")

    } else {
      showNotification(
        "Please fill in all required fields before continuing.",
        type = "warning",
        duration = 3
      )
    }
  })

  # Step 2 navigation
  observeEvent(input$back_step2, {
    shinyjs::hide("step2")
    shinyjs::show("step1")
    values$current_step <- 1

    # Update progress indicator
    shinyjs::removeClass(selector = ".progress-step[data-step='2']", class = "active")
    shinyjs::removeClass(selector = ".progress-step[data-step='1']", class = "completed")
    shinyjs::addClass(selector = ".progress-step[data-step='1']", class = "active")
  })

  # Generate chart and move to step 3
  observeEvent(input$generate_chart, {
    if (!is.null(input$type)) {
      # Move to step 3
      shinyjs::hide("step2")
      shinyjs::show("step3")
      values$current_step <- 3

      # Update progress indicator
      shinyjs::removeClass(selector = ".progress-step[data-step='2']", class = "active")
      shinyjs::addClass(selector = ".progress-step[data-step='2']", class = "completed")
      shinyjs::addClass(selector = ".progress-step[data-step='3']", class = "active")

      # Generate the chart
      values$chart_generated <- TRUE

    } else {
      showNotification(
        "Please select a chart type.",
        type = "warning",
        duration = 3
      )
    }
  })

  # Reset to step 1 for new calculation
  observeEvent(input$new_calculation, {
    shinyjs::hide("step3")
    shinyjs::show("step1")
    values$current_step <- 1
    values$chart_generated <- FALSE

    # Reset progress indicator
    shinyjs::removeClass(selector = ".progress-step", class = "active")
    shinyjs::removeClass(selector = ".progress-step", class = "completed")
    shinyjs::addClass(selector = ".progress-step[data-step='1']", class = "active")

    # Reset form inputs
    updateTextInput(session, "name", value = "")
    updateNumericInput(session, "height_inch", value = NULL)
    updateNumericInput(session, "weight_lbs", value = NULL)
    updateDateInput(session, "dov", value = Sys.Date())
  })

  # Conversion functions
  height_cm <- reactive({
    req(input$height_inch)
    input$height_inch * 2.54
  })

  weight_kg <- reactive({
    req(input$weight_lbs)
    input$weight_lbs * 0.453592
  })

  # Generate growth chart data
  awh <- eventReactive(input$generate_chart, {
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
