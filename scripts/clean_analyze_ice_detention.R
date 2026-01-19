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

#Inspect data structure
head(detention_data, 30)
glimpse(detention_data)