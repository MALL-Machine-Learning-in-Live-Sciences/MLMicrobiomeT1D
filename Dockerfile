FROM rocker/shiny:4.1.0
LABEL mlmicrobiomet1d.authors="carlos.fernandez@udc.es"

RUN apt-get update && apt-get -y install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev \
&& rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages(c("shiny", "shinydashboard", "plyr", "tidyverse","ggpubr","reshape","RColorBrewer", "repr", "plotly" ))'
RUN Rscript -e 'install.packages("remotes"); library(remotes); install_version("shinydashboardPlus", version = "0.7.5")'

COPY /ShinyApp ./app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]