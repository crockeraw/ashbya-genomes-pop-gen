# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable
df <- read.csv("shiny_data.csv")

color <- c("Cluster", "Plant", "Insect")
position <-c("PCA", "DAPC", "Geographic")

pageWithSidebar(
  headerPanel('Ashbya genomes exploration'),
  sidebarPanel(
    selectInput('color', 'Color by:', color),
    selectInput('pos', 'Position by:', position, selected = position[[2]]),
    numericInput('jitter', 'Scatter data for visibility (%)', 5, min = 0, max = 50)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)