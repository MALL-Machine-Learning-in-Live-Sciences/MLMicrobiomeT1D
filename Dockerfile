# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update && apt-get -y install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean



# install renv & restore packages
RUN Rscript -e 'install.packages(c("shiny", "shinydashboard", "plyr", "tidyverse","ggpubr","reshape","RColorBrewer", "repr", "plotly" ))'
RUN Rscript -e 'install.packages("remotes"); library(remotes); install_version("shinydashboardPlus", version = "0.7.5")'

COPY /ShinyApp ./app

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]