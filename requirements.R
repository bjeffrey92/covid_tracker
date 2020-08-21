packages <- c('shiny',
            'data.table',
            'snakecase',
            'ggplot2')

install.packages(
    packages[!(packages %in% installed.packages()[,'Package'])]
)