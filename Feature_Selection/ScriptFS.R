###  Script_Feature_Selection ###
## Definimos la funcion ##
fs.abs = function(data, fs.type, ref, nfeat, nombres, destino){
  require(mlr)
  
  task = makeClassifTask(data = data, target = 'target')
  tasks = lapply(nfeat, function(x) filterFeatures(task, method = fs.type, abs = x))
  
  for (i in 1:length(nfeat)) {
    tasks[[i]]$task.desc$id =  paste(fs.type, ncol(tasks[[i]]$env$data) - 1 , sep = "_")
  }
  
  t = list()
  for (i in 1:length(tasks)) {
    t[[i]] = tasks[[i]]$env$data
    names(t)[[i]] = paste(nombres, ref, nfeat[i], sep = '_')
  }
  for (i in 1:length(t)) {
    saveRDS(t[[i]], file = paste(destino,names(t)[[i]],sep =''))
  }
}
#Hacemos el FS, probamos tambien como funciona con Kruskal ademas de Wilcoxon
feature.Selection = function(lista, tipo, referencia, output){
  fstype = 'kruskal.test'
  fstyperef = 'kruskaltest'
  for ( i in 1:length(lista)){
    nombres = names(lista[i])
    if (ncol(lista[[i]]) < 10) {
      nfeat = ncol(lista[[i]])-1
      fs.abs(data = lista[[i]], fs.type = tipo, ref = referencia, nfeat = nfeat, nombres = nombres, destino = output)
    } else if(ncol(lista[[i]]) > 10 & ncol(lista[[i]]) < 13){
      nfeat = ncol(lista[[i]])-1
      fs.abs(data = lista[[i]], fs.type = tipo, ref = referencia, nfeat = nfeat, nombres = nombres, destino = output)
    } else if (ncol(lista[[i]]) > 13 & ncol(lista[[i]]) < 20){
      nfeat = ncol(lista[[i]])-1
      fs.abs(data = lista[[i]], fs.type = tipo, ref = referencia, nfeat = nfeat, nombres = nombres, destino = output)
    } else if (ncol(lista[[i]]) > 20 & ncol(lista[[i]]) < 30 ){
      nfeat = c(8, 16, 25)
      fs.abs(data = lista[[i]], fs.type = tipo, ref = referencia, nfeat = nfeat, nombres = nombres, destino = output)
    } else if (ncol(lista[[i]]) > 30 & ncol(lista[[i]]) < 50 ){
      nfeat = c(8, 16, 32, 45)
      fs.abs(data = lista[[i]], fs.type = tipo, ref = referencia, nfeat = nfeat, nombres = nombres, destino = output)
    } else if(ncol(lista[[i]]) > 100){
      nfeat = seq(1, 102, 1)
      fs.abs(data = lista[[i]], fs.type = tipo, ref = referencia, nfeat = nfeat, nombres = nombres, destino = output)
    }
  }
}


#feature.Selection(lista = dtNZV, tipo = 'kruskal.test', referencia = "KT", output = "TFM/Basura/")




