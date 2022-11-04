install.packages("dplyr")
install.packages("xml2")
install.packages("rvest")

library(rvest)
library(xml2)
library(dplyr)

# get url from input
input <- "https://www.billboard.com/charts/billboard-global-200/"
# read html code from url
chart_page <- xml2::read_html(input)

# browse nodes in body of article
chart <- chart_page %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all("//div[contains(@class, 'chart-list-item  ')]")
View(chart)

# scrape data
chart <- chart_page %>% 
  rvest::html_nodes('body') %>% 
  xml2::xml_find_all("//div[contains(@class, 'chart-list-item  ')]")
# get rank, artist and title as vector
rank <- chart %>% 
  xml2::xml_attr('data-rank')

artist <- chart %>% 
  xml2::xml_attr('data-artist')

title <- chart %>% 
  xml2::xml_attr('data-title')
# create dataframe, remove NAs and return result
chart_df <- data.frame(rank, artist, title)
chart_df <- chart_df %>% 
  dplyr::filter(!is.na(rank))
View(chart_df)
