create.targets = function(lista,target,path.output){
  require(reshape)
  #Dividimos los datasets de los targets
  targets = lista$Targets
  lista[['Targets']] <- NULL
  #Escogemos el target que queremos usar OJO(Debe llevar el mismo nombre)
  K = targets[paste(target)]
  names(K)[1] <- "target"
  #Le añadimos la columna del target escogido a nuestros datasets
  nombres = names(lista)
  data = list()
  for (i in 1:length(lista)){
    data[[i]] = data.frame(lista[[i]], K)
  }
  names(data) = nombres
  names(data) = paste0(names(data),target)
  #Guardamos los Datasets resultantes
  for (i in 1:length(data)) {
    saveRDS(data[[i]],file = paste(path.output,names(data[i]),sep =''))
  }
  return(data)
}

#l = lista 
#target = "Case_Control"
#out = "TFM/Basura/"
#datasets = create.targets(lista = lista, target = target, path.output = out)
