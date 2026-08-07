library(tidyverse)
library(dplyr)

getwd()
setwd("~/Desktop/Projects /DATA412/Nursing-home-dashboard")


# Importing Dataset  ------------------------------------------------------

providers <- read_csv("data/raw/NH_ProviderInfo_Jun2026.csv")

head(providers, n= 15)

colnames(providers)
table(providers$State) #wa got 193
class(providers$`CMS Certification Number (CCN)`)

sum(is.na(providers$`Overall Rating`)) #125 
class(providers$`Overall Rating`)
sum(is.na(providers$`Reported RN Staffing Hours per Resident per Day`)) 
