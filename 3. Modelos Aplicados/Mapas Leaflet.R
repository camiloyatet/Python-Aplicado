library(data.table)
library(tidyverse)
library(leaflet.extras)
library(scales)

#### Cargar Datos -----

data <- fread("data/Demograficos.csv", verbose = T)

data %>% 
  filter(!is.na(cx_persona)) %>% 
  group_by(cx_persona, cy_persona) %>% 
  summarise(Personas=n_distinct(IdPersona)) %>% 
  leaflet() %>% 
  addTiles() %>%
  addCircleMarkers(lat = ~cy_persona, lng = ~cx_persona, radius = ~rescale(Personas, to=c(5,30)))

data %>% 
  filter(!is.na(cx_persona)) %>% 
  leaflet() %>% 
  addTiles(urlTemplate = "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga", attribution = 'Google') %>% 
  setView(lat=4.6477908, lng = -74.108419, zoom = 10) %>% 
  addHeatmap(lat = ~cy_persona, lng = ~cx_persona, blur=20, radius = 10, max = 0.7)




