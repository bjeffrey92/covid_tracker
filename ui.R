# Define UI for app that draws a histogram ----
ui <- fluidPage(

  # App title ----
  titlePanel("Covid-19 Cases per Test in the UK"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Slider for the number of bins ----
      sliderInput(inputId = "days",
                  label = sprintf("Days Before the Present (%s):", 
                                Sys.Date()),
                  min = 1,
                  max = 50,
                  value = 30)

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "ukPlot")

    )
  )
)