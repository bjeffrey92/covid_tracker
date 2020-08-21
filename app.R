source('global.R')

ui <- fluidPage(

    titlePanel("Covid-19 Cases per Test in the UK"),

    sidebarLayout(

        sidebarPanel(
            dateRangeInput(inputId = 'date',
                        label = 'Date Range',
                        start = as.Date("2020-04-01"),
                        end = max(uk$date),
                        min = min(uk$date),
                        max = max(uk$date)
            )
        ),

        mainPanel(
            textOutput(outputId = "foo"),
            textOutput(outputId = "bar"),
            textOutput(outputId = "description"),
            plotOutput(outputId = "uk_plot"),
            dataTableOutput("tbl"),
        )
    )
)

server <- function(input, output) {
    
    uk <- load_data()
    uk_f <- format_for_table(uk)

    output$uk_plot <- renderPlot({
        uk <- uk[uk$date >= as.Date(input$date[1]) & 
                    uk$date <= as.Date(input$date[2]),]
        build_plot(uk)
    })

    # names(uk) <- snakecase::to_title_case(names(uk))
    output$tbl <- renderDT(
            uk_f[uk_f$Date >= input$date[1] & uk_f$Date <= input$date[2],], 
            options = list(lengthChange = FALSE))

    output$description <- reactive({
        sprintf('Showing actual daily cases per test, and the 7-day rolling average, between %s and %s.',
            input$date[1],
            input$date[2])
    })

}

shinyApp(ui = ui, server = server)