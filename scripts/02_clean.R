library(tidyverse)

providers <- read_csv("data/raw/NH_ProviderInfo_Jun2026.csv")
wa_clean <- providers %>%
  filter(State== "WA")
nrow(wa_clean)

wa_clean <- providers %>%
  filter(State == "WA") %>%
  select(
    `CMS Certification Number (CCN)`,
    `Provider Name`,
    `City/Town`,
    `ZIP Code`,
    `County/Parish`,
    `Ownership Type`,
    `Number of Certified Beds`,
    `Overall Rating`,
    `Health Inspection Rating`,
    `QM Rating`,
    `Staffing Rating`,
    `Reported Nurse Aide Staffing Hours per Resident per Day`,
    `Reported RN Staffing Hours per Resident per Day`,
    `Reported Total Nurse Staffing Hours per Resident per Day`,
    `Total nursing staff turnover`,
    `Total Amount of Fines in Dollars`,
    `Total Number of Penalties`,
    Latitude,
    Longitude
  )

colnames(wa_clean)
dim(wa_clean)
head(wa_clean)
nrow(providers)
unique(providers$State)
  