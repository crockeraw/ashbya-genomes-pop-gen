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
# Report: Ashbya core genomes

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
Empty...

## Quality Analysis <a name="QA"></a>
*Ashbya* genomes were sequenced with paired-end, short-read technology, and aligned to the *Ashbya* reference genome.
Following alignment, variants (SNPs and indels) were called using bcftools.\
Only biallelic loci with high quality were used.

### Pre-Filtering <a name="pre"></a>
Pre-filtering data includes information like the sequencing depth and quality scores of each nucleotide. Major changes in sequencing depth (and quality) could indicate regions that are lost or duplicated in certain isolates.
<p float="left">
  <img src="images/pre-filteringQC.png" width="500"/>
  <img src="images/pre-filteringQC_hist.png" width="500"/> 
</p>

### Post-Filtering <a name="post"></a>
After filtering, some large regions are lost. These likely include important information, but are not amenable to the types of analyses I am doing in this report. Subsequent analyses might include the construction of a pan-genome for these isolates, and comparison of presence/absence of large regions. 
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



