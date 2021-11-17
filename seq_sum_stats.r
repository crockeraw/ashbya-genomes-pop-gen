library("vcfR")

vcf <- read.vcfR("source_data/mito_all.vcf")

# need to pipe std-out to file. numer non-biallelic variants removed.

# load reference genome and annotations for sick plots. 

dna_file <- 'source_data/mito.fa'
gff_file <- 'source_data/mito.gff3'
dna <- ape::read.dna(dna_file, format = "fasta")
gff <- read.table(gff_file, sep="\t", quote="")

# Create a chromR object, produce pre-filtered QC plots
chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)
chrom <- proc.chromR(chrom, verbose=TRUE, win.size = 100)
png("images/pre-filteringQC.png")
chromoqc(chrom, dp.alpha = 66)
dev.off()
png("images/pre-filteringQC_hist.png")
plot(chrom)
dev.off()

# Quality filter and plot post-filtering QC
vcf <- read.vcfR("source_data/mito_vars.vcf")
chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)
chrom <- proc.chromR(chrom, verbose=TRUE, win.size = 100)
png("images/post-filteringQC.png")
chromoqc(chrom, dp.alpha = 66)
dev.off()
png("images/post-filteringQC_hist.png")
plot(chrom)
dev.off()

