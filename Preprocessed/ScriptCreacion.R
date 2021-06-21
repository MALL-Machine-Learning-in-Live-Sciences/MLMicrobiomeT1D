###  TFM DIABINMUNE_Script1 ###
## Creacion de datasets ##
create.datasets = function(path.datos, path.targets, path.output){
  require(dplyr) # Funciones de filtrado #
  require(stringr) # Funcion de detectar patron #
  load(file = path.datos) # Datos taxonómicos #
  load(file = path.targets) # Datos generales #
  ## Divdir en Datasets ##
  # Filos #
  Dataset_1Filo = mp_shotgun %>% 
    select(1:125) %>% 
    filter(str_detect(Taxonomy, pattern = "p__"),!str_detect(Taxonomy, pattern = "c__"))
  rownames(Dataset_1Filo) = Dataset_1Filo$Taxonomy
  Dataset_1Filo = Dataset_1Filo[,-1]
  Dataset_1Filo = as.data.frame(t(Dataset_1Filo))
  #Dataset_1Filo
  #names(Dataset_F1ilo)
  
  # Clase #
  Dataset_2Clase = mp_shotgun %>% 
    select(1:125) %>% 
    filter(str_detect(Taxonomy, pattern = "c__"),!str_detect(Taxonomy, pattern = "o__"))
  rownames(Dataset_2Clase) = Dataset_2Clase$Taxonomy
  Dataset_2Clase = Dataset_2Clase[,-1]
  Dataset_2Clase = as.data.frame(t(Dataset_2Clase))
  
  # Orden #
  Dataset_3Orden = mp_shotgun %>% 
    select(1:125) %>% 
    filter(str_detect(Taxonomy, pattern = "o__"),!str_detect(Taxonomy, pattern = "f__"))
  rownames(Dataset_3Orden) = Dataset_3Orden$Taxonomy
  Dataset_3Orden = Dataset_3Orden[,-1]
  Dataset_3Orden = as.data.frame(t(Dataset_3Orden))
  
  # Familia #
  Dataset_4Familia = mp_shotgun %>% 
    select(1:125) %>% 
    filter(str_detect(Taxonomy, pattern = "f__"),!str_detect(Taxonomy, pattern = "g__"))
  rownames(Dataset_4Familia) = Dataset_4Familia$Taxonomy
  Dataset_4Familia = Dataset_4Familia[,-1]
  Dataset_4Familia = as.data.frame(t(Dataset_4Familia))
  
  # Genero #
  Dataset_5Genero = mp_shotgun %>% 
    select(1:125) %>% 
    filter(str_detect(Taxonomy, pattern = "g__"),!str_detect(Taxonomy, pattern = "s__"))
  rownames(Dataset_5Genero) = Dataset_5Genero$Taxonomy
  Dataset_5Genero = Dataset_5Genero[,-1]
  Dataset_5Genero = as.data.frame(t(Dataset_5Genero))
  
  # Especie #
  Dataset_6Especie = mp_shotgun %>% 
    select(1:125) %>% 
    filter(str_detect(Taxonomy, pattern = "s__"))
  rownames(Dataset_6Especie) = Dataset_6Especie$Taxonomy
  Dataset_6Especie = Dataset_6Especie[,-1]
  Dataset_6Especie = as.data.frame(t(Dataset_6Especie))
  
  md_shotgunSD <- md_shotgun[!duplicated(md_shotgun$Gid_16S), ]# Habia datos duplicados asi que los quitamos #
  m =  match(md_shotgunSD$Gid_16S, rownames(Dataset_1Filo)) # Macheamos las columnas y filas entre las dos tablas
  xx = Dataset_1Filo[m,]
  #dim(Dataset_1Filo)
  #dim(xx)
  #length(m)
  #md_shotgunSD[1:10,1:5]
  #xx[1:10,1:5]
  DatasetFilo = Dataset_1Filo[m,]
  DatasetClase = Dataset_2Clase[m,]
  DatasetOrden = Dataset_3Orden[m,]
  DatasetFamilia = Dataset_4Familia[m,]
  DatasetGenero = Dataset_5Genero[m,]
  DatasetEspecie = Dataset_6Especie[m,]
  DatasetTarget =  md_shotgunSD
  l = list(DatasetFilo,DatasetClase,DatasetOrden, DatasetFamilia, DatasetGenero, DatasetEspecie, DatasetTarget)
  n = list("DataFilo","DataClase","DataOrden", "DataFamilia", "DataGenero", "DataEspecie", "Targets")
  for (i in 1:length(l)) {
    saveRDS(l[[i]], file = paste(path.output,n[[i]],sep =''))
  }
  names(l) = n
  return(l)
}

#data = "TFM/Datos/diabimmune_t1d_metaphlan.rdata"
#tget = "TFM/Datos/diabimmune_t1d_wgs_metadata.rdata"
#out = "TFM/Basura/"
#datasets = create.datasets(path.datos = data, path.targets = tget, path.output = out)
