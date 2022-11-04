#analysis
##combine the 3 datasets

library(dplyr) 
library(ggplot2) 
library(tidyverse) 
library(gridExtra) 
library(viridisLite) 
library(cowplot) 
library(ggalt)
library(viridis)
library(ggridges)
library(readxl)
library(tidyr)
library(data.table)

#rename column
release <- release %>% rename(release_id = id)

release_total <- merge(release_artist, release_label, by = "release_id")

release_total <- merge(release_total, release, by = "release_id")

release_total2 <- rbind(release, release_artist, release_label)

release_total2$released <- substr(release_total2$released, 0, 4)
release_total2 <- filter(release_total2, released > "2007", released < "2012")
View(release_total2)


#delete columns

billboard_total <- filter(billboard_total, year > "2007", year < "2012")


#create column with song and artist a.k.a. Song.ID

release_total2 <- mutate(release_total2, SongID.y = paste(title, artist_name)) 

release_total2$SongID.x <- gsub('\\s+', '', release_total2$SongID.y)

billboard_total$SongID.x <- gsub('\\s+', '', billboard_total$SongID.y)

#merge
dataset_total <- merge(release_total2, billboard_total, by = "SongID.x")

#delete columns
dataset_total <- dataset_total[-c(16, 17, 19:21, 27, 30:39, 46)]

summary(dataset_total)


install.packages("devtools")
devtools::install_github("hannesdatta/musicMetadata")

library(musicMetadata)

# Classify single labels

dataset_total2 <- dataset_total %>% 
  mutate(classify_labels(label_name))

dataset_total2 <- dataset_total2 %>% 
  mutate(
    major_label = warner + universal + sony
  )


# Classify vector of labels
#labels <- c('300 Entertainment/Atlantic', 'Bad Boy Records', 'Virgin Records Ltd')
#data.frame(label=labels, parent_label = classify_labels(labels, concatenate = T))

dataset_total2 <- dataset_total2[-c(5:12, 16, 17, 18, 20, 21, 22, 24, 25, 27)]

save(dataset_after, file = "dataset_after.RData")

dataset_after <- dataset_total2

dataset_after <- filter(dataset_total2, date > "2011-07-01")

dataset_before <- dataset_total2 

dataset_before <- filter(dataset_total2, date < "2011-07-01")
