.PHONY: clean
SHELL: /bin/bash

clean:
	rm -f derived_data/*
	rm -f images/*
	mkdir images

images/pre-filteringQC.png\
 pre-filteringQC_hist.png\
 post-filteringQC.png\
 post-filteringQC_hist.png: seq_sum_stats.r mito.vcf mito_vars.vcf
	Rscript seq_sum_stats.r
