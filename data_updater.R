setwd("/home/jacobmalcom/open/ESA_listings")
print(Sys.Date())

library(digest)
library(rvest)

attempt <- try(
  html <- read_html("https://ecos.fws.gov/ecp/pullreports/catalog/species/report/species/export?format=htmltable&distinct=true&columns=%2Fspecies%40cn%2Csn%2Cstatus%2Cdesc%2Clisting_date%3B%2Fspecies%2Ftaxonomy%40group%3B%2Fspecies%2Ffws_region%40desc&sort=%2Fspecies%40sn%20asc&filter=%2Fspecies%40status%20in%20('Endangered'%2C'Threatened')&filter=%2Fspecies%40country%20!%3D%20'Foreign'")
)

if(class(attempt) == "try-error") {
  att2 <- try(
    html <- read_html("https://ecos.fws.gov/ecp/pullreports/catalog/species/report/species/export?format=htmltable&distinct=true&columns=%2Fspecies%40cn%2Csn%2Cstatus%2Cdesc%2Clisting_date%3B%2Fspecies%2Ftaxonomy%40group%3B%2Fspecies%2Ffws_region%40desc&sort=%2Fspecies%40sn%20asc&filter=%2Fspecies%40status%20in%20('Endangered'%2C'Threatened')&filter=%2Fspecies%40country%20!%3D%20'Foreign'")
  )
}

if(exists("html")) {
  old <- readRDS("ESA_listings.rds")
  tab <- html_table(html)[[1]]
  if(digest(old) != digest(tab)) {
    file.rename("ESA_listings.rds", "ESA_listings_", Sys.Date(), ".rds")
    saveRDS(tab, "ESA_listings.rds")
    print("Changes written to file.")
  } else {
    print("No data changes")
  }
} else {
  print("Error getting data from FWS.")
}
