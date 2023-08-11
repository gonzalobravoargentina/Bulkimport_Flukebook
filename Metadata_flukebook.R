#Read metadata of photos that will be uploaded to FLukebook.or

# 1- Set working directory to the folder with the photos (in r Studio= session/Set Working directory /Choose directory)

files <- list.files(pattern = "(?i)\\.jpe?g$|\\.png$")#get a list of files .JPG, .jpg, .jpeg or .png in the working directory selected

library(exifr)
dat <- read_exif(files) #read metadata 
dat <- as.data.frame(dat)# create a dataframe

#create a short data.frame with the columms of interest 
library(dplyr)
library(lubridate)
#coverted date colum as date format
dat$Dateconverted <- as.POSIXct(dat$DateCreated, format = "%Y:%m:%d %H:%M:%OS")
dat$Year <- year(dat$Dateconverted)#creat a colum with year
dat$Month <- month(dat$Dateconverted)
dat$Day <- day(dat$Dateconverted)
dat$Hour<- hour(dat$Dateconverted)
dat$Minutes <- minute(dat$Dateconverted)
# Convert to Unix timestamp (milliseconds since epoch)
dat$UnixTimestamp <- as.numeric(dat$Dateconverted) * 1000

#created a dataframe with selected columns
dat2<- dplyr::select (dat,Encounter.mediaAsset0=SourceFile,Encounter.verbatimLocality=State,Encounter.decimalLatitude=GPSLatitude,Encounter.decimalLongitude=GPSLongitude,Encounter.year=Year,Encounter.month=Month,Encounter.day=Day,Encounter.hour=Hour,Encounter.minutes=Minutes, Encounter.country=Country,Encounter.dateInMilliseconds=UnixTimestamp,Encounter.day=Day,Encounter.hour=Hour,Encounter.minutes=Minutes,Encounter.photographer0.fullName=Creator,Encounter.photographer0.emailAddress=CreatorWorkEmail)

dat2$Encounter.submitterID <- "educacionocc"
dat2$Encounter.locationID="Atlantic Ocean (South)"
dat2$Encounter.genus="Eubalaena"
dat2$Encounter.specificEpithet="australis"
dat2$Encounter.livingStatus="alive"
dat2$Encounter.submitterOrganization="OCC"
dat2$Encounter.informOther0.emailAddress <- "candelariabelenpiemonte@gmail.com"      


library(writexl)
write_xlsx(dat2, "dataphotos.xlsx")
