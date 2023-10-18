#Read metadata of photos that will be uploaded to FLukebook.org

# First, set the working directory to the folder than contains the photos (in r Studio= session/Set Working directory /Choose directory)

files <- list.files(pattern = "(?i)\\.jpe?g$|\\.png$")#get a list of files .JPG, .jpg, .jpeg or .png in the selected  working directory.

library(exifr)#packaged used for reading photo metadata. 
#installed.packages(exifr) #In case you need to install the package run this line.

dat <- read_exif(files) #read metadata of the list pf photos
dat <- as.data.frame(dat)# create a Dataframe with the metadata

#we make some arregements with date information
library(lubridate)
#converted date column as date format
dat$Dateconverted <- as.POSIXct(dat$DateCreated, format = "%Y:%m:%d %H:%M:%OS")
dat$Year <- year(dat$Dateconverted)#create a column with year
dat$Month <- month(dat$Dateconverted)#create a column with month
dat$Day <- day(dat$Dateconverted)#create a column with day
dat$Hour<- hour(dat$Dateconverted)#create a column with hour
dat$Minutes <- minute(dat$Dateconverted)#create a column with minute
dat$UnixTimestamp <- as.numeric(dat$Dateconverted) * 1000 # Convert to Unix timestamp (milliseconds since epoch)

#We create a dataframe with the variables of interest. In this case we use as reference the wilbook excel (WildbookStandardFormat.xlsx) that is uploaded here.

library(dplyr)
#if some of the fields of the metadata is empty this code will not work. Make shure that the information of the metadata that you are calling in this code is present in teh dataframe "dat". If not you should remove those fields without infromation. 
dat2<- dplyr::select (dat,Encounter.mediaAsset0=SourceFile,Encounter.verbatimLocality=State,Encounter.decimalLatitude=GPSLatitude,Encounter.decimalLongitude=GPSLongitude,Encounter.year=Year,Encounter.month=Month,Encounter.day=Day,Encounter.hour=Hour,Encounter.minutes=Minutes, Encounter.country=Country,Encounter.dateInMilliseconds=UnixTimestamp,Encounter.day=Day,Encounter.hour=Hour,Encounter.minutes=Minutes,Encounter.photographer0.fullName=Creator,Encounter.photographer0.emailAddress=CreatorWorkEmail)

#Here we include information that is specific of each proyect
dat2$Encounter.submitterID <- "educacionocc" #case sensitive 
dat2$Encounter.locationID="Atlantic Ocean (South)" #look for this name that corresponds to your area in flukbook
dat2$Encounter.genus="Eubalaena" #genus
dat2$Encounter.specificEpithet="australis" #species
dat2$Encounter.livingStatus="alive"
dat2$Encounter.submitterOrganization="OCC"
dat2$Encounter.informOther0.emailAddress <- "candelariabelenpiemonte@gmail.com"      

#Write a .xlsx, ready to be used in flukebook. The file will be saved in the same folder of the photos
library(writexl)
write_xlsx(dat2, "dataphotos.xlsx")

