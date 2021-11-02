.PHONY: clean
SHELL: /bin/bash

clean:
	rm -f derived_data/*
	rm -f figures/*

imgaes/pre-filteringQC.png\
 pre-filteringQC_hist.png\
 post-filteringQC.png\
 post-filteringQC_hist.png:\
	Rscript seq_sum_stats.r
