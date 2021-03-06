get_rows_with_missing_value <- function(df) {
  df[!complete.cases(df), ]
}

get_cities_with_multiple_coords <- function(home_cities) {
  home_cities %>% 
    group_by(country_code, city) %>% 
    summarize(num_coord_per_city = n_distinct(long, lat)) %>% 
    ungroup() %>% 
    filter(num_coord_per_city > 1)
}

glimpse_extreme_regions <- function(home_cities, countries, ...) {
  home_cities %>% 
    summarize_population(...) %>% 
    filter_extreme_regions_by_population() %>%
    attach_human_readable_country_metadata(countries)
}

filter_extreme_regions_by_population <- function(region_populations) {
  region_populations %>%
    arrange(desc(num_contact)) %>%
    {rbind(head(.), tail(.))}
}
