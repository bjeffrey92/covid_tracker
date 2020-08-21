source('global.R')

server <- function(input, output) {
    
    uk <- load_data()

    output$uk_plot <- renderPlot({
        uk <- uk[uk$date > as.Date(input$date[1]) & 
                    uk$date < as.Date(input$date[2]),]
        build_plot(uk)
    })

    # names(uk) <- snakecase::to_title_case(names(uk))
    output$tbl <- renderDT(
            uk[uk$date > input$date[1] & uk$date < input$date[2],], 
            options = list(lengthChange = FALSE))

    output$description <- reactive({
        sprintf('Showing actual daily cases per test, and 7-day rolling average cases per test, between %s and %s.',
            input$date[1],
            input$date[2])
    })

}