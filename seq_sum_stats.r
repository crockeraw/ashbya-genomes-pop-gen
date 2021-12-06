library("vcfR")

dir.create("images",showWarnings = FALSE)

vcf <- read.vcfR("source_data/filtered_vars_biallelic_seen2x_thin100.vcf")
dna_file <- 'source_data/GCF_000091025.4_ASM9102v4_genomic.fna'
gff_file <- 'source_data/GCF_000091025.4_ASM9102v4_genomic.gff'
dna <- ape::read.dna(dna_file, format = "fasta")
gff <- read.table(gff_file, sep="\t", quote="")

# Create a chromR object, produce pre-filtered QC plots
chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)
chrom <- proc.chromR(chrom, verbose=TRUE, win.size = 10000)
png("images/pre-filteringQC.png")
chromoqc(chrom, dp.alpha = 66)
dev.off()
png("images/pre-filteringQC_hist.png")
plot(chrom)
dev.off()
