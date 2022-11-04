#analysis

dataset_total2 <-
  dataset_total2 %>%  filter(year > "2007", year < "2012")

ggplot(dataset_total2, aes(x=year, y=weeks_on_chart, color=major_label)) + 
  geom_line()

ggplot(dataset_total2, aes(x=date)) + 
  geom_line(aes(y = major_label), color = "darkred") + 
  geom_line(aes(y = weeks_on_chart), color="steelblue", linetype="twodash") 

# Data preparation
library("tidyverse")
df <- dataset_total2 %>%
  select(year, major_label==0, weeks_on_chart) %>%
  gather(key = "variable", value = "value", -date)
head(df)

# Visualization
ggplot(df, aes(x = date, y = value)) + 
  geom_line(aes(color = variable, linetype = variable)) + 
  scale_color_manual(values = c("darkred", "steelblue"))


# mean, sd, max, min
combDF <- data.frame(cbind(B1,B2,B3,B4))

data_long <- gather(combDF, factor_key=TRUE)

data_long%>% group_by(key)%>%
  summarise(mean= mean(value), sd= sd(value), max = max(value),min = min(value))

summary(dataset_total2)

summary(dataset_after)
summary(dataset_before)
summarise(dataset_before, sd= sd("warner"))

sd(dataset_after$major_label)
