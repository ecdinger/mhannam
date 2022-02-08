library(GADMTools) # for downloading high res administrative boundaries
library(rnaturalearth)# for natural earth download functions
library(rnaturalearthdata) # for cultural and physical boundaries of diff. res.
library(sf) # for working with simple features
library(tmap) # for mapping spatial data


# GADM source data ---------------------------
library(GADMTools)

# Level 0: National
gadm_sf_loadCountries("USA", level = 0, basefile = "./data/")
us_bound <- readRDS("./data/USA_adm0.sf.rds")
us_bound_utm <- st_transform(st_as_sf(us_bound, crs = 4326), 5070)
st_write(us_bound_utm, "./data/US_Boundary.shp", append = F)

# Level 1: State/Province
gadm_sf_loadCountries("USA", level = 1, basefile = "./data/")
us_states <- readRDS("./data/USA_adm1.sf.rds")
us_state_utm <- st_transform(st_as_sf(us_states, crs = 4326), 5070)
st_write(us_state_utm, "./data/US_States.shp", append = F)

# Level 2: County/district
gadm_sf_loadCountries("USA", level = 2, basefile = "./data/")
us_cnty <- readRDS("./data/USA_adm2.sf.rds")
us_cnty_utm <- st_transform(st_as_sf(us_cnty, crs = 4326), 5070)
st_write(us_cnty_utm, "./data/US_Counties.shp", append = F)

plot(us_state_utm[1])
plot(us_states[1])


# Natural Earth source data ----------------------------------------------

library(rnaturalearth)

lakes <- ne_download(scale = 50, # medium scale
                     type = 'lakes_north_america', # a named file on their website
                     destdir = getwd(), # save to working dir.
                     returnclass = 'sf' # return as sf instead of sp
)

lakes_utm <- st_transform(lakes, crs = 5070)

# Park tiles source data -----------------------------------
# Load park tiles
NPSbasic = 'https://atlas-stg.geoplatform.gov/styles/v1/atlas-user/ck58pyquo009v01p99xebegr9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRsYXMtdXNlciIsImEiOiJjazFmdGx2bjQwMDAwMG5wZmYwbmJwbmE2In0.lWXK2UexpXuyVitesLdwUg'

NPSimagery = 'https://atlas-stg.geoplatform.gov/styles/v1/atlas-user/ck72fwp2642dv07o7tbqinvz4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRsYXMtdXNlciIsImEiOiJjazFmdGx2bjQwMDAwMG5wZmYwbmJwbmE2In0.lWXK2UexpXuyVitesLdwUg'

NPSslate = 'https://atlas-stg.geoplatform.gov/styles/v1/atlas-user/ck5cpvc2e0avf01p9zaw4co8o/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRsYXMtdXNlciIsImEiOiJjazFmdGx2bjQwMDAwMG5wZmYwbmJwbmE2In0.lWXK2UexpXuyVitesLdwUg'

NPSlight = 'https://atlas-stg.geoplatform.gov/styles/v1/atlas-user/ck5cpia2u0auf01p9vbugvcpv/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXRsYXMtdXNlciIsImEiOiJjazFmdGx2bjQwMDAwMG5wZmYwbmJwbmE2In0.lWXK2UexpXuyVitesLdwUg'

# plot with tmap ----------------------------------------------
library(tmap)
tmap_options(basemaps = c(Map = NPSbasic,
                          Imagery = NPSimagery,
                          Light = NPSlight,
                          Slate = NPSslate))

tmap_mode('view') # set to interactive mode
mn_map

tmap_mode('plot') # return to static mode
