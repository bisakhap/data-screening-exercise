library(tidyverse)

#read the raw data as text lines
raw_data <- read_lines("data/messy_ice_detention.csv")

#find the line that starts with a header pattern
header_row <- which(str_detect(raw_data, "^Name,City,State"))[1]
#raw_data[header_row] # confirmed header row during inspection

#defensive check
if (is.na(header_row)) {
  stop("Header row not found. Please check file structure.")
}

#read csv skipping everything before header
clean_data <- read_csv("data/messy_ice_detention.csv", skip = header_row - 1)

# view result
head(clean_data, 30)