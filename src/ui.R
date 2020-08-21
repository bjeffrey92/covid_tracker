ui <- fluidPage(

    titlePanel("Covid-19 Cases per Test in the UK"),

    sidebarLayout(

        sidebarPanel(
            dateRangeInput(inputId = 'date',
                        label = 'Date Range',
                        start = min(uk$date),
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