library(sf)
library(leaflet)

# UK maps
unzip('GBR_adm.zip')

# Unzip into folder 'data'
unzip('EA_IndicativeFloodRiskAreas_SHP_Full.zip')

# Administrative areas
adm_areas <- sf::st_read('GBR_adm2.shp')
plot(adm_areas)

# Load communities at risk (by LLFA)
risk_comm <- sf::st_read("data/Communities_at_risk_by_LLFA.shp")
risk_comm$geometry <- sf::st_transform(risk_comm$geometry, 
                                       '+proj=longlat +datum=WGS84')
plot(risk_comm)


# Build plot
leaflet(risk_comm) %>% 
  setView(lng = -1.922801, lat = 52.012931, zoom = 6) %>% 
  addTiles() %>%
  addPolygons(data = adm_areas, color = "black", weight = 0.5) %>%
  addPolygons(color = "#444444", weight = 0.25, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.8,
              fillColor = ~colorQuantile("YlOrRd", total_prop)(total_prop),
              highlightOptions = highlightOptions(color = "white", weight = 0.5,
                                                  bringToFront = TRUE))



