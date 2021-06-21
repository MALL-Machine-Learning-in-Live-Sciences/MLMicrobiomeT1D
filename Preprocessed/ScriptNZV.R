filter.NZV = function(lista, path.output){
  require(caret)
  nombres = names(lista)
  #Listamos los resultados de ZeroVariance and NEarZeroVariance de cada Daraframe
  metrics= list()
  for (i in 1:length(lista)) {
    metrics[[i]] = nearZeroVar(lista[[i]], saveMetrics = TRUE)
  }
  #Creamos una lista donde guardamos los datasets filtrados
  dtf = list()
  for (i in 1:length(lista)) {
    dtf[[i]] = lista[[i]][, metrics[[i]]$nzv == "FALSE"]
  }
  #Renombramos
  names(dtf)= nombres
  names(dtf) = paste0(names(dtf), 'NZV')
  #Guardamos los datasets filtrados
  for (i in 1:length(dtf)) {
    saveRDS(dtf[[i]],file = paste(path.output,names(dtf[i]),sep =''))
  }
  #Devolvemos la lista con los diferentes datasets filtrados
  return(dtf)
}

#output = "TFM/Basura/"
#dtNZV = filter.NZV(lista = datasets, path.output = output)


