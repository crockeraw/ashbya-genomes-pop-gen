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
    h6("Cluster: k-means with k=5"),
    h6("Plant: plant that insect host was found on"),
    h6("Insect: host from which fungus was isolated"),
    selectInput('pos', 'Position by:', position, selected = position[[1]]),
    h6("PCA: principle component analysis"),
    h6("DPCA: discriminant analysis of principal components"),
    h6("Geographic: latitiude and longitude of sample collection"),
    numericInput('jitter', 'Scatter data for visibility (%)', 5, min = 0, max = 50),
    h6("Since many points are overlapping, jitter adds random noise to help visualization")
  ),
  mainPanel(
    plotOutput('plot1'),
    img(src='phylo_tree.png',height="400")
    )
)
