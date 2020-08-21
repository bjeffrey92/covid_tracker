ui <- fluidPage(

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
                    max = nrow(uk),
                    value = nrow(uk))

    ),

    # Main panel for displaying outputs ----
        mainPanel(

            plotOutput(outputId = "uk_plot")
            

        )
    )
)