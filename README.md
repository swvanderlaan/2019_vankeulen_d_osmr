Common variants associated with OSMR expression contribute to carotid plaque vulnerability, but not to cardiovascular disease in humans
===========================================================

#### This readme
This readme accompanies the paper _"Common variants associated with OSMR expression contribute to carotid plaque vulnerability, but not to cardiovascular disease in humans."_ by [Van Keulen D. *et al*. **bioRxiv 2019**](https://doi.org/10.1101/576793).

--------------

#### Abstract

**Background and aims**
Oncostatin M (OSM) signaling is implicated in atherosclerosis, however the mechanism remains unclear. We investigated the impact of common genetic variants in OSM and its receptors, _OSMR_ and _LIFR_, on overall plaque vulnerability, plaque phenotype, intraplaque _OSMR_ and _LIFR_ expression, coronary artery calcification burden and cardiovascular disease susceptibility.

**Methods and results**
We queried Genotype-Tissue Expression data and found rs13168867 (C allele) and rs10491509 (A allele) to be associated with decreased _OSMR_ and increased _LIFR_ expression in arterial tissue respectively. No variant was significantly associated with _OSM_ expression.
We associated these two variants with plaque characteristics from 1,443 genotyped carotid endarterectomy patients in the Athero-Express Biobank Study. rs13168867 was associated with an increased overall plaque vulnerability (β = 0.118 ± 0.040 s.e., _p_ = 3.00x10<sup>-3</sup>, C allele) and although not significant after correction for multiple testing, it showed strongest associations with intraplaque fat (β = 0.248 ± 0.088 s.e., C allele) and collagen content (β = -0.259 ± 0.095 s.e., C allele). rs13168867 was not associated with intraplaque _OSMR_ expression. Neither was intraplaque _OSMR_ expression associated with plaque vulnerability and no known _OSMR_ eQTLs were associated with coronary artery calcification burden, or cardiovascular disease susceptibility. No associations were found for rs10491509 in the _LIFR_ locus.  

**Conclusions**
Our study suggests that genetically decreased arterial _OSMR_ expression contributes to increased carotid plaque vulnerability. However, the OSM signaling pathway is unlikely to be causally involved in lifetime cardiovascular disease susceptibility as none of the investigated variants associated with cardiovascular diseases.

#### Analysis Scripts
Surely these scripts will not work immediately on your systems, but they may be used and edited for local use.
 
- *SNP/lookup.sh*</br>
Script to lookup variants in GWAS summary statistics. These data are downloaded to our high-performance computing cluster. The scripts works on the our HPC.
- *SNP/variantlist.txt*</br>
Variants investigated.
- *SNP/phenotypes.txt*</br>
Phenotypes investigated.
- *SNP/gwastoolkit.conf*</br>
[**GWASToolKit**](https://github.com/swvanderlaan/GWASToolKit) configuration file.
- *SNP/covariates.txt*</br>
Covariates included.
- *RNAseq/20181211_OSMR_LIFR_RNAseq_analysis.RMD*</br>
R markdown file for the RNAseq analysis of eQTLs and plaque phenotypes.
- *RNAseq/20190429_Group_comparisons.html*</br>
HTML including codes used and results of the RNAseq analysis of eQTLs and plaque phenotypes.

#### Notes
Scripts will work within the context of a certain Linux environment, for example a CentOS7 system on a SUN Grid Engine background or macOS X Lion+ (version 10.7.[x]+). 


--------------

#### The MIT License (MIT)
##### Copyright (c) 1979-present Sander W. van der Laan | s.w.vanderlaan [at] gmail [dot] com.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:   

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Reference: http://opensource.org.
