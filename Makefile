.PHONY: clean
SHELL: /bin/bash

clean:
	rm -f derived_data/*
	rm -f images/*

images: images/pre-filteringQC.png images/pca.png

images/pre-filteringQC.png\
 pre-filteringQC_hist.png\
 post-filteringQC.png\
 post-filteringQC_hist.png: seq_sum_stats.r mito.vcf mito_vars.vcf
	Rscript seq_sum_stats.r

images/pca.png\
 images/kmeans_test.png\
 iamges/pca_10means.png\
 images/pca_5means.png\
 images/DAPC_5means.png\
 images/DAPC_byPlant.png\
 images/DAPC_byBug.png\
 images/geographic_byDAPC.png\
 images/geographic_byPCA.png: dim_reduction.r mito_vars.vcf
	Rscript dim_reduction.r