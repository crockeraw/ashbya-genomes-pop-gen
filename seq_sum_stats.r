library("vcfR")

# import full merged, unfiltered A.g. vcf file as vcfR object.
# for project demo include only the mito genome, reduce sample number if necessary.
#### vcf <- read.vcfR("vcfs_misc/merged.vcf")
vcf <- read.vcfR("vcfs_misc/mito.vcf")
# convert to genlight object for use with fxns in genlight pkg.
x <- vcfR2genlight(vcf)
# need to pipe std-out to file. numer non-biallelic variants removed.
# load reference genome and annotations for sick plots. 
#### dna_file <- 'GCF_000091025.4_ASM9102v4_genomic.fna'
#### gff_file <- 'GCF_000091025.4_ASM9102v4_genomic.gff'
dna_file <- 'vcfs_misc/mito.fa'
gff_file <- 'vcfs_misc/mito.gff3'
dna <- ape::read.dna(dna_file, format = "fasta")
gff <- read.table(gff_file, sep="\t", quote="")
# Create a chromR object for those sick plots.
chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)
# And now for... those sick plots
plot(chrom)
chrom <- masker(chrom, min_QUAL = 100, min_DP = 1000, min_MQ = 50)
# AT this point snp densities have not been calculated.
chrom <- proc.chromR(chrom, verbose=TRUE, win.size = 100)
plot(chrom)
chromoqc(chrom, dp.alpha = 66)