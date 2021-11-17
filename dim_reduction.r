library("vcfR")
library("adegenet")
library("tidyverse")
library(ggplot2)
library(reshape2)

# Load and clean file
vcf <- read.vcfR("source_data/mito_filtered.vcf")
# Replace with only the REF ID that would be used in the metadata sheet:
res <- str_match(colnames(vcf@gt)[-1], "bams/\\s*(.*?)\\s*ASGY")[,2]
colnames(vcf@gt)[-1] <- res
# Remove first two sample columns, which are likely from duplicate (clonal) samples
vcf@gt <- vcf@gt[,-c(2,3)]

# PCA
gl <- vcfR2genlight(vcf)
pca1 <- glPca(gl, nf=10)
pc_points <- as.data.frame(pca1$scores)
p0 <- ggplot(pc_points, aes(x = PC1, y = PC2)) + theme_bw() + geom_point(size = 4, shape = 21, alpha=.66, fill='grey', colour="dark grey")
png("images/pca.png")
p0
dev.off()

# Check multiple K for clustering multiple times
maxK <- 23
kMat <- matrix(nrow=10, ncol=maxK)
colnames(kMat) <- 1:ncol(kMat)
for(i in 1:nrow(kMat)){
  grp <- find.clusters(gl, glPca=pca1, n.pca = 10, choose.n.clust = FALSE,  max.n.clust = maxK)
  kMat[i,] <- grp$Kstat
}
my_df <- melt(kMat)
colnames(my_df)[1:3] <- c("Group", "K", "BIC")
my_df$K <- as.factor(my_df$K)
p1 <- ggplot(my_df, aes(x = K, y = BIC)) + geom_boxplot() + theme_bw() + xlab("Number of groups (K)")
png("images/kmeans_test.png")
p1
dev.off()

# PCA with labelled clusters 
clust <- find.clusters(gen, glPca=pca1, n.pca= 10, n.clust=10)
pal10 <- RColorBrewer::brewer.pal(n=10, name = "Paired")
p2 <- ggplot(pc_points, aes(x = PC1, y = PC2, color = clust$grp, fill = clust$grp))
p2 <- p2 + geom_point(size = 4, shape = 21)
p2 <- p2 + theme_bw()
p2 <- p2 + scale_color_manual(values=c(pal10))
p2 <- p2 + scale_fill_manual(values=c(paste(pal10, "66", sep = "")))
png("images/pca_10means.png")
p2
dev.off()

clust <- find.clusters(gen, glPca=pca1, n.pca= 10, n.clust=5)
plot(pca1$scores, col=factor(clust$grp))
p3 <- ggplot(pc_points, aes(x = PC1, y = PC2, color = clust$grp, fill = clust$grp))
p3 <- p3 + geom_point(size = 4, shape = 21)
p3 <- p3 + theme_bw()
p3 <- p3 + scale_color_manual(values=c(my_pal))
p3 <- p3 + scale_fill_manual(values=c(paste(pal10, "66", sep = "")))
png("images/pca_5means.png")
p3
dev.off()
# Discriminant analysis of principal components
dapc <- dapc(gl, glPca = pca1, pop=clust$grp, n.pca=10, n.da=10)
dapc_df <- as.data.frame(dapc$ind.coord)
dapc_df$Group <- dapc$grp

my_pal <- RColorBrewer::brewer.pal(n=8, name = "Dark2")
p4 <- ggplot(dapc_df, aes(x = LD1, y = LD2, color = Group, fill = Group))
p4 <- p4 + geom_point(size = 4, shape = 21)
p4 <- p4 + theme_bw()
p4 <- p4 + scale_color_manual(values=c(my_pal))
p4 <- p4 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p4
png("images/DAPC_5means.png")
dev.off()

# Label with metadata
meta <- as.data.frame(read.table("proj/source_data/metadata.csv", sep = ",", header = TRUE))
merged <- merge(pc_points,meta[,c("LAT", "LON", "plant", "bug.species")],by=0,x.all=TRUE)
merged[merged==""] <- NA

p5 <- ggplot(dapc_df, aes(x = LD1, y = LD2, color = merged$plant, fill = merged$plant))
p5 <- p5 + geom_point(size = 4, shape = 21)
p5 <- p5 + theme_bw()
p5 <- p5 + scale_color_manual(values=c(my_pal),na.value="grey") 
p5 <- p5 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p5
png("images/dapc_byPlant.png")
dev.off()

merged$bug.species <- tolower(merged$bug.species)
p6 <- ggplot(dapc_df, aes(x = LD1, y = LD2, color = merged$bug.species, fill = merged$bug.species))
p6 <- p6 + geom_point(size = 4, shape = 21)
p6 <- p6 + theme_bw()
p6 <- p6 + scale_color_manual(values=c(my_pal),na.value="grey") 
p6 <- p6 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p6
png("images/dapc_byBug.png")
dev.off()

p7 <- ggplot(merged, aes(x = LON, y = LAT, color = dapc_df$GROUP, fill = dapc_df$Group))
p7 <- p7 + geom_jitter(size = 4, shape = 21, width = 1, height = 3)
p7 <- p7 + theme_bw()
p7 <- p7 + scale_color_manual(values=c(my_pal),na.value="grey") 
p7 <- p7 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p7
png("images/geographic_byDAPC.png")
dev.off()

p8 <- ggplot(merged, aes(x = LON, y = LAT, color = clust$grp, fill = clust$grp))
p8 <- p8 + geom_jitter(size = 4, shape = 21, width = 1, height = 3)
p8 <- p8 + theme_bw()
p8 <- p8 + scale_color_manual(values=c(my_pal),na.value="grey") 
p8 <- p8 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p8
png("images/geographic_byPCA.png")
dev.off()