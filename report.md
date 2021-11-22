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

- [1. About the Data](#Intro)
  - [Description](#idk)
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
The file `source_data/mito.vcf` includes base calls at all loci in the reference, even where no variation was detect, while the file `source_data/mito_vars.vcf` includes only loci with at least 2 different alleles, and which meet quality thresholds.\
### Pre-Filtering
Pre-filtering data from the file `source_data/mito.vcf` includes information like the sequencing depth and quality scores of each nucleotide. Major changes in sequencing depth (and quality) could indicate regions that are lost or duplicated in certain isolates.
<p float="left">
  <img src="images/pre-filteringQC.png" width="500"/>
  <img src="images/pre-filteringQC_hist.png" width="500"/> 
</p>

### Post-Filtering
After filtering, some large regions are lost. These likely include important information, but are not amenable to the types of analyses I am doing in this report. Subsequent analyses might include the construction of a mitochondrial pan-genome for these isolates, and comparison of presence/absence of large regions. 
<p float="left">
  <img src="images/post-filteringQC.png" width="500"/>
  <img src="images/post-filteringQC_hist.png" width="500"/> 
</p>

## Dimensionality Reduction and Clustering 
In order to get an idea of the differences between individuals, I transformed variant-space into its principle components. PC1 and PC2, which collectively account for ??% of the variance between individuals.

! NEED %VAR BY PC PLOT !

<a name="PCA"></a>

### Dimensionality Reduction using PCA

<img src="images/pca.png" width="430"/>

### Kmeans Clustering 

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
