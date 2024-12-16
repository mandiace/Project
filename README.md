# Intro to Data Science: Final Project

### Mandi Acevedo, Kevin Velasco, Isabela Walkin

Given the unreliability of polling data in recent presidential elections, we decided to construct a model that would predict the winner of the 2024 presidential election between former president Donald Trump and current vice-president Kamala Harris. To get a more detailed understanding of voting behavior, we chose counties as our unit of observation and collected demographic, economic, and political descriptors as predictors in our model. We utilized 2020 data to train our predictive model.

Due to the unavailability of recent ACS 1-year estimates, we utilized 2022 descriptors as proxies for our 2024 final model. To compensate, we used 2019 ACS 1-year estimates for our 2020 training model. Below is a description of the predictors, as well as the primary outcome, we used to construct our predictive model:

-   **diff_current**: primary outcome. The differential in the number of votes between the Republican and Democratic candidates. A positive differential indicates a Republican victory, whereas a negative differential indicates a Democratic victory.
-   **diff_previous**: the differential in the number of votes between the Republican and Democratic candidate in the previous presidential election.
-   **prop_less_than_hs**: the proportion of residents between the ages of 18 and 24 who did not graduate from high school.
-   **prop_bachelors_higher**: the proportion of residents between the ages of 18 and 24 who had received a Bachelor's Degree or higher.
-   **prop_18_to_24**: the proportion of residents between the ages of 18 and 24 among the entire population.
-   **prop_65_years_older**: the proportion of residents between ages 65 or over among the entire population.
-   **prop_white**: the proportion of residents who self-identify as white, and only white, among the entire population.
-   **prop_black**: the proportion of residents who self-identify as black or African-America, and only black or African-American, among the entire population.
-   **prop_hispanic**: the proportion of residents who self-identify as Hispanic or Latino of any race among the entire population.
-   **poverty_rate**: the proportion of residents who fall below the federally-defined poverty status.
-   **unemployment_rate**: the proportion of residents ages 16 or over who were unemployed but in the labor force.
-   **male_ratio_per_100_females**: the ratio of males per 100 females.
-   **median_age**: the median age.
-   **median_income**: the median income.
-   **gini**: the county's Gini coefficient.
-   **median_housing_costs**: the median monthly housing costs of occupied housing units.
-   **prop_foreign_born_citizen**: the proportion of foreign-born residents with citizenship status among the entire population.
-   **prop_undocumented**: the proportion of undocumented foreign-born residents among the entire population.
-   **population_density**: the population density (per square mile) of the county.
-   **total_population**: the total population of the county.
-   **swing**: dummy variable that explains whether the county switched from voting for the Republican candidate to the Democratic candidate, or vice versa, between the previous two elections.

Utilizing a LASSO model, we correctly predicted the outcome of the 2024 presidential election by aggregating county differentials in a given state to the state level. Our results suggest that the demographic, economic, and political predictors at the county level that we included in our final model are reliable indicators for presidential results, and that counties -- which often paint a more detailed picture of the electorate than the larger state level -- should be prioritized in any electoral predictive analysis. Nonetheless, given the ever-changing political landscape, our model should be limited to use in only contemporary elections, and a restructuring of the model should be considered in the future as the political environment continues to shift.

## Sources

ReadySignal. "Electoral College Data Table." Retrieved from: <https://readysignal.com/electoral-college-data-table/>

U.S. Census Bureau (2019). "American Community Survey 1-Year Estimates." Retrieved from: <http://api.census.gov/data/2019/acs/acs1>

--- (2011). "USA Counties: 2011." Retrieved from: <https://www.census.gov/library/publications/2011/compendia/usa-counties-2011.html>

--- (2022). "American Community Survey 1-Year Estimates." Retrieved from: <https://api.census.gov/data/2022/acs/acs1>
