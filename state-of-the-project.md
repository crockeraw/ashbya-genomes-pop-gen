# State of this project

## Multiple species represented?
When aligned to A. gossypii genome one of the two main branches (by genetic distance) mapped at ~95%, the other only mapped at ~75%.

When aligned to A. aceris genome, mapping percentages were rougly reversed.

Some isolates had low percent reads mapped to either species, but still showed clear preference for mapping to one or the other. Curious if bacteria associated with the fungus could have contaminated? Or could have just been human or technical error contamination.

I have read mapping statistics, generated with samtools flagstat applied to BAM files, saved in scratch space on my Longleaf account, currently. Need to back this up! Have only read the file manually, never loaded to R or anything. 

Would like to re-do anlyses I have done, and do now analyses like LD and IA, using only single-species populations. 

## SNP effects and user-friendly variant table
I have used snpEFF to annotate variant effects, and make to make summary stats document. This is not inlcuded in this remote repo.

The current table is for all genes and compresses info from all isolates. I should really just run the same program on individual VCFs, but I have not done this yet. 

There is evidence from variants that certain isolates are highly heterozygous. Other isolates are not at all. I suspect this is a A. gossypii vs A. aceris difference. Not sure if ploidy of A. aceris has been determined. No mention of ploidy in Fred Dietrich 2013 paper. 

## Predictive models based on metadata

Did linear and logistic regressions using Plant, Insect, Latitude, and Longitude as independent variables and PC1, PC2, LD1, LD2, or cluster(with 2 groups) as dependent. Plant was pretty much always the most informative variable. This anlaysis was quick n dirty as has not been included in the repo yet. 