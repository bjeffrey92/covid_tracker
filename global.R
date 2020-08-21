library(data.table)
library(snakecase)
library(ggplot2)
library(DT)

ma <- function(x, n = 7){
    stats::filter(x, rep(1 / n, n), sides = 2)
}


load_data <- function(){
    uk_cases_url <- 'https://api.coronavirus.data.gov.uk/v1/data?filters=areaName=United%2520Kingdom;areaType=overview&structure=%7B%22areaType%22:%22areaType%22,%22areaName%22:%22areaName%22,%22areaCode%22:%22areaCode%22,%22date%22:%22date%22,%22newCasesByPublishDate%22:%22newCasesByPublishDate%22,%22cumCasesByPublishDate%22:%22cumCasesByPublishDate%22%7D&format=csv'  
    uk_tests_url <- 'https://api.coronavirus.data.gov.uk/v1/data?filters=areaName=United%2520Kingdom;areaType=overview&structure=%7B%22areaType%22:%22areaType%22,%22areaName%22:%22areaName%22,%22areaCode%22:%22areaCode%22,%22date%22:%22date%22,%22plannedCapacityByPublishDate%22:%22plannedCapacityByPublishDate%22,%22newTestsByPublishDate%22:%22newTestsByPublishDate%22,%22cumTestsByPublishDate%22:%22cumTestsByPublishDate%22%7D&format=csv'

    uk_cases <- data.table::fread(uk_cases_url)
    uk_tests <- data.table::fread(uk_tests_url)

    names(uk_cases) <- snakecase::to_snake_case(names(uk_cases))
    names(uk_tests) <- snakecase::to_snake_case(names(uk_tests))

    uk <- merge(uk_cases, uk_tests, by = 'date')

    uk$cases_per_test <- uk$new_cases_by_publish_date/uk$new_tests_by_publish_date

    uk$average_cases <- ma(uk$new_cases_by_publish_date)
    uk$average_tests <- ma(uk$new_tests_by_publish_date)
    uk$rolling_average_cases_per_test <- uk$average_cases/uk$average_tests

    uk <- uk[,c('date', 
                'new_cases_by_publish_date',
                'new_tests_by_publish_date',
                'cases_per_test',
                'rolling_average_cases_per_test')]

    names(uk) <- c('date', 
                'cases',
                'tests',
                'cases_per_test',
                'rolling_average_cases_per_test')

    return(uk)
}


build_plot <- function(uk){
    ggplot(data = uk) + 
        geom_line(aes(date, rolling_average_cases_per_test), na.rm = TRUE,
                col = '#2489CF', lwd = 1) +
        geom_point(aes(date, cases_per_test), na.rm = TRUE) + 
        theme_minimal() + 
        xlab('Date') + 
        ylab('Cases per Test')  + 
        theme(text = element_text(size=20))
}

