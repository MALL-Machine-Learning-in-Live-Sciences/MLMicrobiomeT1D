# Machine Learning analysis of the human infant gut microbiome identifies influential species in type 1 diabetes

![alt text](https://github.com/cafernandezlo/MLMicrobiomeT1D/blob/master/GraphicalAbstract.png?raw=true)

## Citation

*Machine learning analysis of the human infant gut microbiome identifies influential species in type 1 diabetes
Fernández-Edreira, D., Liñares-Blanco, J., and Fernandez-Lozano, C.
Expert Systems with Applications 2021 . [Q1, D1, 8/87 OR-MS, 21/145 CS-AI, 8.665 IF]*

DOI: http://dx.doi.org/10.1016/j.eswa.2021.115648

```tex
@ARTICLE{experSytems2021,
title={Machine learning analysis of the human infant gut microbiome identifies influential species >
ISSN={0957-4174},
doi={10.1016/j.eswa.2021.115648},
number={115648},
journal={Expert Systems with Applications},
publisher={Elsevier},
author={Fernández-Edreira, D. and Liñares-Blanco, J. and Fernandez-Lozano, C.},
year={2021},
month={Jul},
pages={13},
note={Q1, <strong>D1</strong>, 8/87 OR-MS, 21/145 CS-AI, 8.665 IF}
}
```

## Data

The data used in this work was downloaded from the [DIABIMMNUE](https://diabimmune.broadinstitute.org/diabimmune) project. This project, financed by the European Union through the H2020 initiative in 2016, was set up with the aim of testing the hygiene hypothesis and its role in the development of T1D. For this study, the T1D cohort was used, which aims to compare the microbiome of infants who have developed T1D with healthy controls from the same geographical area. Fecal samples were extracted from each individual and ribosomal 16S RNA sequencing was performed to characterize the metagenomic profile. For this study, data on the relative abundance of each operative taxonomic unit (OTU) of the different infants that make up the cohort were downloaded. The samples have been labelled according to patients and T1D controls. In total, 124 samples have been included for analysis, from a total of 33 infants.

## Abstract
Diabetes is a disease that is closely linked to genetics and epigenetics, yet mechanisms for clarifying the onset and/or progression of the disease have sometimes not been fully managed. In recent years and due to the large number of recent studies, it is known that changes in the balance of the microbiota can cause a high battery of diseases, including diabetes. Machine Learning (ML) techniques are able to identify complex, non-linear patterns of expression and relationships within the data set to extract intrinsic knowledge without any biological assumptions about the data. At the same time, mass sequencing techniques allow us to obtain the metagenomic profile of an individual, whether it is a body part, organ or tissue, and thus identify the composition of a given microbe. The great increase in the development of both technologies in their respective fields of study leads to the logical union of both to try to identify the bases of a complex disease such as diabetes. To this end, a Random Forest model has been developed at different taxonomic levels, obtaining results above 0.80 in AUC for families and above 0.98 at species level, following a strict experimental design to ensure that results are compared under equal conditions. It is identified how, in infants, the species Bacteroides uniformis, Bacteroides dorei and Bacteroides thetaiotaomicron are reduced in the microbiota of those with T1D, while, the populations of Prevotella copri increase slightly and that of Bacteroides vulgatus is much higher. Finally, thanks to the more specific metagenomic signature at species level, a model has been generated to predict those seroconverted patients not previously diagnosed with diabetes but who have expressed at least two of the autoantibodies analysed.

## Highlights

* A Machine Learning methodology is proposed for the modelling of metagenomic data and the diagnosis of T1D infants.
* A new metagenomic signature was obtained highly correlated with T1D diagnosis.
* Machine Learning algorithms are able to obtain great results with sparse metagenomic data.

### R code. Prerequisites:

R code of the experiments is included in the repo. 

Both R and Rstudio are available and runs on Windows, Linux and macOS.

* [R](https://www.r-project.org/)
* [RStudio](https://rstudio.com/products/rstudio/)

[R](https://www.r-project.org/) is a free software environment for statistical computing and graphics.

[RStudio](https://rstudio.com/products/rstudio/) s an integrated development environment (IDE) for R. RStudio requires a 64-bit operating systems (use older versions if you are on a 32 bit system) and is available **open source**.

**R** and **RStudio** are separate downloads and installations. R is the underlying statistical computing environment. The base R system and a very large collection of packages that give you access to a huge range of statistical and analytical functionality are available from [CRAN](https://cran.r-project.org/), the Comprehensive R Archive Network. However, using R alone is no fun. RStudio is a graphical integrated development environment (IDE) that makes using R much easier and more interactive. You need to install R before you install RStudio. If you already have R and RStudio installed, please open RStudio and check for updates. If a new version is available, quit RStudio, and download de latest version for RStudio.

To check the R version you are using start RStudio and the first thing that appears on the console is the R version of the system. Go on the [CRAN website](https://cran.r-project.org/bin/) and check whether a more recent version is available. If so, please download and install it.

Some prerequisites in order to reproduce our results are the following packages:

```{r}
install.packages(c("ggplot2", "mlr", "dplyr", "parallelMap", "stringr", "caret"))
```


# Shiny

We enclosed the results as an open source web application using R and Shiny in order to facilitate the interactive analysis of the results.

![alt text](https://github.com/cafernandezlo/MLMicrobiomeT1D/blob/master/MLMicrobiomeT1D.png?raw=true)

## Shiny. Prerequisites:

R code of the shiny is on the repo too. In this case, we supposed that R and RStudio are installed on your local systems as indicated before. Some prerequisites in order to reproduce our results are the following packages:

```{r}
install.packages(c("shiny", "shinydashboard", "shinydashboardPlus", "plyr", "tidyverse",
"ggpubr", "reshape","RColorBrewer", "repr", "plotly" ))
```

# Docker

We also provided a Docker image which enables an easy distribution and exploration of the results on local systems without package instalation. The docker image is available on Docker Hub [here](https://hub.docker.com/r/cafernandezlo/mlmicrobiomet1d).

## Prerequisites:

In order to use the Docker image please ensure that you have installed the following:

* [Docker](https://docs.docker.com/get-docker/)

Follow the instructions on Docker Hub in order to generate de Docker image and run it on your local system.

# Questions?
If you have any questions, please feel free to contact us!
