library(tidyverse)
library(dplyr)
library(stringr)
library(sf)
library(modelr)
library(tidycensus)
library(httr)
library(jsonlite)

census_api_key("794708f156e5f9a870d2531bb80e777690f72326", install = TRUE)

# 2019

data2019 <- get_acs(dataset = "acs5",
                    year = 2019,
                    geography = "county",
                    variables = c(
                      # educational attainment
                      count18to24 = "S1501_C01_001",
                      count24to34 = "S1501_C01_016",
                      count35to44 = "S1501_C01_019",
                      count45to64 = "S1501_C01_022",
                      count65over = "S1501_C01_025",
                      countlessthanhs = "S1501_C01_002",
                      counthsgrad = "S1501_C01_003",
                      countsomecollegeassociates = "S1501_C01_004",
                      countbachhigher = "S1501_C01_005",
                      # total population
                      totalpopulation = "B01003_001",
                      # demographic information
                      maleratioper100females = "DP05_0004",
                      medianage = "DP05_0018",
                      countwhite = "DP05_0037",
                      countblack = "DP05_0038",
                      counthispanic = "DP05_0071",
                      # income
                      medianincome = "S1901_C01_012",
                      medianhhincome = "S1901_C02_012",
                      countbelowpoverty = "S1701_C02_001",
                      medianhousingcosts = "S2503_C01_024",
                      # employment
                      countlaborforce16plus = "DP03_0002",
                      countunemployedinlaborforce16plus = "DP03_0005")) |> 
  select(!moe) |> 
  pivot_wider(names_from = variable,
              values_from = estimate)
                      
data2019 <- data2019 |> 
  mutate(count18over = count18to24 + count24to34 + count35to44 + count45to64 + count65over,
         prop_less_than_hs = countlessthanhs / count18to24,
         prop_hs_grad = counthsgrad / count18to24,
         prop_some_college_associates = countsomecollegeassociates / count18to24,
         prop_bachelors_higher = countbachhigher / count18to24,
         prop_65_years_older = count65over / totalpopulation,
         prop_white = countwhite / totalpopulation,
         prop_black = countblack / totalpopulation,
         prop_hispanic = counthispanic / totalpopulation,
         prop_below_poverty = countbelowpoverty / totalpopulation,
         unemployment_rate = countunemployedinlaborforce16plus / countlaborforce16plus,
         year = 2019) |> 
  rename(male_ratio_per_100_females = maleratioper100females,
         median_age = medianage,
         median_income = medianincome, 
         median_housing_costs = medianhousingcosts,
         total_population = totalpopulation,
         geoid = GEOID,
         name = NAME) |> 
  select(geoid,
         name,
         total_population,
         prop_less_than_hs,
         prop_hs_grad,
         prop_some_college_associates,
         prop_bachelors_higher,
         prop_65_years_older,
         prop_white,
         prop_black,
         prop_hispanic,
         prop_below_poverty,
         unemployment_rate,
         male_ratio_per_100_females,
         median_age,
         median_income,
         median_housing_costs) |> 
  mutate(geoid = sub("^0+", "", geoid))

data2019 |> 
  write_csv("data2019.csv")

# 2022

data2022 <- get_acs(dataset = "acs5",
                    year = 2022,
                    geography = "county",
                    variables = c(
                      # educational attainment
                      count18to24 = "S1501_C01_001",
                      count24to34 = "S1501_C01_016",
                      count35to44 = "S1501_C01_019",
                      count45to64 = "S1501_C01_022",
                      count65over = "S1501_C01_025",
                      countlessthanhs = "S1501_C01_002",
                      counthsgrad = "S1501_C01_003",
                      countsomecollegeassociates = "S1501_C01_004",
                      countbachhigher = "S1501_C01_005",
                      # total population
                      totalpopulation = "B01003_001",
                      # demographic information
                      maleratioper100females = "DP05_0004",
                      medianage = "DP05_0018",
                      countwhite = "DP05_0037",
                      countblack = "DP05_0038",
                      counthispanic = "DP05_0071",
                      # income
                      medianincome = "S1901_C01_012",
                      medianhhincome = "S1901_C02_012",
                      countbelowpoverty = "S1701_C02_001",
                      medianhousingcosts = "S2503_C01_024",
                      # employment
                      countlaborforce16plus = "DP03_0002",
                      countunemployedinlaborforce16plus = "DP03_0005")) |> 
  select(!moe) |> 
  pivot_wider(names_from = variable,
              values_from = estimate)

data2022 <- data2022 |> 
  mutate(count18over = count18to24 + count24to34 + count35to44 + count45to64 + count65over,
         prop_less_than_hs = countlessthanhs / count18to24,
         prop_hs_grad = counthsgrad / count18to24,
         prop_some_college_associates = countsomecollegeassociates / count18to24,
         prop_bachelors_higher = countbachhigher / count18to24,
         prop_65_years_older = count65over / totalpopulation,
         prop_white = countwhite / totalpopulation,
         prop_black = countblack / totalpopulation,
         prop_hispanic = counthispanic / totalpopulation,
         prop_below_poverty = countbelowpoverty / totalpopulation,
         unemployment_rate = countunemployedinlaborforce16plus / countlaborforce16plus,
         year = 2022) |> 
  rename(male_ratio_per_100_females = maleratioper100females,
         median_age = medianage,
         median_income = medianincome, 
         median_housing_costs = medianhousingcosts,
         total_population = totalpopulation,
         geoid = GEOID,
         name = NAME) |> 
  select(geoid,
         name,
         total_population,
         prop_less_than_hs,
         prop_hs_grad,
         prop_some_college_associates,
         prop_bachelors_higher,
         prop_65_years_older,
         prop_white,
         prop_black,
         prop_hispanic,
         prop_below_poverty,
         unemployment_rate,
         male_ratio_per_100_females,
         median_age,
         median_income,
         median_housing_costs) |> 
  mutate(geoid = sub("^0+", "", geoid))

data2022 |> 
  write_csv("data2022.csv")



