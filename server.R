server <- function(input, output) {
    
    uk <- load_data()

    output$uk_plot <- renderPlot({

        uk <- tail(uk, n = input$days) #days comes from ui input

        plot(x = uk$date, 
            y = uk$average_cases_per_test, 
            type = 'l', 
            xlab = 'Date', 
            ylab = 'Cases per test')

    })

}