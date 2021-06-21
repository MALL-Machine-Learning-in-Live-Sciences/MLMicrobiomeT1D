##Carga de datos
#Correr esto primero para declara todas las variables
#Datasets

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(plyr)
library(tidyverse)
library(ggpubr)
library(reshape)
library(RColorBrewer)
library(repr)
library(plotly)


####DATOS SIN FS#####
SinFS = readRDS(file = "Shiny/DatosSinFs")
names(SinFS)[names(SinFS) == "Algoritmo"] <- "Algorithm"
SinFS = as.data.frame(SinFS)
SinFS$Nivel <- as.character(SinFS$Nivel)
SinFS$Nivel[SinFS$Nivel == "Filo"] <- "Phylum"
SinFS$Nivel[SinFS$Nivel == "Clase"] <- "Class"
SinFS$Nivel[SinFS$Nivel == "Orden"] <- "Order"
SinFS$Nivel[SinFS$Nivel == "Familia"] <- "Family"
SinFS$Nivel[SinFS$Nivel == "Genero"] <- "Genus"
SinFS$Nivel[SinFS$Nivel == "Especie"] <- "Species"
SinFS$Nivel <- factor(SinFS$Nivel, levels =c("Phylum", "Class","Order","Family","Genus","Species"))

####FILO###
ShinyFilo = readRDS(file = "Shiny/RendimientoFiloTODO")
names(ShinyFilo)[names(ShinyFilo) == "Algoritmo"] <- "Algorithm"
FiloRF = readRDS(file = "Shiny/RendimientoFiloRF")
FiloSVM = readRDS(file = "Shiny/RendimientoFiloSVM")
FiloGLMNET =readRDS(file = "Shiny/RendimientoFiloGLMNET")
####CLASE####
ShinyClase = readRDS(file = "Shiny/RendimientoClaseTODO")
names(ShinyClase)[names(ShinyClase) == "Algoritmo"] <- "Algorithm"
ClaseRF = readRDS(file = "Shiny/RendimientoClaseRF")
ClaseSVM = readRDS(file = "Shiny/RendimientoClaseSVM")
ClaseGLMNET = readRDS(file = "Shiny/RendimientoClaseGLMNET")
####ORDEN####
ShinyOrden = readRDS(file = "Shiny/RendimientoOrdenTODO")
names(ShinyOrden)[names(ShinyOrden) == "Algoritmo"] <- "Algorithm"
OrdenRF = readRDS(file = "Shiny/RendimientoOrdenRF")
OrdenSVM = readRDS(file = "Shiny/RendimientoOrdenSVM")
OrdenGLMNET = readRDS(file = "Shiny/RendimientoOrdenGLMNET")

####FAMILIA####
ShinyFamilia = readRDS(file = "Shiny/RendimientoFamiliaTODO")
names(ShinyFamilia)[names(ShinyFamilia) == "Algoritmo"] <- "Algorithm"
FamiliaRF = readRDS(file = "Shiny/RendimientoFamiliaRF")
FamiliaSVM = readRDS(file = "Shiny/RendimientoFamiliaSVM")
FamiliaGLMNET = readRDS(file = "Shiny/RendimientoFamiliaGLMNET")
####GENERO####
ShinyGenero = readRDS(file = "Shiny/RendimientoGeneroTODO")
names(ShinyGenero)[names(ShinyGenero) == "Algoritmo"] <- "Algorithm"
GeneroRF = readRDS(file = "Shiny/RendimientoGeneroRF")
GeneroSVM = readRDS(file = "Shiny/RendimientoGeneroSVM")
GeneroGLMNET = readRDS(file = "Shiny/RendimientoGeneroGLMNET")
####ESPECIE####
ShinyEspecie = readRDS(file = "Shiny/RendimientoEspecieTODO")
names(ShinyEspecie)[names(ShinyEspecie) == "Algoritmo"] <- "Algorithm"
EspecieRF = readRDS(file = "Shiny/RendimientoEspecieRF")
EspecieSVM = readRDS(file = "Shiny/RendimientoEspecieSVM")
EspecieGLMNET = readRDS(file = "Shiny/RendimientoEspecieGLMNET")

###################  MEJOR MODELO  #####################3
Comparacion = readRDS(file = "Shiny/ComparacionModelos")
names(Comparacion)[names(Comparacion) == "Algoritmo"] <- "Algorithm"
df <- data.frame(x=1:102,y=0:1)
###################  FIRMA METAGENOMICA  ##########################3
####Importance####
ShinyImportance = readRDS(file = "Shiny/VIDEF.rds")
ShinyImportance2 = ShinyImportance
ShinyImportance2$Nombres = seq(1:25)

####Abundancias####
##### FILO ####
Filos25feat = readRDS(file = "Shiny/AbundanciaFiloFS")
Filos25feat$Filo = as.factor(Filos25feat$Filo)
Filos102feat = readRDS(file = "Shiny/AbundanciaFiloTotal")
Filos102feat$Filo = as.factor(Filos102feat$Filo)

#### PALETA ####
Filo.cols <- 5
Filocolors <- colorRampPalette(brewer.pal(8, "Set1"))(Filo.cols)
names(Filocolors) <- levels(Filos102feat$Filo)
Filocolors <- scale_fill_manual(name = "Filo",values = Filocolors)


#### CLASE ####
Clases25feat = readRDS(file = "Shiny/AbundanciaClaseFS")
Clases25feat$Clase = as.factor(Clases25feat$Clase)
Clases102feat = readRDS(file = "Shiny/AbundanciaClaseTotal")
Clases102feat$Clase = as.factor(Clases102feat$Clase)
#### PALETA ####
Clase.cols <- 10
Clasecolors <- colorRampPalette(brewer.pal(8, "Set1"))(Clase.cols)
names(Clasecolors) <- levels(Clases102feat$Clase)
Clasecolors <- scale_fill_manual(name = "Clase",values = Clasecolors)


#### ORDEN ####
Orden25feat = readRDS(file = "Shiny/AbundanciaOrdenFS")
Orden25feat$Orden = as.factor(Orden25feat$Orden)
Orden102feat = readRDS(file = "Shiny/AbundanciaOrdenTotal")
Orden102feat$Orden = as.factor(Orden102feat$Orden)
#### PALETA ####
Orden.cols <- 13
Ordencolors <- colorRampPalette(brewer.pal(8, "Set1"))(Orden.cols)
names(Ordencolors) <- levels(Orden102feat$Orden)
Ordencolors <- scale_fill_manual(name = "Orden",values = Ordencolors)


#### FAMILIA ####
Familias25feat = readRDS(file = "Shiny/AbundanciaFamiliaFS")
Familias25feat$Familia = as.factor(Familias25feat$Familia)
Familias102feat = readRDS(file = "Shiny/AbundanciaFamiliaTotal")
Familias102feat$Familia = as.factor(Familias102feat$Familia)
#### PALETA ####
Familia.cols <- 24
Familiacolors <- colorRampPalette(brewer.pal(8, "Set1"))(Familia.cols)
names(Familiacolors) <- levels(Familias102feat$Familia)
Familiacolors <- scale_fill_manual(name = "Familia",values = Familiacolors)



#### GENERO ####
Generos25feat = readRDS(file = "Shiny/AbundanciaGeneroFS")
Generos25feat$Género = as.factor(Generos25feat$Género)
Generos102feat = readRDS(file = "Shiny/AbundanciaGeneroTotal")
Generos102feat$Género = as.factor(Generos102feat$Género)
#### PALETA ####
Genero.cols <- 42
Generocolors <- colorRampPalette(brewer.pal(8, "Set1"))(Genero.cols)
names(Generocolors) <- levels(Generos102feat$Género)
Generocolors <- scale_fill_manual(name = "Género",values = Generocolors)


#AB RElativas
AbundanciasRelativas = readRDS(file = "Shiny/AbundanciasRelativas")
validacion = readRDS("Shiny/validacion")
names(validacion)[names(validacion) == "Algoritmo"] <- "Algorithm"


texto = "Introducir texto de explicacion de las especies"