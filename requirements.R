packages <- c('shiny',
            'data.table',
            'snakecase',
            'ggplot2',
            'DT')

install.packages(
    packages[!(packages %in% installed.packages()[,'Package'])]
)