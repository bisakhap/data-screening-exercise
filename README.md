# data-screening-exercise

## Use of External Resources

This exercise was completed using R (tidyverse) and standard data
cleaning and visualization practices.

### Key Design Decisions

**Programmatic Header Detection**  
Rather than hardcoding row numbers, I used pattern matching to locate the 
header row automatically. This makes the script more robust to changes 
in the source file structure.

**Systematic Data Cleaning**  
I identified and addressed several common data quality issues, including 
special characters in facility names (e.g., $, %, ^), inconsistent 
capitalization, Excel serial date formats, and multiple representations 
of missing values (NA vs. N/A). These issues were resolved programmatically 
using tidyverse functions to keep the workflow reproducible.

**Defensive Programming**  
Basic validation checks (such as confirming the presence of a header row) 
were included so the script fails with clear error messages if the input 
data structure changes.

### AI Assistance
I used ChatGPT as development assistance to:
- Review best practices for cleaning administrative text fields
- Validate string cleaning approaches using `mutate()` and `stringr`
- Confirm methods for converting Excel-style numeric dates into R `Date` objects
- Review approaches for summing multiple numeric columns while handling missing values

The specific prompt thread used is available here:
https://chatgpt.com/share/696e0d08-bbec-800d-a5e6-f36436becebc

All code was written, adapted, and tested by me to fit the structure
and requirements of this exercise.

### Other Resources
I also referenced the following resource to refresh ggplot2 syntax
and bar chart construction:
- https://r-graph-gallery.com/218-basic-barplots-with-ggplot2.html