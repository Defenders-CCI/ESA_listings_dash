# setwd()

library(rvest)

html <- read_html("https://ecos.fws.gov/ecp/pullreports/catalog/species/report/species/export?format=htmltable&distinct=true&columns=%2Fspecies%40cn%2Csn%2Cstatus%2Cdesc%2Clisting_date%3B%2Fspecies%2Ftaxonomy%40group%3B%2Fspecies%2Ffws_region%40desc&sort=%2Fspecies%40sn%20asc&filter=%2Fspecies%40status%20in%20('Endangered'%2C'Threatened')&filter=%2Fspecies%40country%20!%3D%20'Foreign'")
tab <- html_table(html)[[1]]
saveRDS(tab, "ESA_listings.rds")
