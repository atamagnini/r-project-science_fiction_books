library(tidyverse)
library(highcharter)
library(data.table)
library(htmlwidgets)

#Loading multiple .csv files as separate data frames
folder <- "D:/R scripts/script_300721_science_fiction_books/datasets/"
file_list <- list.files(path = folder, pattern = "*.csv")
for (i in 1:length(file_list)){
  assign(file_list[i], 
         read.csv(paste(folder, file_list[i], sep=''))
  )}
glimpse(sf_aliens.csv)

#mean of a column from each dataset
Aliens <- data.frame(mean(sf_aliens.csv$Rating_score))
Alternate_history <- data.frame(mean(sf_alternate_history.csv$Rating_score))
Alternate_universe <- data.frame(mean(sf_alternate_universe.csv$Rating_score))
Apocalyptic <- data.frame(mean(sf_apocalyptic.csv$Rating_score))
Cyberpunk <- data.frame(mean(sf_cyberpunk.csv$Rating_score))
Dystopia <- data.frame(mean(sf_dystopia.csv$Rating_score))
Hard <- data.frame(mean(sf_hard.csv$Rating_score))
Military <- data.frame(mean(sf_military.csv$Rating_score))
Robots <- data.frame(mean(sf_robots.csv$Rating_score))
Space_opera <- data.frame(mean(sf_space_opera.csv$Rating_score))
Steampunk <- data.frame(mean(sf_steampunk.csv$Rating_score))
Time_travel <- data.frame(mean(sf_time_travel.csv$Rating_score))

#combine all means
df <- cbind(Aliens, Alternate_history, Alternate_universe, Apocalyptic, Cyberpunk, Dystopia, Hard, Military,
            Robots, Space_opera, Steampunk, Time_travel)
df2 <- as.data.frame(t(as.matrix(df, rownames = TRUE)))
df2 <- round(df2,2)
glimpse(df2)

#clean dataframe
rownames(df2) <- c('Aliens', 'Alternate history', 'Alternate universe', 'Apocalyptic', 'Cyberpunk', 'Dystopia',
                   'Hard', 'Military', 'Robots', 'Space opera', 'Steam punk', 'Time travel')
setDT(df2, keep.rownames = TRUE)[]
colnames(df2) <- c('Genre', 'Rating_Score')

#plot
p <- hchart(df2, "packedbubble", hcaes(value = Rating_Score)) %>%
  hc_tooltip(useHTML = TRUE, headerFormat = '<b> Rating Score <br>', pointFormat = '{point.Genre}: {point.value}') %>%
  hc_title(text = 'Most voted Sci-fi books by genre', style = list(fontWeight = 'bold', fontSize = '22px'),
           align = 'left') %>%
  hc_credits(enabled = TRUE, text = 'By Antonela Tamagnini <br> Source: goodreads.com') %>%
  hc_add_theme(hc_theme_chalk()) %>%
  hc_plotOptions(packedbubble = list(maxSize = '120%'))
p
saveWidget(widget = p, file = 'plot.html')
