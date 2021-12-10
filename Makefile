SHELL := /bin/bash

report.html: report.md images/pre-filteringQC.png images/pca.png
	pandoc report.md -t html -o report.html

.PHONY: clean images

clean:
	rm -f derived_data/*
	rm -f images/*
	
images: images/pre-filteringQC.png images/pca.png

images/pre-filteringQC.png\
 images/pre-filteringQC_hist.png: seq_sum_stats.r source_data/filtered_vars_biallelic_seen2x.vcf
	Rscript seq_sum_stats.r

images/pca.png\
 images/kmeans_test.png\
 iamges/pca_10means.png\
 images/pca_5means.png\
 images/DAPC_5means.png\
 images/DAPC_byPlant.png\
 images/DAPC_byBug.png\
 images/geographic_byDAPC.png\
 images/geographic_byPCA.png: dim_reduction.r source_data/filtered_vars_biallelic_seen2x.vcf
	Rscript dim_reduction.r

source_data/filtered_vars_biallelic_seen2x.vcf:
	wget --no-check-certificate\
 'https://www.dropbox.com/s/xnq3hzfzcuw92yw/filtered_vars_biallelic_seen2x.vcf?dl=0'\
 -O source_data/filtered_vars_biallelic_seen2x.vcf