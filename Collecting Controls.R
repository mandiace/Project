library(tidyverse)
library(dplyr)
library(stringr)
library(sf)
library(modelr)
library(tidycensus)
library(httr)
library(jsonlite)

census_api_key("794708f156e5f9a870d2531bb80e777690f72326", install = TRUE)

data2019 <- get_acs(dataset = "acs5",
                    year = 2019,
                    geography = "county",
                    variables = c(
                      # educational attainment
                      count18to24 = "S1501_C01_001E",
                      count24to34 = "S1501_C01_016E",
                      count35to44 = "S1501_C01_019E",
                      count45to64 = "S1501_C01_022E",
                      count65over = "S1501_C01_025E",
                      countlessthanhs = "S1501_C01_002E",
                      counthsgrad = "S1501_C01_003E",
                      countsomecollegeassociates = "S1501_C01_004E",
                      countbachhigher = "S1501_C01_005E",
                      # total population
                      totalpopulation = "B01003_001E",
                      # demographic information
                      maleratioper100females = "DP05_0004E",
                      medianage = "DP05_0018E",
                      countwhite = "DP05_0037E",
                      countblack = "DP05_0038E",
                      counthispanic = "DP05_0071E",
                      # income
                      medianincome = "S1901_01_012E",
                      medianhhincome = "S1901_C02_012E",
                      countbelowpoverty = "S1701_C02_001E",
                      medianhousingcosts = "S2503_C01_024E",
                      # employment
                      countlaborforce16plus = "DP03_0002E",
                      countunemployedinlaborforce16plus = "DP03_0005E"))
                      

