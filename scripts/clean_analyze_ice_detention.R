library(tidyverse)

#Read the raw data as text lines to find header
raw_lines <- read_lines("data/messy_ice_detention.csv")

#Find the line that starts with header pattern
header_row <- which(str_detect(raw_lines, "^Name,City,State"))[1]

#Defensive check (to ensure header was found)
if (is.na(header_row)) {
  stop("Header row not found. Please check file structure.")
}

#Read CSV skipping everything before header
detention_data <- read_csv("data/messy_ice_detention.csv", skip = header_row - 1)

# ==============================================================================
# DATA CLEANING
# ==============================================================================

detention_clean <- detention_data %>%
  
  # Clean NAME column by removing special characters and normalizing spacing
  mutate(Name = str_replace_all(Name, "[^A-Za-z0-9 .-]", "")) %>%
  mutate(Name = str_squish(Name)) %>%
  
  # Clean CITY column and standardize formatting
  mutate(City = str_replace_all(City, "[^A-Za-z ]", "")) %>%
  mutate(City = str_squish(City)) %>%
  mutate(City = str_to_title(City)) %>%
  mutate(City = na_if(City, "")) %>%
  
  # Clean STATE column and handle missing values
  mutate(State = str_to_upper(str_trim(State))) %>%
  mutate(State = na_if(State, "")) %>%
  
  # Clean LEVEL columns and ensure population level columns are numeric and rounded for readability
  mutate(across(starts_with("Level"), ~round(., 2))) %>%
  
  # Clean DATE column and convert inspection end dates
  mutate(`Last Inspection End Date` = case_when(
    is.na(`Last Inspection End Date`) ~ NA_character_,
    str_detect(`Last Inspection End Date`, "^N/?A$") ~ NA_character_,
    str_detect(`Last Inspection End Date`, "^\\d{5}$") ~ 
      as.character(as.Date(as.numeric(`Last Inspection End Date`), origin = "1899-12-30")),
    TRUE ~ `Last Inspection End Date`
  )) %>%
  # Convert to Date type
  mutate(`Last Inspection End Date` = as.Date(`Last Inspection End Date`))

# ------------------------------------------------------------------------------
# DATA VALIDATION AND INSPECTION
# ------------------------------------------------------------------------------

cat("\n=== CLEANED DATA STRUCTURE ===\n")
glimpse(detention_clean)

cat("\n=== MISSING VALUES SUMMARY ===\n")
colSums(is.na(detention_clean))

cat("\n=== SAMPLE OF CLEANED DATA ===\n")
print(head(detention_clean, 10), n = 10)

cat("\n=== Sample of Cleaned Dates ===\n")
head(detention_clean$`Last Inspection End Date`, 20)