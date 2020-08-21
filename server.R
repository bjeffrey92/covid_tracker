source('covid_tracker.R')

server <- function(input, output) {

  output$ukPlot <- renderPlot({

    uk <- load_data()
    uk <- tail(uk, n = input$days) #days comes from ui input

    plot(x = uk$date, 
        y = uk$average_cases_per_test, 
        type = 'l', 
        xlab = 'Date', 
        ylab = 'Cases per test')

    })

}