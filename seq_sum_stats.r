library("vcfR")

vcf <- read.vcfR("proj/source_data/mito.vcf")
# convert to genlight object for use with fxns in genlight pkg.
x <- vcfR2genlight(vcf)
# need to pipe std-out to file. numer non-biallelic variants removed.

# load reference genome and annotations for sick plots. 

dna_file <- 'proj/source_data/mito.fa'
gff_file <- 'proj/source_data/mito.gff3'
dna <- ape::read.dna(dna_file, format = "fasta")
gff <- read.table(gff_file, sep="\t", quote="")

# Create a chromR object, produce pre-filtered QC plots
chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)
chrom <- proc.chromR(chrom, verbose=TRUE, win.size = 10)
png("proj/images/pre-filteringQC.png")
chromoqc(chrom, dp.alpha = 66)
dev.off()
png("proj/images/pre-filteringQC_hist.png")
plot(chrom)
dev.off()

# Quality filter and plot post-filtering QC
chrom <- masker(chrom, min_QUAL = 100, min_DP = 1000, min_MQ = 50)
png("proj/images/post-filteringQC.png")
chromoqc(chrom, dp.alpha = 66)
dev.off()
png("proj/images/post-filteringQC_hist.png")
plot(chrom)
dev.off()
