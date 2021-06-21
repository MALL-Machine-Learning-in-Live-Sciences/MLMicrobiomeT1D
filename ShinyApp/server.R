server <- function(input, output) {

  ################### EXPERIMENTO BASAL #######################
  ################### EXPERIMENTO BASAL #######################
  ################### EXPERIMENTO BASAL #######################
  
  output$SinFS <- renderPlotly({
    
    if (input$butsinfs == "AUC")
      ggplotly(ggplot(SinFS, aes(x =Nivel, y = AUC, color = Algorithm, shape = Algorithm, text=paste0("Algorithm: ",Algorithm, "\n","Rank: ", Nivel,"\n","AUC: ",AUC))) + 
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE) +
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))

      
    else if(input$butsinfs== "ACC")
      ggplotly(ggplot(SinFS, aes(x =Nivel, y = ACC,color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","Rank: ", Nivel,"\n","ACC: ",ACC))) + 
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE) + 
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
    
    else if(input$butsinfs== "MMCE")
      ggplotly(ggplot(SinFS, aes(x =Nivel, y = MMCE,color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","Rank: ", Nivel,"\n","MMCE: ",MMCE))) + 
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE) +
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
    
    
  })
  
  ################### Modelos Feature Selection #######################
  ################### Modelos Feature Selection #######################
  ################### Modelos Feature Selection #######################
  
  ################### FILO #######################
  
    datfRF <- reactive({
      test <- FiloRF[FiloRF$N.Feat %in% seq(from=min(input$ff),to=max(input$ff),by=1),]
      print(test)
      test
    })
  
    datfSVM <- reactive({
      test <- FiloSVM[FiloSVM$N.Feat %in% seq(from=min(input$ff),to=max(input$ff),by=1),]
      print(test)
      test
    })
  
    datfGLMNET <- reactive({
      test <- FiloGLMNET[FiloGLMNET$N.Feat %in% seq(from=min(input$ff),to=max(input$ff),by=1),]
      print(test)
      test
    })

  datf <- reactive({
      test <- ShinyFilo[ShinyFilo$N.Feat %in% seq(from=min(input$ff),to=max(input$ff),by=1),]
      print(test)
      test
    })
  
  output$plot1<-renderPlotly({
    
    if (input$FiloAlg == "RF")
      ggplotly(ggplot(datfRF(),aes_string(x='N.Feat', y=input$dataf))+
      geom_line(color = "green3")+
      geom_point(color = "green3", shape = 17, size = 3))
    
    else if(input$FiloAlg == "GLMNET")
      ggplotly(ggplot(datfGLMNET(),aes_string(x='N.Feat', y=input$dataf ))+
      geom_line(color = "red")+
      geom_point(color = "red", shape = 16, size = 3))
    
    else if(input$FiloAlg == "SVM")
      ggplotly(ggplot(datfSVM(),aes_string(x='N.Feat', y=input$dataf ))+
      geom_line(color = "dodgerblue2")+
      geom_point(color = "dodgerblue2", shape = 15))
      
    else if (input$FiloAlg == "Comparison")
      if (input$dataf == "AUC")
        ggplotly(ggplot(datf(),aes(x=N.Feat, y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",AUC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$dataf == "ACC")
        ggplotly(ggplot(datf(),aes(x=N.Feat, y=ACC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","ACC: ",ACC)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$dataf == "MMCE")
        ggplotly(ggplot(datf(),aes(x=N.Feat, y=MMCE, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","MMCE: ",MMCE)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      })

  
  ################### CLASE #######################
  datcRF <- reactive({
    test <- ClaseRF[ClaseRF$N.Feat %in% seq(from=min(input$fc),to=max(input$fc),by=1),]
    print(test)
    test
  })
  datcSVM <- reactive({
    test <- ClaseSVM[ClaseSVM$N.Feat %in% seq(from=min(input$fc),to=max(input$fc),by=1),]
    print(test)
    test
  })
  datcGLMNET <- reactive({
    test <- ClaseGLMNET[ClaseGLMNET$N.Feat %in% seq(from=min(input$fc),to=max(input$fc),by=1),]
    print(test)
    test
  })
  datc <- reactive({
    test <- ShinyClase[ShinyClase$N.Feat %in% seq(from=min(input$fc),to=max(input$fc),by=1),]
    print(test)
    test
  })
  
  output$plot2<-renderPlotly({
    
    if (input$ClaseAlg == "RF")
      ggplotly(ggplot(datcRF(),aes_string(x='N.Feat', y=input$datac ))+
      geom_line(color = "green3")+
      geom_point(color = "green3", shape = 17, size = 3))
    
    else if(input$ClaseAlg == "GLMNET")
      ggplotly(ggplot(datcGLMNET(),aes_string(x='N.Feat', y=input$datac ))+
      geom_line(color = "red")+
      geom_point(color = "red", shape = 16, size = 3))
    
    else if(input$ClaseAlg == "SVM")
      ggplotly(ggplot(datcSVM(),aes_string(x='N.Feat', y=input$datac ))+
      geom_line(color = "dodgerblue2")+
      geom_point(color = "dodgerblue2", shape = 15))
    
    else if (input$ClaseAlg == "Comparison")
      if (input$datac == "AUC")
        ggplotly(ggplot(datc(),aes(x=N.Feat,y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",AUC)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datac == "ACC")
        ggplotly(ggplot(datc(),aes(x=N.Feat,y=ACC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","ACC: ",ACC)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datac == "MMCE")
        ggplotly(ggplot(datc(),aes(x=N.Feat,y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","MMCE: ",MMCE)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      })
  
  
  ############### ORDEN ##############
  
  
  datoRF <- reactive({
    test <- OrdenRF[OrdenRF$N.Feat %in% seq(from=min(input$fo),to=max(input$fo),by=1),]
    print(test)
    test
  })
  datoSVM <- reactive({
    test <- OrdenSVM[OrdenSVM$N.Feat %in% seq(from=min(input$fo),to=max(input$fo),by=1),]
    print(test)
    test
  })
  datoGLMNET <- reactive({
    test <- OrdenGLMNET[OrdenGLMNET$N.Feat %in% seq(from=min(input$fo),to=max(input$fo),by=1),]
    print(test)
    test
  })
  dato <- reactive({
    test <- ShinyOrden[ShinyOrden$N.Feat %in% seq(from=min(input$fo),to=max(input$fo),by=1),]
    print(test)
    test
  })
  
  output$plot3<-renderPlotly({
    
    if (input$OrdenAlg == "RF")
      ggplotly(ggplot(datoRF(),aes_string(x='N.Feat', y=input$datao))+
      geom_line(color = "green3")+
      geom_point(color = "green3", shape = 17, size = 3))
    
    else if(input$OrdenAlg == "GLMNET")
      ggplotly(ggplot(datoGLMNET(),aes_string(x='N.Feat', y=input$datao ))+
      geom_line(color = "red")+
      geom_point(color = "red", shape = 16, size = 3))
    
    else if(input$OrdenAlg == "SVM")
      ggplotly(ggplot(datoSVM(),aes_string(x='N.Feat', y=input$datao ))+
      geom_line(color = "dodgerblue2")+
      geom_point(color = "dodgerblue2", shape = 15))
    
    else if (input$OrdenAlg == "Comparison")
      if (input$datao =="AUC")
        ggplotly(ggplot(dato(),aes(x=N.Feat, y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",AUC)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datao == "ACC")
        ggplotly(ggplot(dato(),aes(x=N.Feat, y=ACC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","ACC: ",ACC)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
     else if (input$datao == "MMCE")
       ggplotly(ggplot(dato(),aes(x=N.Feat, y=MMCE, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","MMCE: ",MMCE)))+
                   geom_point(show.legend = FALSE) + 
                   geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                   theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
    
    })
  
  ############### FAMILIA ##############
  
  
  
  datfaRF <- reactive({
    test <- FamiliaRF[FamiliaRF$N.Feat %in% seq(from=min(input$ffa),to=max(input$ffa),by=1),]
    print(test)
    test
  })
  datfaSVM <- reactive({
    test <- FamiliaSVM[FamiliaSVM$N.Feat %in% seq(from=min(input$ffa),to=max(input$ffa),by=1),]
    print(test)
    test
  })
  datfaGLMNET <- reactive({
    test <- FamiliaGLMNET[FamiliaGLMNET$N.Feat %in% seq(from=min(input$ffa),to=max(input$ffa),by=1),]
    print(test)
    test
  })
  
  datfa <- reactive({
    test <- ShinyFamilia[ShinyFamilia$N.Feat %in% seq(from=min(input$ffa),to=max(input$ffa),by=1),]
    print(test)
    test
  })
  
  output$plot4<-renderPlotly({
    
    if (input$FamiliaAlg == "RF")
      ggplotly(ggplot(datfaRF(),aes_string(x='N.Feat', y=input$datafa))+
      geom_line(color = "green3")+
      geom_point(color = "green3", shape = 17, size = 3))
    
    else if(input$FamiliaAlg == "GLMNET")
      ggplotly(ggplot(datfaGLMNET(),aes_string(x='N.Feat', y=input$datafa ))+
      geom_line(color = "red")+
      geom_point(color = "red", shape = 16, size = 3))
    
    else if(input$FamiliaAlg == "SVM")
      ggplotly(ggplot(datfaSVM(),aes_string(x='N.Feat', y=input$datafa ))+
      geom_line(color = "dodgerblue2")+
      geom_point(color = "dodgerblue2", shape = 15))
    
    else if (input$FamiliaAlg == "Comparison")
      if (input$datafa =="AUC")
        ggplotly(ggplot(datfa(),aes(x=N.Feat, y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",AUC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datafa == "ACC")
        ggplotly(ggplot(datfa(),aes(x=N.Feat, y=ACC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","ACC: ",ACC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datafa == "MMCE")
        ggplotly(ggplot(datfa(),aes(x=N.Feat, y=MMCE, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","MMCE: ",MMCE)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
  
    })
  
  ############### GENERO ##############
  
  
  datgRF <- reactive({
    test <- GeneroRF[GeneroRF$N.Feat %in% seq(from=min(input$fg),to=max(input$fg),by=1),]
    print(test)
    test
  })
  
  datgSVM <- reactive({
    test <- GeneroSVM[GeneroSVM$N.Feat %in% seq(from=min(input$fg),to=max(input$fg),by=1),]
    print(test)
    test
  })
  
  datgGLMNET <- reactive({
    test <- GeneroGLMNET[GeneroGLMNET$N.Feat %in% seq(from=min(input$fg),to=max(input$fg),by=1),]
    print(test)
    test
  })
  
  datg <- reactive({
    test <- ShinyGenero[ShinyGenero$N.Feat %in% seq(from=min(input$fg),to=max(input$fg),by=1),]
    print(test)
    test
  })
  
  output$plot5<-renderPlotly({
    
    if (input$GeneroAlg == "RF")
      ggplotly(ggplot(datgRF(),aes_string(x='N.Feat', y=input$datag))+
      geom_line(color = "green3")+
      geom_point(color = "green3", shape = 17, size = 3))
    
    else if(input$GeneroAlg == "GLMNET")
      ggplotly(ggplot(datgGLMNET(),aes_string(x='N.Feat', y=input$datag ))+
      geom_line(color = "red")+
      geom_point(color = "red", shape = 16, size = 3))
    
    else if(input$GeneroAlg == "SVM")
      ggplotly(ggplot(datgSVM(),aes_string(x='N.Feat', y=input$datag ))+
      geom_line(color = "dodgerblue2")+
      geom_point(color = "dodgerblue2", shape = 15))
    
    else if (input$GeneroAlg == "Comparison")
      if (input$datag == "AUC")
        ggplotly(ggplot(datg(),aes(x=N.Feat,y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",AUC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
    else if (input$datag == "ACC")
      ggplotly(ggplot(datg(),aes(x=N.Feat,y=ACC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","ACC: ",ACC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
    else if (input$datag == "MMCE")
      ggplotly(ggplot(datg(),aes(x=N.Feat,y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","MMCE: ",MMCE)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
   
    })
  ############### ESPECIE ##############
  
  datsRF <- reactive({
    test <- EspecieRF[EspecieRF$N.Feat %in% seq(from=min(input$fs),to=max(input$fs),by=1),]
    print(test)
    test
  })
  
  datsSVM <- reactive({
    test <- EspecieSVM[EspecieSVM$N.Feat %in% seq(from=min(input$fs),to=max(input$fs),by=1),]
    print(test)
    test
  })
  
  datsGLMNET <- reactive({
    test <- EspecieGLMNET[EspecieGLMNET$N.Feat %in% seq(from=min(input$fs),to=max(input$fs),by=1),]
    print(test)
    test
  })
  
  dats <- reactive({
    test <- ShinyEspecie[ShinyEspecie$N.Feat %in% seq(from=min(input$fs),to=max(input$fs),by=1),]
    print(test)
    test
  })
  
  output$plot6<-renderPlotly({
    
    if (input$EspecieAlg == "RF")
      ggplotly(ggplot(datsRF(),aes_string(x='N.Feat', y=input$datas))+
      geom_line(color = "green3")+
      geom_point(color = "green3", shape = 17, size = 3))
    
    else if(input$EspecieAlg == "GLMNET")
      ggplotly(ggplot(datsGLMNET(),aes_string(x='N.Feat', y=input$datas ))+
      geom_line(color = "red")+
      geom_point(color = "red", shape = 16, size = 3))
    
    else if(input$EspecieAlg == "SVM")
      ggplotly(ggplot(datsSVM(),aes_string(x='N.Feat', y=input$datas ))+
      geom_line(color = "dodgerblue2")+
      geom_point(color = "dodgerblue2", shape = 15))
    
    else if (input$EspecieAlg == "Comparison")
      if (input$datas == "AUC")
        ggplotly(ggplot(dats(),aes(x=N.Feat, y=AUC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",AUC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datas == "ACC")
        ggplotly(ggplot(dats(),aes(x=N.Feat, y=ACC, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","ACC: ",ACC)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
      else if (input$datas == "MMCE")
        ggplotly(ggplot(dats(),aes(x=N.Feat, y=MMCE, color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","MMCE: ",MMCE)))+
                 geom_point(show.legend = FALSE) + 
                 geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE)+
                 theme( axis.title.x = element_blank(), axis.ticks.x = element_blank()),tooltip = c("text"))
    
    
    })
  
  ###################  MEJOR MODELO  ###################
  ###################  MEJOR MODELO  ###################
  ###################  MEJOR MODELO  ###################
  ###################  RENDIMIENTO   ###################
  
  my_comparaisons <- list(c("RF", "GLMNET"), c("RF", "SVM"),c("SVM", "GLMNET"))
  output$plotMejor <- renderPlot({
    ggplot(Comparacion, aes_string(x = "Algorithm", y = input$mejor, color = "Algorithm"))+
      geom_jitter()+
      geom_boxplot(aes(fill = Algorithm), notch = F)+
      theme(axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks = element_blank())+
      stat_compare_means(comparisons = my_comparaisons)
  })
    
  output$plotFSMejor <- renderPlotly({
    ggplotly(ggplot(ShinyEspecie, aes(x=N.Feat,y = AUC,color = Algorithm, shape = Algorithm,text=paste0("Algorithm: ",Algorithm, "\n","N.Feat: ", N.Feat,"\n","AUC: ",round(AUC, digits= 3) )))+
                      geom_point(show.legend = FALSE) + 
                      geom_line(aes(group = Algorithm, color = Algorithm),show.legend = FALSE) +
                      
                      geom_vline(xintercept = 15, color = "Red")+
                      
                      geom_vline(xintercept = 25, color = "green3") +
                      
                      geom_vline(xintercept = 28, color = "dodgerblue2")+
                      
                      theme(plot.title = element_text(hjust = 0.5), axis.title.x = element_blank(),axis.ticks.x = element_blank()),tooltip = c("text"))
  })

  
  
  
  
  ################### IMPORTANCIA Y NIVELES TAXONÓMICOS #######################
  
  
  datvi <- reactive({
    test <- ShinyImportance[ShinyImportance2$Nombres %in% seq(from=min(input$vi),to=max(input$vi),by=1),]
    print(test)
    test
  })
  
  output$plotvi<-renderPlot({
    ggplot(datvi(), aes(x=Especies,y=Importancia,fill=Importancia))+
      geom_bar(stat="identity")+theme(legend.position = "none", axis.title.x = element_blank(), axis.ticks.x = element_blank(),axis.title.y  = element_blank())+
      coord_flip()}, height = 348)
  
  #Niveles Taxonomicos Totales#
  
  output$plot7 <- renderPlot({
    
    if(input$selection == "Phylum")
      ggplot(Filos102feat, aes(x="", y=Cantidad, fill=Filo)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Filocolors+
      ggtitle("Total Phyla") +
      theme(plot.title = element_text(hjust = 0.5))

    else if (input$selection == "Class")
      ggplot(Clases102feat, aes(x="", y=Cantidad, fill=Clase)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Clasecolors+
      ggtitle("Total Classes") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Order")
      ggplot(Orden102feat, aes(x="", y=Cantidad, fill=Orden)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Ordencolors+
      ggtitle("Total Orders") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Family")
      ggplot(Familias102feat, aes(x="", y=Cantidad, fill=Familia)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Familiacolors+
      ggtitle("Total Families") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Genus")
      ggplot(Generos102feat, aes(x="", y=Cantidad, fill=Género)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Generocolors+
      ggtitle("Total Genera") +
      theme(plot.title = element_text(hjust = 0.5))
      
      
    })
  
  #Niveles Taxonomicos Feature Selection#
  
  output$plot8 <- renderPlot({
    if(input$selection == "Phylum")
      ggplot(Filos25feat, aes(x="", y=Cantidad, fill=Filo)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Filocolors+
      ggtitle("Post-FS Phyla") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Class")
      ggplot(Clases25feat, aes(x="", y=Cantidad, fill=Clase)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Clasecolors+
      ggtitle("Post-FS Classes") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Order")
      ggplot(Orden25feat, aes(x="", y=Cantidad, fill=Orden)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Ordencolors+
      ggtitle("Post-FS Orders") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Family")
      ggplot(Familias25feat, aes(x="", y=Cantidad, fill=Familia)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Familiacolors+
      ggtitle("Post-FS Families") +
      theme(plot.title = element_text(hjust = 0.5))
    
    else if (input$selection == "Genus")
      ggplot(Generos25feat, aes(x="", y=Cantidad, fill=Género)) +
      geom_bar(stat="identity", width=1, color = "white") +
      coord_polar("y", start=0)+ theme_void() + Generocolors+
      ggtitle("Post-FS Genera") +
      theme(plot.title = element_text(hjust = 0.5))
      
  })
  
  ###################  ABUNDANCIAS RELATIVAS   #######################
  
  output$plotAbundancias<-renderPlot({
    ggplot(data = AbundanciasRelativas, aes(x = meta, y = level)) +
      geom_boxplot(aes(fill=target))+
      facet_wrap( ~ meta, scales = 'free') + stat_compare_means(aes(group = target), label = 'p.format',vjust = 0.7)
    
  })
  
  ###################   PREDICCION SEROCONVERTIDOS ###################
  ###################   PREDICCION SEROCONVERTIDOS ###################
  ###################   PREDICCION SEROCONVERTIDOS ###################
  
 output$plotacc <- renderPlot({
     ggplot(validacion, aes(x = Algorithm, y = ACC, color = Algorithm))+
     geom_boxplot(aes(fill = Algorithm), notch = F)+
     theme(axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks = element_blank())+
     scale_y_continuous(limit = c(0.85,1))
   
 })
 
  
}

