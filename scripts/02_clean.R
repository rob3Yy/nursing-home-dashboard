library(tidyverse)

# Load raw data ------------------------------------------------------------
providers <- read_csv("data/raw/NH_ProviderInfo_Jun2026.csv")

# Filter to WA, select needed column,raw data got 99 and rename ------------
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
  ) %>%
  rename(
    ccn = `CMS Certification Number (CCN)`,
    provider_name = `Provider Name`,
    city = `City/Town`,
    zip_code = `ZIP Code`,
    county = `County/Parish`,
    ownership_type = `Ownership Type`,
    certified_beds = `Number of Certified Beds`,
    overall_rating = `Overall Rating`,
    health_inspection_rating = `Health Inspection Rating`,
    qm_rating = `QM Rating`,
    staffing_rating = `Staffing Rating`,
    aide_hours = `Reported Nurse Aide Staffing Hours per Resident per Day`,
    rn_hours = `Reported RN Staffing Hours per Resident per Day`,
    total_nursing_hours = `Reported Total Nurse Staffing Hours per Resident per Day`,
    staff_turnover = `Total nursing staff turnover`,
    total_fines = `Total Amount of Fines in Dollars`,
    total_penalties = `Total Number of Penalties`,
    latitude = Latitude,
    longitude = Longitude
  )

# Check it worked ------------------------------------------------------------
nrow(wa_clean)   # expect 193
ncol(wa_clean)   # expect 19
colnames(wa_clean)

# Missing data notes ---------------------------------------------------------
# 2 WA facilities are missing Overall Rating 7 are missing RN staffing hours.
# decided toKeep these facilities in the dataset -- NAs will
# render as blank in Tableau and be excluded automatically from any chart
# that requires numeric values on both axes.

# Write the clean file --------------------------------------------------------
write_csv(wa_clean, "data/clean/wa_nursing_homes.csv")


