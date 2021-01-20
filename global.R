library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(readr)

vids <- read_csv("data_input/youtubetrends.csv")
vids <- vids %>% 
  mutate(like_ratio = likes/views,
         dislike_ratio = dislikes/views) %>% 
  mutate_if(is.character, as.factor)

source("ui.R")
source("server.R")

shinyApp(ui = ui,server = server)

# # where to learn next
# open dashbooard_guide.html
# Shiny bookdown tutorial: https://bookdown.org/weicheng/shinyTutorial/ui.html
# Shiny video basic tutorial: https://shiny.rstudio.com/tutorial/
# Shiny example showcase: https://shiny.rstudio.com/gallery/
# Shiny input widget: https://shiny.rstudio.com/gallery/widget-gallery.html
# Shiny leaflet: https://rstudio.github.io/leaflet/shiny.html
# shinydashboard structure & apperance: https://rstudio.github.io/shinydashboard/structure.html
# gganimate: https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/

# FAQ dan helper: https://askalgo.netlify.app/
# visit mas Joe on github, rpubs, and medium for more article
# https://github.com/western11
# https://rpubs.com/jojoecp
# https://medium.com/@joenathanchristian

