source('global.R')

server <- function(input, output) {
    
    uk <- load_data()

    output$uk_plot <- renderPlot({

        uk <- tail(uk, n = input$days) #days comes from ui input

        build_plot(uk)

    })

}