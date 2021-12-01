<link rel="stylesheet" href="https://unpkg.com/purecss@2.0.6/build/pure-min.css" integrity="sha384-Uu6IeWbM+gzNVXJcM9XV3SohHtmWE+3VGi496jvgX1jyvDTXfdK+rfZc8C1Aehk5" crossorigin="anonymous">

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
# BIOS616 Project Report: Ashbya mt genome analysis

- [1. Project Overview](#Intro)
- [2. Quality Analysis](#QA)
  - [Before Filtering](#pre)
  - [After Filtering](#post)
- [3. PCA and Clustering](#DIM)
  - [PCA](#PCA)
  - [K-means](#Kmeans)
  - [DAPC](#DAPC) 
  - [Metadata: Sample Source](#meta)
  - [Metadata: Geography](#geo)
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
To better understand the structure of the data we can use the Kmeans algorithm to group similar samples into an arbitrary number (K) of groups. First, we might want to get a measure of how well different numbers of clusters fit the data. Here I use the Bayesian information criterion (BIC) as a metric for that. BIC is difficult for me to understand, but it increases as a function of the variance of the error and of K, meaning in general **lower scores are better**.\

<img src="images/kmeans_test.png" width="500"/>

So let's just take a look at how the data is grouped - using the PC embedding of the data - when we use K=10...\

<img src="images/pca_10means.png" width="500"/>

This is all pretty subjective, but it seems kind of useless to have that many clusters to me. Something like 3 or 5 might suit us better given how the data looks. Let's try 5.\

<img src="images/pca_5means.png" width="500"/>

### Discriminant analysis of principal components <a name="DAPC"></a>

<a href="https://bmcgenomdata.biomedcentral.com/articles/10.1186/1471-2156-11-94">Jombart et al. 2010</a> introduced a method called Discriminant Analysis of Principal Components (DAPC), which relies on sequential Kmeans clustering to choose underlying models and predict genetic clustering.\

<img src="images/DAPC_5means.png" width="500"/>

### Metadata in DAPC space <a name="meta"></a>

It would be great if we knew something about the samples, aside from the sequencing information. Fortunately, we do. Unfortunately, it is a bit sparse; some of these samples do not include information about the sample source, but many do. \
\
Ashbya is associated with bugs that grow on plants (most commonly milkweed). By plotting in DAPC space and coloring by group association, we might hope to see that our clusters actually correspond well to some variable in the meta-data.\

<p float="left">
<img src="images/DAPC_byPlant.png" width="500"/>
<img src="images/DAPC_byBug.png" width="500"/>
</p>


### Clusters in Geographical space <a name="geo"></a>

Another piece of information we have about these samples is the latitude and longitude at which they were collected. By plotting samples in coordinate space and coloring them by the clusters to which they were assigned, we hope to learn about geographic population structure, or about whether it exists. Since many samples were taken in the same location, I have added some random "jitter" to the points in the plot and use both DAPC (left) and PCA (right). \

<p float="left">
<img src="images/geographic_byDAPC.png" width="500" height="300"/>
<img src="images/geographic_byPCA.png" width="500" height="300"/>
</p>

## Phylogenetics <a name='phylo'></a>

Trees and linkage and stuff.

### Trees

Based on distance metric, colored with Kmeans groupings.\

<img src="images/phylo_tree.png" width="800"/>

