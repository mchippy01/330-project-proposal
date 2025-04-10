library(tidyverse)
library(terra)
library(dplyr)
library(sf)
r = rast(c("/Users/chippymarx/Downloads/sl_forb_current.tiff",
           '/Users/chippymarx/Downloads/sl_forb_mid_585.tiff'))
#gives metadata

#use extract for long and lat 

Invasive_data <- read_csv("data/CO_INVASIVE_SUBPLOT_SPP.csv")
Location_data <- read_csv("data/CO_PLOTGEOM.csv")
Invasive_withLoc <- inner_join(Invasive_data, Location_data, by = c("PLT_CN" = 'CN'))


r = rast("/Users/chippymarx/Downloads/sl_forb_current.tiff") 

pts = Invasive_withLoc %>% 
  st_as_sf(coords = c("LON", 'LAT'), crs = 4326) 

mapview::mapview(pts)


pts$sl_forb_current = extract(r, pts)

bb = st_bbox(pts) %>% 
  sf::st_as_sfc() %>% 
  st_as_sf() %>% 
  st_transform(crs(r))

cc = crop(r, bb)

plot(cc)
plot(project(vect(pts), crs(r)), add = TRUE, col = "red", pch = 16)

plot(r)

mapview::mapview(r)

plot(pts$sl_forb_current)

