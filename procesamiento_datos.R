rm(list=ls())
library(readxl)
library(dplyr)
library(reshape2)
setwd("~/TareasTemporal/4.3 ProyectoFinal/Tablero/")

## La información a utilizar ha sido descargada de http://www.beta.inegi.org.mx/app/descarga/?t=0230016000000000&ag=00#denue
## Leemos el documento de Excel para cargar todos los datos relacionados a Accidentes de Tránsito obtenidos del INEGI
indicadores_00 <- read_excel("indicadores_00.xlsx")

## Seleccionamos la categoría "Accidentes de tránsito terrestre en zonas urbanas y suburbanas"
df <- indicadores_00 %>% filter(entidad != "00" & id_indicador == "1006000039") %>%
  select(entidad, desc_entidad, '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006'
         , '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015')
df<-as.data.frame(df)
## Convertimos los años y los valores en columnas, para tener una tabla vertical
df<-melt(df,id = c('entidad', 'desc_entidad'))
## Renombramos los campos
names(df)<-c("Cod_estado","Estado","Año","Accidentes_Transito")

## Seleccionamos la categoría "Víctimas muertas en los accidentes de tránsito"
df2 <- indicadores_00 %>% filter(entidad != "00" & id_indicador == "6200009438") %>%
  select(entidad, desc_entidad, '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006'
         , '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015')
df2<-as.data.frame(df2)
## Convertimos los años y los valores en columnas, para tener una tabla vertical
df2<-melt(df2,id = c('entidad', 'desc_entidad'))
## Renombramos los campos
names(df2)<-c("Cod_estado","Estado","Año","Muertes_en_accidentes")

## Seleccionamos la categoría "Víctimas heridas en los accidentes de tránsito"
df3 <- indicadores_00 %>% filter(entidad != "00" & id_indicador == "6200009439") %>%
  select(entidad, desc_entidad, '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006'
         , '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015')
df3<-as.data.frame(df3)
## Convertimos los años y los valores en columnas, para tener una tabla vertical
df3<-melt(df3,id = c('entidad', 'desc_entidad'))
## Renombramos los campos
names(df3)<-c("Cod_estado","Estado","Año","Heridos_en_accidentes")

## Seleccionamos la categoría "Accidentes en donde el conductor responsable es hombre"
df4 <- indicadores_00 %>% filter(entidad != "00" & id_indicador == "6200009444") %>%
  select(entidad, desc_entidad, '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006'
         , '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015')
df4<-as.data.frame(df4)
## Convertimos los años y los valores en columnas, para tener una tabla vertical
df4<-melt(df4,id = c('entidad', 'desc_entidad'))
## Renombramos los campos
names(df4)<-c("Cod_estado","Estado","Año","Responsable_hombre")

## Seleccionamos la categoría "Accidentes en donde el conductor responsable es mujer"
df5 <- indicadores_00 %>% filter(entidad != "00" & id_indicador == "6200009440") %>%
  select(entidad, desc_entidad, '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006'
         , '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015')
df5<-as.data.frame(df5)
## Convertimos los años y los valores en columnas, para tener una tabla vertical
df5<-melt(df5,id = c('entidad', 'desc_entidad'))
## Renombramos los campos
names(df5)<-c("Cod_estado","Estado","Año","Responsable_mujer")

tabla<-cbind(df,df2$Muertes_en_accidentes,df3$Heridos_en_accidentes,df4$Responsable_hombre,df5$Responsable_mujer)
names(tabla)<-c("Cod_estado","Estado","Año","Accidentes_Transito","Muertes","Heridos","Responsable_Hombre","Responsable_Mujer")

write.csv(tabla, "Accidentes.csv", row.names = FALSE)
