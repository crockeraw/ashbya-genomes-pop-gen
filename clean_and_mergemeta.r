library("vcfR")
library("tidyverse")

vcf <- read.vcfR("source_data/mito_vars.vcf")
# Isolate IDs are stored in VCF with full path from Longleaf
# Replace with only the REF ID that would be used in the metadata sheet:
res <- str_match(colnames(vcf@gt)[-1], "bams/\\s*(.*?)\\s*ASGY")[,2]
colnames(vcf@gt)[-1] <- res

df <- vcf@gt[,-c(1:3)] %>% as.data.frame() %>% tibble()

df2 <- vcfR2tidy(vcf)
df_vars <- filter(df2$gt, !grepl("SW", df2$gt$Indiv)) 

# first make rows the alleles and individuals columns
df_vars <- filter(df2$gt, gt_GT!='0')
df_vars <- filter(df_vars, !grepl("SW", df_vars$Indiv))
summarize(group_by(df_vars,Indiv),)


meta <- read.table("proj/source_data/metadata.csv", sep = ",", header = TRUE)

# Need to remove strains from genotype and meta objects that are unique to either.

a <- tibble(as.data.frame(vcf@gt))
m <- tibble(meta)

variants_vector <- getFIX(vcf)

# this makes long tibble with entry per individ X locus
Z <- vcfR2tidy(vcf)

gl_rubi <- vcfR2genlight(vcf)

library(adegenet)
maxK <- 5
myMat <- matrix(nrow=10, ncol=maxK)
colnames(myMat) <- 1:ncol(myMat)
for(i in 1:nrow(myMat)){
  grp <- find.clusters(gl_rubi, n.pca = 4, n.clust = 4)
  myMat[i,] <- grp$Kstat
}
