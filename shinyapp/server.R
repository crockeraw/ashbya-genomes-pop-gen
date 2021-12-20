function(input, output, session) {
  library(ggplot2)
  # Combine the selected variables into a new data frame
  PCA <- c("PC1", "PC2")
  DAPC <- c("LD1", "LD2")
  Geographic <- c("LON", "LAT")
  col <- data.frame(PCA,DAPC,Geographic)
  
  d <- as.data.frame(read.csv("shiny_data.csv"))
  
  selectedData <- reactive({
    c = col[[input$pos]]
    d[c][is.na(d[c])] <- FALSE
    c
  })
  
  colors <- reactive({
    as.factor(d[[input$color]])
  })
  
  output$plot1 <- renderPlot({
    my_pal <- RColorBrewer::brewer.pal(n=8, name = "Dark2")
    x = d[selectedData()[1]]
    y = d[selectedData()[2]]
    n = (input$jitter / 100)
    ggplot(d, aes(x = get(selectedData()[1]), y = get(selectedData()[2]), color = colors(), fill = colors())) + 
      geom_jitter(size = 4, shape = 21, height=diff(range(x,na.rm=TRUE)*n), width = diff(range(y,na.rm=TRUE))*n) +
      guides(fill = guide_legend(title = "Cluster"), colour = guide_legend(title = "Cluster")) +
      theme_bw() + scale_color_manual(values=c(my_pal),na.value="grey") +
      scale_fill_manual(values=c(paste(my_pal, "66", sep = ""))) +
      xlab(selectedData()[1]) + ylab(selectedData()[2])
  })
  
}
