# Use R 4.4.1 minimal image
FROM rocker/r-ver:4.4.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    pandoc \
    libcurl4-openssl-dev \
    libxml2-dev \
    libnode-dev \
    && rm -rf /var/lib/apt/lists/*

# Create project structure
RUN mkdir /project
WORKDIR /project

RUN mkdir Data Reports Output Source renv

# Copy project files
COPY Data/ Data/
COPY Source/ Source/
COPY Reports/DATA550_final_Yutong.Rmd Reports/DATA550_final_Yutong.Rmd
COPY Makefile Makefile
COPY .Rprofile .
COPY renv.lock .
COPY renv/activate.R renv/
COPY renv/settings.json renv/

# Restore R packages
RUN Rscript -e "renv::restore(prompt = FALSE)"
RUN Rscript -e "install.packages('broom', repos = 'https://cloud.r-project.org')"

# Default command to build report
RUN mkdir -p report
CMD make && mv Reports/DATA550_final_Yutong.html report/
