library("vcfR")
library("tidyverse")

vcf <- read.vcfR("proj/source_data/mito.vcf")
genotypes <- vcf@gt
# Isolate IDs are stored in VCF with full path from Longleaf
# Replace with only the REF ID that would be used in the metadata sheet:
res <- str_match(colnames(genotypes)[-1], "bams/\\s*(.*?)\\s*ASGY")[,2]
colnames(vcf@gt)[-1] <- res
genotypes <- vcf@gt

meta <- read.table("proj/source_data/metadata.csv", sep = ",", header = TRUE)

# Need to remove strains from genotype and meta objects that are unique to either.

a <- tibble(as.data.frame(vcf@gt))
m <- tibble(meta)

variants_vector <- getFIX(vcf)

# this makes long tibble with entry per individ X locus
Z <- vcfR2tidy(vcf, format_fields = c("GT", "DP"))
