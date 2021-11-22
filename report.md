<style type="text/css">
.main-container {
  max-width: 1800px;
  margin-left: auto;
  margin-right: auto;
}
</style>
---
output:
  html_document: default
  pdf_document: default
---
# Report

- [1. Project Overview](#Intro)
- [2. Quality Analysis](#QA)
  - [Before Filtering](#sub1)
  - [After Filtering](#sub2)
- [3. PCA and Clustering](#PCA)
  - [sub3](#sub3)
  - [sub4](#sub4)
  - [metadata](#meta) 
- [4. Phylogentics](#phylo)
  - [trees](#trees)
  - [linkage diseqalibrium](#LD)
- [5. Links](#links)

## Project Overview <a name="Intro"></a>
This report summarizes my analysis of 48 (46 after cleaning) *Ashbya gosypii* mitochondrial genomes. Mitochondrial genomes do not recombine and the genetic variation between mitrochondria accumulates with genetic distance. This information can be useful for understanding speciation, especially in combination with nuclear genome information. This is the first dataset with more than two *Ashbya* mitochondrial genomes, and points to the existance of multiple populations, which may be distinct species or sub-species. The populations are not clearly geographically defined, but may associate with distinct bug/plant speices.

## Quality Analysis <a name="QA"></a>
*Ashbya* genomes were sequenced with paired-end, short-read technology, and aligned to the *Ashbya* reference genome.
Following alignment, variants (SNPs and indels) were called using bcftools.\
The file `source_data/mito.vcf` includes base calls at all loci in the reference, even where no variation was detect, while the file `source_data/mito_vars.vcf` includes only loci with at least 2 different alleles, and which meet quality thresholds.

### Pre-Filtering <a name="pre"></a>
Pre-filtering data from the file `source_data/mito.vcf` includes information like the sequencing depth and quality scores of each nucleotide. Major changes in sequencing depth (and quality) could indicate regions that are lost or duplicated in certain isolates.
<p float="left">
  <img src="images/pre-filteringQC.png" width="500"/>
  <img src="images/pre-filteringQC_hist.png" width="500"/> 
</p>

### Post-Filtering <a name="post"></a>
After filtering, some large regions are lost. These likely include important information, but are not amenable to the types of analyses I am doing in this report. Subsequent analyses might include the construction of a mitochondrial pan-genome for these isolates, and comparison of presence/absence of large regions. 
<p float="left">
  <img src="images/post-filteringQC.png" width="500"/>
  <img src="images/post-filteringQC_hist.png" width="500"/> 
</p>

## Dimensionality Reduction and Clustering <a name="DIM"></a>
In order to get an idea of the differences between individuals it is helpful to reduce the number of dimensions to two so that we can easily visualize them. We can also use clustering algorithms to group data in the high-dimensional space 

### Dimensionality Reduction using PCA <a name="PCA"></a>
PCA produces an eigen-decomposition such that the dimensions are orded by how much of the variance in the dataset they explain. \
<img src="images/perc_var.png" width="430"/> \
We can see that the first component/dimension actually accounts for more than half of all variance, after which the value quickly drops so that by PC10 it is account for less than 1% of all variance. In total the first 10 PCs account for 86.8% of the total variance in the (originally) 1475-dimensional space. \
\
Next we cna plot the first two PCs to get an idea of how our samples are separated.

<img src="images/pca.png" width="430"/>

### Kmeans Clustering <a name="Kmeans"></a>
To better understand the structure of the data we can use Kmeans to group similar samples into an arbitrary number (K) of groups. First, we might want to get a measure of 

<img src="images/kmeans_test.png" width="500"/>

<img src="images/pca_10means.png" width="500"/>

<img src="images/pca_5means.png" width="500"/>

### Discriminant analysis of principal components

<img src="images/DAPC_5means.png" width="500"/>

### Metadata in DAPC space

<img src="images/DAPC_byPlant.png" width="500"/>

<img src="images/DAPC_byBug.png" width="500"/>

### Clusters in Geographical space

<img src="images/geographic_byDAPC.png" width="500"/>

<img src="images/geographic_byPCA.png" width="500"/>
