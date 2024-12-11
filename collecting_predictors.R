library(tidyverse)
library(dplyr)
library(stringr)
library(sf)
library(modelr)
library(tidycensus)
library(httr)
library(jsonlite)

# loading county size predictors

county_size <- read_csv("data/LND01.csv") |> 
  select(STCOU,
         LND010190D) |> 
  rename(geoid = STCOU,
         land_area = LND010190D) |> 
  mutate(geoid = sub("^0+", "", geoid))

### 2019

# demographic predictors

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
                      gini = "B19083_001",
                      # employment
                      countlaborforce16plus = "DP03_0002",
                      countunemployedinlaborforce16plus = "DP03_0005",
                      # foreign born
                      countforeignborncitizen = "B05002_013",
                      countforeignbornundocumented = "B05002_021")) |> 
  select(!moe) |> 
  pivot_wider(names_from = variable,
              values_from = estimate)
                      
data2019 <- data2019 |> 
  mutate(count18over = count18to24 + count24to34 + count35to44 + count45to64 + count65over,
         prop_less_than_hs = countlessthanhs / count18to24,
         prop_hs_grad = counthsgrad / count18to24,
         prop_some_college_associates = countsomecollegeassociates / count18to24,
         prop_bachelors_higher = countbachhigher / count18to24,
         prop_18_to_24 = count18to24 / totalpopulation,
         prop_65_years_older = count65over / totalpopulation,
         prop_white = countwhite / totalpopulation,
         prop_black = countblack / totalpopulation,
         prop_hispanic = counthispanic / totalpopulation,
         poverty_rate = countbelowpoverty / totalpopulation,
         unemployment_rate = countunemployedinlaborforce16plus / countlaborforce16plus,
         prop_foreign_born_citizen = countforeignborncitizen / totalpopulation,
         prop_undocumented = countforeignbornundocumented / totalpopulation,
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
         prop_18_to_24,
         prop_65_years_older,
         prop_white,
         prop_black,
         prop_hispanic,
         poverty_rate,
         unemployment_rate,
         male_ratio_per_100_females,
         median_age,
         median_income,
         gini,
         median_housing_costs,
         prop_foreign_born_citizen,
         prop_undocumented) |> 
  mutate(geoid = sub("^0+", "", geoid))

# merging county size predictors and calculating population density

data2019 <- left_join(x = data2019,
                      y = county_size,
                      by = "geoid") |> 
  mutate(land_area = as.numeric(land_area),
         population_density = total_population / land_area)

data2019 |> 
  write_csv("data2019.csv")

### 2022

# demographic predictors

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
                      gini = "B19083_001",
                      # employment
                      countlaborforce16plus = "DP03_0002",
                      countunemployedinlaborforce16plus = "DP03_0005",
                      # foreign born
                      countforeignborncitizen = "B05002_013",
                      countforeignbornundocumented = "B05002_021")) |> 
  select(!moe) |> 
  pivot_wider(names_from = variable,
              values_from = estimate)

data2022 <- data2022 |> 
  mutate(count18over = count18to24 + count24to34 + count35to44 + count45to64 + count65over,
         prop_less_than_hs = countlessthanhs / count18to24,
         prop_hs_grad = counthsgrad / count18to24,
         prop_some_college_associates = countsomecollegeassociates / count18to24,
         prop_bachelors_higher = countbachhigher / count18to24,
         prop_18_to_24 = count18to24 / totalpopulation,
         prop_65_years_older = count65over / totalpopulation,
         prop_white = countwhite / totalpopulation,
         prop_black = countblack / totalpopulation,
         prop_hispanic = counthispanic / totalpopulation,
         poverty_rate = countbelowpoverty / totalpopulation,
         unemployment_rate = countunemployedinlaborforce16plus / countlaborforce16plus,
         prop_foreign_born_citizen = countforeignborncitizen / totalpopulation,
         prop_undocumented = countforeignbornundocumented / totalpopulation,
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
         prop_18_to_24,
         prop_65_years_older,
         prop_white,
         prop_black,
         prop_hispanic,
         poverty_rate,
         unemployment_rate,
         male_ratio_per_100_females,
         median_age,
         median_income,
         gini,
         median_housing_costs,
         prop_foreign_born_citizen,
         prop_undocumented) |> 
  mutate(geoid = sub("^0+", "", geoid))

# merging county size predictors and calculating population density

data2022 <- left_join(x = data2022,
                      y = county_size,
                      by = "geoid") |> 
  mutate(land_area = as.numeric(land_area),
         population_density = total_population / land_area)

data2022 |> 
  write_csv("data2022.csv")


