#### Prueba Shiny ######
#Despues copiar y pegar en la consola des aqui hasta abajo#

ui <- dashboardPagePlus(skin = "blue",
                        dashboardHeaderPlus( title = tagList(
                          span(class = "logo-lg", "MLMetaGenomics"), 
                          img(src = "algoritmo.svg", width="35",height="35"))),
                        
                        
                        dashboardSidebar(
                          sidebarMenu(id = "MENU",
                                                     menuItem("Cover", tabName = "portada", icon = icon("couch"),selected = TRUE),
                                                     menuItem("Basal Experiment", tabName = "benchmark", icon = icon("database")),
                                                     menuItem("FS Models", tabName = "modelos", icon = icon("dashboard"),
                                                              menuSubItem(text = "Phylum", tabName = "filo"),
                                                              menuSubItem(text = "Class", tabName = "clase"),
                                                              menuSubItem(text = "Order", tabName = "orden"),
                                                              menuSubItem(text = "Family", tabName = "familia"),
                                                              menuSubItem(text = "Genus", tabName = "genero"),
                                                              menuSubItem(text = "Species", tabName = "especie"),
                                                              startExpanded = TRUE),
                                                     menuItem("Best Model", tabName = "best", icon = icon("chart-pie"),
                                                              menuSubItem(text = "Performance",tabName = "mejor" ),
                                                              menuSubItem(text = "Importance and abundances ", tabName = "discusion"),
                                                              menuSubItem(text = "Relative Abundances", tabName = "abundancias"),
                                                              startExpanded = TRUE),
                                                     menuItem("Seroconverted Prediction", tabName = "validation", icon = icon("check-double")),
                                                     menuItem("About", tabName = "About", icon = icon("users"))
                        )),
                        dashboardBody(
                          tabItems(
                  #PORTADA#
                            
                            tabItem(tabName = "portada",
                                    h2("Machine Learning analysis of the human infant gut microbiome identifies influential species in type 1 diabetes",align = "justify"),
                                    hr(),
                                    h4("Abstract"),
                                    p("Diabetes is a disease that is closely linked to genetics and epigenetics, yet sometimes the mechanisms for clarifying the onset and/or
                                      progression of the disease have not been fully managed. In recent years and due to the large number of recent studies, it is known that
                                      changes in the balance of the microbiota can cause a high battery of diseases, including diabetes. Machine Learning (ML) techniques are
                                      able to identify complex, non-linear patterns of expression and relationships within the data to extract intrinsic knowledge without any
                                      biological assumptions about the data. At the same time, mass sequencing techniques allow us to obtain the metagenomic profile of an
                                      individual, whether it is a body part, organ or tissue, thus being able to identify the composition of a given microbiota.",br(), "The great
                                      increase in the development of both technologies in their respective fields of study leads to the logical union of both to try to identify
                                      the basis of a complex disease such as diabetes. For this purpose, a Random Forest model has been developed at different taxonomic levels
                                      obtaining results above 0.80 in AUC for family and above 0.98 at specie level following a strict experimental design to ensure the comparison
                                      of results under equal conditions. It is identified how, in newborns, the species Bacteroides uniformis, Bacteroides dorei and Bacteroides
                                      thetaiotaomicron are reduced in the microbiota of infants with T1D, while the populations of Prevotella copri increase slightly and that of
                                      Bacteroides vulgatus is much higher. Finally, thanks to the more specific metagenomic signature at specie level, a model has been generated
                                      to predict those seroconverted patients not previously diagnosed with diabetes but who have expressed at least two of the autoantibodies analyzed.",align = "justify"),
                                    br(),
                                    h4("Graphical Abstract"),
                                      img(src="GraphicalAbstract.png", align = "justify",height = 562, width = 1000)),
                            tabItem(tabName = "benchmark",
                                    box(title = " ", status = "primary", solidHeader = TRUE, width = 12,
                                        plotlyOutput("SinFS")), 
                                    box(title = "Parameters", status = "info", solidHeader = TRUE,
                                        radioButtons("butsinfs", "Performance measures:", choices = c('AUC','ACC','MMCE'),inline = TRUE),width = 6),
                                    box(
                                      title = " ", status = "warning", solidHeader = TRUE,
                                      "As a basal experiment, the three ML models (SVM, RF and glmnet) were trained with the data of each one of the six taxonomic levels:
                                      phylum (5 features), class (11 features), order (15 features), family (25 features), genus (45 features) and species (102 features).",
                                      br(), "It is interesting to stop at the taxonomic level in which the three algorithms begin to present good yields. In the case of RF,
                                      it is from the family level, with a 0.82 in AUC, where it is considered that it is capable of classifying the two classes of patients,
                                      until reaching a 0.987 in AUC at the species level.  As for the other two algorithms, glmnet and SVM, both present very similar results.
                                      In this case, the two algorithms begin to present significant results at the species level, not being able to model the data at the family
                                      or genus level, not as in the case of RF. In addition, their best results at the species level are comparable to the results obtained by RF
                                      at the family level.", br(), "The results shown here suggest and encourage further analysis of the species taxonomic level, due to their
                                      good performance with the three algorithms used. For this purpose, a search and selection of the best characteristics within this abundance
                                      matrix will be carried out using FS techniques")),
          
                            
                            tabItem(tabName = "filo",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 12,
                                          plotlyOutput("plot1")),
                                      box(title = "Parameters", status = "info", solidHeader = TRUE,
                                        radioButtons("dataf", "Performance measures:", choices = c('AUC','ACC','MMCE'),inline = TRUE),hr(),
                                        radioButtons("FiloAlg", "Choose algorithm:", choices = c('RF','SVM','GLMNET', "Comparison"),inline = TRUE),hr(),
                                          sliderInput(inputId = "ff",
                                                              label = "Choose number of features:",
                                                              min = 1,
                                                              max = 5,
                                                              step=1,
                                                              value=c(1,2)),width = 6),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "We can see how Random Forest achieves better results in all measures (0.65 in AUC and ACC) of performance, although nothing significant,
                                        and at first sight we can see how there is no significant difference between the algorithms used. In addition we observe how the measures
                                        are stabilized. ", br())
                                      
                                      
                                    )),
                            tabItem(tabName = "clase",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 12,
                                          plotlyOutput("plot2")),
                                      box(title = "Parameters", status = "info", solidHeader = TRUE,
                                          radioButtons("datac", "Performance measures:", choices = c('AUC','ACC','MMCE'), inline = TRUE),hr(),
                                          radioButtons("ClaseAlg", "Choose algorithm:", choices = c('RF','SVM','GLMNET', "Comparison"),inline = TRUE),hr(),
                                          sliderInput(inputId = "fc",
                                                      label = "Choose number of features:",
                                                      min = 1,
                                                      max = 11,
                                                      step=1,
                                                      value=c(1,2)), width = 6),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "We can see that Random Forest achieves the best performance values as the differences between algorithms at the class level are not very 
                                        significant since there are hardly any differences in the values obtained between algorithms along the number of features used, furthermore
                                        no significant values are obtained either.", br())
                                      )),
                            tabItem(tabName = "orden",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 12,
                                          plotlyOutput("plot3")),
                                      box(title = "Parameters", status = "info", solidHeader = TRUE,
                                          radioButtons("datao", "Performance measures:", choices = c('AUC','ACC','MMCE'), inline = TRUE),hr(),
                                          radioButtons("OrdenAlg", "Choose algorithm:", choices = c('RF','SVM','GLMNET', "Comparison"),inline = TRUE),hr(),
                                          sliderInput(inputId = "fo",
                                                      label = "Choose number of features:",
                                                      min = 1,
                                                      max = 15,
                                                      step=1,
                                                      value=c(1,2)),width = 6),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "It continues with the dynamics of the previous level since the differences between algorithms at the level of order are not very
                                        significant since there are hardly different in the values obtained between algorithms along the number of features used, in addition
                                        neither significant values are obtained.", br())
                                    )),
                            tabItem(tabName = "familia",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 12,
                                          plotlyOutput("plot4")),
                                      box(title = "Parameters", status = "info", solidHeader = TRUE,
                                          radioButtons("datafa", "Performance measures:", choices = c('AUC','ACC','MMCE'), inline = TRUE),hr(),
                                          radioButtons("FamiliaAlg", "Choose algorithm:", choices = c('RF','SVM','GLMNET', "Comparison"),inline = TRUE),hr(),
                                          sliderInput(inputId = "ffa",
                                                      label = "Choose number of features:",
                                                      min = 1,
                                                      max = 25,
                                                      step=1,
                                                      value=c(1,2)), width = 6),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "From this level we can see how Random Forest reaches much higher values in ACC and AUC, reaching already significant values that
                                        exceed 0.80, while GLMNET and SVM stay around 0.60. We also see how Random Forest's MMCE declines significantly at this level, below 0.30.", br())
                                    )),
                            tabItem(tabName = "genero",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 12,
                                          plotlyOutput("plot5"))
                                    ),
                                    fluidRow(
                                      box(title = "Parameters", status = "info", solidHeader = TRUE,
                                          radioButtons("datag", "Performance measures:", choices = c('AUC','ACC','MMCE'), inline = TRUE),hr(),
                                          radioButtons("GeneroAlg", "Choose algorithm:", choices = c('RF','SVM','GLMNET', "Comparison"),inline = TRUE),hr(),
                                          sliderInput(inputId = "fg",
                                                      label = "Choose number of features:",
                                                      min = 1,
                                                      max = 45,
                                                      step=1,
                                                      value=c(1,2)), width = 6),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "The differences between Random Forest and the rest of the algorithms are increasing, reaching significant values in ACC and AUC
                                        that exceed 0.90, in addition the MMCE declines to 0.20. The rest of the algorithms maintain the results of the previous level.", br())
                                    )),
                            tabItem(tabName = "especie",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 12,
                                          plotlyOutput("plot6"))
                                    ),
                                    fluidRow(
                                      box(title = "Parameters", status = "info", solidHeader = TRUE,
                                          radioButtons("datas", "Performance measures:", choices = c('AUC','ACC','MMCE'), inline = TRUE),hr(),
                                          radioButtons("EspecieAlg", "Choose algorithm:", choices = c('RF','SVM','GLMNET', "Comparison"),inline = TRUE),hr(),
                                          sliderInput(inputId = "fs",
                                                      label = "Choose number of features:",
                                                      min = 1,
                                                      max = 102,
                                                      step=1,
                                                      value=c(1,2)),width = 6),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "At this level GLMNET and SVM already reach significant values, around 0.80 and MMCE over 0.20, results almost similar to those achieved
                                        by Random Forest at the Family level. The latter reaches an almost perfect ACC and AUC, and MMCE almost 0.", br())
                                    )),
                            tabItem(tabName = "discusion",
                                    fluidRow(
                                      box(title = "Parameters",status = "info", solidHeader = TRUE,width = 4,
                                          sliderInput(inputId = "vi",
                                                      label = "Choose number of species:",
                                                      min = 1,
                                                      max = 25,
                                                      step = 1,
                                                      value=c(1,2)),hr(),
                                          radioButtons("selection", "Taxonomic ranks:", choices = c('Phylum','Class','Order', "Family", "Genus"), inline = TRUE),
                                          p("According to the previous section, a model with a metagenomic signature of 25 characteristics was chosen, since, although a stability
                                            of the model is observed from the 15 characteristics, the objective was to analyze a wider and heterogeneous signature, for a biological
                                            discussion of the results and the search for new species that could be related to the disease. In order to observe which characteristics
                                            were given more importance by the model, a analysis of their importance. In the figure on the right, the importance of each species is 
                                            represented for the model. The figure shows a species that predominates over the rest, Bacteroides uniformis. There are 4 others that have
                                            a great importance in comparison to the rest, Bacteroides dorei, Prevotella copri, Bacteroides vulgatus and Bacteroides thetaiotaomicron.")),
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 8,height = "400px",
                                          plotOutput("plotvi"))
                                    ),
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 6,
                                          plotOutput("plot7")),
                                      box(title = " ", status = "primary", solidHeader = TRUE,width = 6,
                                          plotOutput("plot8"))
                                      
                                    )),
                            tabItem(tabName = "abundancias",
                                    fluidRow(
                                      box(title = " ", status = "primary", solidHeader = TRUE,plotOutput("plotAbundancias"))),
                                    fluidRow(
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "The abundances of the species belonging to the best model are shown according to whether they are controls or have T1D, in addition, a Wilcoxon
                                        test was carried out to compare the populations of both and to check if they had significant differences. When comparing the results shown in this 
                                        figure with those shown in the previous graph of Variable Importance, it can be seen that the species that present more importance in the ML model,
                                        such as Bacteroides uniformis, Bacteroides dorei and Bacteroides thetaiotaomicron are reduced in the microbiota of the T1D patients, while the populations
                                        of Prevotella copri increase slightly and Bacteroides vulgatus is much greater. We can also observe in some species that the great majority of the
                                        samples present values equal to or very close to zero, but that the samples that present very significant differences to the average belong to a specific
                                        class. This fact, which can be observed in species such as Odoribacter splanchnicus, Eubacterium rectale or Bifidobacterium adolescentis, which indicates 
                                        the ability of the model to find variables that, although not significant with respect to the dependent variable, may be important in the development of
                                        the disease.", br()))
                                    ),
                            
                            tabItem(tabName = "mejor",
                                    fluidRow(
                                      box(title = " ", status = "info", solidHeader = TRUE, width = 6,
                                          plotOutput("plotMejor")
                                      ),
                                      box(title = " ", status = "info", solidHeader = TRUE, width = 6,
                                          plotlyOutput("plotFSMejor")),
                                      
                                      box(title = "Parameters", status = "info", solidHeader = TRUE, width = 4,
                                          radioButtons("mejor", "Performance measures", choices = c('AUC','ACC','MMCE'), inline = TRUE)
                                      ),
                                      box(
                                        title = " ", status = "warning", solidHeader = TRUE,
                                        "For Random Forest it was decided to keep 25 features, for the SVM model 28 features and for GLMNET it was 15 features. It is 
                                        interesting to know if Random Forest's model, besides being better in average performance, is significantly better than the other two models.
                                        For this purpose, a comparison was made and the performance measures of the three models are represented in the box diagram. It can be seen that
                                        Random Forest's algorithm is the most stable among the three, obtaining all the measures very close to one and MMCE almost 0. In addition, a multiple 
                                        comparison test was performed, as the Wilcoxon test, for three or more paired groups, and a significance value of 0.0079 is observed between the distribution
                                        of the yields of Random Forest and the other two, while there are no significant differences between Random Forest and SVM since they have a p-value of 0.69 and 
                                        we can observe how the values of AUC and ACC of Random Forest have very little dispersion since they go from 0.97 to 0.99.", br())
                                    )),
                            tabItem(tabName = "validation",
                                    fluidRow(
                                      box(title = " ", status = "info", solidHeader = TRUE, width = 6,
                                          plotOutput("plotacc")),
                                      box(title = " ", status = "warning", solidHeader = TRUE,
                                          "There are patients who have not been clinically diagnosed with PID but have expressed at least two of the autoantibodies analyzed.
                                          These patients, called seroconverts, have a predisposition to present at some time PID but belong to an intermediate class between 
                                          healthy and sick. It is interesting to know if our metagenomic signature is capable of identifying this subgroup of patients, which 
                                          will have different treatment routes after their diagnosis. For this purpose, the patients were re-labelled in three classes (controls,
                                          seroconverts and patients). Then, the selected metagenomic signature was defined and 90% of the samples were used for the training of a 
                                          new Random Forest algorithm. The results of the training, following the same methodology as in the previous section, except that, in the
                                          external validation, 2 repetitions of a 10-fold CV were carried out instead of 5. A quite high and stable performance of the model in terms
                                          of ACC is observed, between values 0.93 and 0.94. The remaining 10% of the samples were used as test for the predictions of the model. The
                                          model, in this case, was able to classify all the samples correctly.")
                                          
                                    )),
                            tabItem(tabName = "About",
                                    h4("About this project"),
                                    p("This Shiny was created for the visualization of the data obtained in the project carried out by the authors and published as an article under
                                      the title 'Machine Learning analysis of the human infant gut microbiome identifies influential species in type 1 diabetes'. In this article we 
                                      wanted to test the ability of a Machine Learning model based on metagenomic data to stratify infants at risk of having type 1 diabetes (T1D)
                                      in healthy and sick children." ,align = "justify"),
                                    p("In this Shiny we find a first section that corresponds to the cover where we can observe the summary of the published article as well as a presentation of the authors.
                                    In the second section, a basal experiment was carried out to evaluate at what taxonomic level we would focus the study, although later all of them were analyzed.
                                    In the third section a 'Feature Selection' process was carried out at all taxonomic levels to see how it influenced the performance of the models.
                                    In the fourth section, a multimodal analysis of the model that had obtained the best performance and a review of the species used by it ('Metagenomic signature') was carried out.
                                    In the last section it is shown that the metagenomic signature obtained also with the best model is also capable of discerning between a third stage between healthy and sick called 'seroconversion'.", align= "justify"),
                                    h4("Code"),
                                    "The code used in the project is available on the",a(href= "https://github.com/DiegoFE94/MLMetaGenomics", "GitHub."),
                                    br(),
                                    "The code of this Shiny is available on the ",a(href= "https://github.com/DiegoFE94/ShinyMLMetagenomics", "GitHub."),
                                    h4("Data source"),
                                    p("The data were taken from the",a(href= "https://diabimmune.broadinstitute.org/diabimmune/t1d-cohort", "Diabinmune"),"project, which consists of a public database of faecal metagenomic
                                      profiles from sequencing of the 16S rRNA region. The dataset includes 124 faecal samples with the metagenomic profile of infants",align = "justify"),
                                    h4("Authors"),
                                    widgetUserBox(
                                      title = "Diego Fernández",
                                      subtitle ="Bioinformatician", 
                                      width = 4,
                                      collapsible = FALSE,
                                      type = NULL,
                                      src = "DF.jpeg",
                                      color = "red",     
                                      socialButton(
                                        url = "https://github.com/DiegoFE94",
                                        type = "github"),
                                      socialButton(
                                        url = "https://www.linkedin.com/in/diego-fernández-edreira-a2a4391b9/",
                                        type = "linkedin"),
                                      footer = "I´m a MSc bioinformatician at  University of A Coruña. Interested in computer science and 
                                      multi-omics data analysis using Machine Learning.." 
                                    ),
                                    widgetUserBox(
                                      title = "Jose Liñares",
                                      subtitle = "Predoctoral research",
                                      width = 4,
                                      collapsible = FALSE,
                                      type = NULL,
                                      src = "JL.jpeg",
                                      color = "blue",
                                      socialButton(
                                        url = "https://github.com/jlinaresb",
                                        type = "github"),
                                      socialButton(
                                        url = "https://www.linkedin.com/in/jose-liñares-blanco-796608132/",
                                        type = "linkedin"),
                                      footer = "I´m a predoc student undertaking a PhD at the Univeristy of A Coruña and
                                      affiliated researcher of the Centre of Information and Communications Technology
                                      Research (CITIC) studying computer science, genetics and machine learning with a particular focus on Cancer."
                                    ),
                                    widgetUserBox(
                                      title = "Carlos Fernández",
                                      subtitle = "Assistant Professor",
                                      width = 4,
                                      collapsible = FALSE,
                                      type = NULL,
                                      src = "CL.jpeg",
                                      color = "green",
                                      socialButton(
                                        url = "https://github.com/cafernandezlo",
                                        type = "github"),
                                      socialButton(
                                        url = "https://www.linkedin.com/in/cafernandezlo/",
                                        type = "linkedin"),
                                      footer ="I´m assistant professor in Bioinformatics and Intelligent Systems at the 
                                      University of A Coruña and affiliated researcher of the Institute of Biomedical
                                      Research of A Coruña (INIBIC) and of the Centre for Information and Communications 
                                      Technology Research (CITIC). My primary research interest is the understanding of
                                      the behaviour and biological mechanisms of complex system dynamics using machine
                                      learning and the molecular pathways and connections underpinning Cancer Disease."
                                  ),
                                  br(),
                                  br(),
                                  h4("Contacto"),
                                  "diego.fedreira@udc.es",
                                  br(),
                                  a(img(src = "kk.png"),href="https://www.udc.es/es/" )
                            
                          )
                        )
))