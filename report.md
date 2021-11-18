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

## Quality Analysis <a name="QA"></a>

### Pre-Filtering

<p float="left">
  <img src="images/pre-filteringQC.png" width="500"/>
  <img src="images/pre-filteringQC_hist.png" width="500"/> 
</p>

### Post-Filtering

<p float="left">
  <img src="images/post-filteringQC.png" width="500"/>
  <img src="images/post-filteringQC_hist.png" width="500"/> 
</p>

## Dimensionality Reduction and Clustering <a name="PCA"></a>

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
