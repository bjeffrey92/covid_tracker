source('global.R')

ui <- fluidPage(

    titlePanel("Covid-19 Cases per Test in the UK"),

    sidebarLayout(

        sidebarPanel(
            dateRangeInput(inputId = 'date',
                        label = 'Date Range',
                        start = max(uk$date) - 42,
                        end = max(uk$date),
                        min = min(uk$date),
                        max = max(uk$date)
            ),
            span(textOutput(outputId = "warning"), style="color:red")
        ),

        mainPanel(
            textOutput(outputId = "description"),
            textOutput(outputId = "reference"),
            plotOutput(outputId = "uk_plot"),
            dataTableOutput("tbl"),
        )
    )
)

server <- function(input, output) {

    output$uk_plot <- renderPlot({
        uk <- uk[uk$date >= as.Date(input$date[1]) & 
                    uk$date <= as.Date(input$date[2]),]
        build_plot(uk)
    })

    output$tbl <- renderDT(
            uk_f[uk_f$Date >= input$date[1] & uk_f$Date <= input$date[2],], 
            options = list(lengthChange = FALSE))

    output$description <- reactive({
        sprintf("Showing actual daily cases per test, and the 7-day rolling average, between %s and %s.",
            input$date[1],
            input$date[2])
    })
    
    output$reference <- renderText(
        "Data imported from https://coronavirus.data.gov.uk/."
    )

    output$warning <- renderText(
        'WARNING: Coronavirus infection testing practices have changed over time in the UK. Therefore caution showed be exercised when analysing the trend in percent test positivity over long periods of time'
    )
}

shinyApp(ui = ui, server = server)