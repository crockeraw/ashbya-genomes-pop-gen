#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(vcfR)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("BIOS611 Ashbya genomes project"),

    sidebarLayout(
        sidebarPanel(
            fileInput("vcf", "Provide a variant call (vcf) File", accept = ".vcf"),
            fileInput("fasta", "And a genome (fasta) File", accept = ".fa"),
            fileInput("gff", "And an annotation (gff) File", accept = ".gff3")
        ),
    mainPanel(
        plotOutput("contents")
        )
    )

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    # By default shiny does not allow files >5MB. 
    options(shiny.maxRequestSize=30*1024^2)
    
    output$contents <- renderPlot({
        req(input$gff)
        vcf <- read.vcfR(input$vcf$datapath)
        dna <- ape::read.dna(input$fasta$datapath, format = "fasta")
        gff <- read.table(input$gff$datapath, sep="\t", quote="")
        #gen <- vcfR2genlight(vcf)
        chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)
        chrom <- masker(chrom, min_QUAL = 100, min_DP = 1000, min_MQ = 50)
        # AT this point snp densities have not been calculated.
        chrom <- proc.chromR(chrom, verbose=TRUE, win.size = 100)
        plot(chrom)})
}


# Run the application 
shinyApp(ui = ui, server = server)
