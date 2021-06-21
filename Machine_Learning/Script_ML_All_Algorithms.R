###  Script_Machine_Learning_Todos_Algortimos ###
results = machnlearn(path = "TFM/Datasets_FS/", patron = "DatasetGeneroCase_Control_kruskaltest", outputfile = "TFM/Basura/")
machnlearn = function(path, patron, outputfile){
  #CARGADATOS
  require(mlr)
  l = list.files(path, pattern = patron)
  ldata = list()
  for (i in 1:length(l)) {
    ldata[[i]] = readRDS(paste(path, l[[i]], sep=''))
  }
  names(ldata) = l
  
  #TASK
  lista.tareas = list()
  for (i in 1:length(ldata)){
    lista.tareas[[i]] = makeClassifTask(id = paste('nfeat_', ncol(ldata[[i]])-1) , data = ldata[[i]], target = "target")
  }
  
  #SIN CF
  lista.sinCF = list()
  for (i in 1:length(lista.tareas)){
    lista.sinCF[[i]] = removeConstantFeatures(lista.tareas[[i]])
  }
  lista.Norm = list()
  for (i in 1:length(lista.sinCF)){
    lista.Norm[[i]] = normalizeFeatures(
      lista.sinCF[[i]],
      method = "range",
      cols = NULL,
      range = c(0, 1),
      on.constant = "quiet")
  }
  ### Busqueda de hiperparámetros ###
  control = makeTuneControlGrid() # Establecer un control par los parametros del modelo
  inner = makeResampleDesc(method = "Holdout")#Optimizacion de los parametros del modelo usando un Holdout para despues utilizar un CV
  
  ## Hacemos los Learners ##
  #xGboost#
  psGB = makeParamSet(makeNumericParam("eta", lower = 0, upper = 1),
                      makeNumericParam("lambda", lower = 0, upper = 200),
                      makeIntegerParam("max_depth", lower = 1, upper = 20))# Establecemos el set de parámetros para que busque el mejor
  lrn1 = makeLearner("classif.xgboost", predict.type = "prob", nrounds = 10)
  lrnGB = makeTuneWrapper(learner = lrn1, resampling = inner, measures = auc, par.set = psGB, control = control, show.info = T)
  
  #RF#
  psRF = makeParamSet(makeDiscreteParam("mtry", values = seq(1, 10, 1)),#Sumar dos y restar dos para tener un rango 
                      makeDiscreteParam("ntree", values= 1000L),
                      makeDiscreteParam("nodesize", values= c(1:3)))
  lrn2 = makeLearner("classif.randomForest",  predict.type = "prob")
  lrnRF = makeTuneWrapper(learner = lrn2, resampling = inner, measures = auc, par.set = psRF, control = control, show.info = T)
  
  #GLMNET#
  psGL = makeParamSet(makeDiscreteParam("lambda", values = c(0.0001,0.001,0.01,0.1,1)),
                      makeDiscreteParam("alpha",values = c(0,0.15,0.25,0.35,0.5,0.65,0.75,0.85,1)))
  lrn3 = makeLearner("classif.glmnet", predict.type = "prob")
  lrnGL = makeTuneWrapper(learner = lrn3, resampling = inner, measures = auc, par.set = psGL, control = control, show.info = T)
  
  #LDA#
  #psLDA =  makeParamSet(makeDiscreteParam())
  #lrn4 = makeLearner("classif.lda", predict.type = "prob")
  #lrnLDA = makeTuneWrapper(learner = lrn4, resampling = inner, measures = auc, par.set = psLDA, control = control, show.info = T)
  
  #SVM#
  psKSVM = makeParamSet(makeDiscreteParam('C', values = 2^c(-8, -4, -2, 0)),
                        makeDiscreteParam('sigma', values = 2^c(-8, -4, 0, 4)))
  lrn5 = makeLearner("classif.ksvm", predict.type = "prob") #ES PROB O RESPONSE??
  lrnKSVM = makeTuneWrapper(learner = lrn5, resampling = inner, measures = auc, par.set = psKSVM, control = control, show.info = T)
  
  #GBM#
  psGBM = makeParamSet(makeDiscreteParam("distribution", values = "bernoulli"),
                       makeIntegerParam("n.trees", lower = 100, upper = 1000), #number of trees
                       makeIntegerParam("interaction.depth", lower = 2, upper = 10), #depth of tree
                       makeIntegerParam("n.minobsinnode", lower = 10, upper = 80),
                       makeNumericParam("shrinkage",lower = 0.01, upper = 1))
  lrn6 = makeLearner("classif.gbm", predict.type = "prob") #ES PROB O RESPONSE??
  lrnGBM =  makeTuneWrapper(learner = lrn6, resampling = inner, measures = auc, par.set = psGBM, control = control, show.info = T)
  
  #Decision Tree#
  psDT = makeParamSet(makeIntegerParam("minsplit", lower = 10, upper = 50),
                      makeIntegerParam("minbucket", lower = 5, upper = 50),
                      makeNumericParam("cp", lower = 0.001, upper = 0.2))
  lrn7 = makeLearner("classif.rpart", predict.type = "prob")#ES PROB O RESPONSE??
  lrnDT = makeTuneWrapper(learner = lrn7, resampling = inner, measures = auc, par.set = psDT, control = control, show.info = T)
  
  #Nnet#
  psNNET = makeParamSet(makeIntegerParam("size",  lower = 1, upper = 11),
                        makeIntegerParam("maxit", lower = 1, upper = 3),
                        makeNumericParam("decay", lower =-4, upper = 0))
  lrn8 = makeLearner("classif.nnet", predict.type = "prob")
  lrnNNET = makeTuneWrapper(learner = lrn8, resampling = inner, measures = auc, par.set = psNNET, control = control, show.info = T)
  
  
  #learners = list(lrnGB, lrnRF, lrnGL, lrnLDA, lrnKSVM, lrnGBM, lrnDT, lrnNNET)
  learners = list(lrnRF, lrnGL)
  outer = rep(list(makeResampleDesc(method = 'RepCV', predict = 'both', reps = 5, folds = 10, stratify = TRUE)),length(lista.Norm))
  ## Benchmarking ##
  bench = benchmark(learners, lista.Norm, outer, measures = list(acc, auc, mmce), show.info = T , models = T)
  saveRDS(bench, file= paste(outputfile,patron))
  return(bench)
}

## Asignamos los valores a las variables que le vamos a pasar a la funcion ##
#origen = 'TFM/Datasets_FS/'
#patrones = 'DatasetFiloGender'
#destino = 'TFM/Benchmarks/'
#resultado = machnlearn(path = origen, patron = patrones, outputfile = destino)

#plotBMRSummary(resultado)
#plotBMRBoxplots(resultado)
#models = getBMRModels(resultado)
