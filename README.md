Common variants associated with OSMR expression contribute to carotid plaque vulnerability, but not to cardiovascular disease in humans
===========================================================

[![DOI](https://zenodo.org/badge/283594863.svg)](https://zenodo.org/badge/latestdoi/283594863)

#### This readme
This readme accompanies the paper _"Common variants associated with OSMR expression contribute to carotid plaque vulnerability, but not to cardiovascular disease in humans."_ by [Van Keulen D. *et al*. **Front. Cardiovasc. Med. 2021**](https://doi.org/10.3389/fcvm.2021.658915), and published as preprint on [**bioRxiv 2019**](https://doi.org/10.1101/576793).

--------------

#### Abstract

**Background and aims**
Oncostatin M (OSM) signaling is implicated in atherosclerosis, however the mechanism remains unclear. We investigated the impact of common genetic variants in _OSM_ and its receptors, _OSMR_ and _LIFR_, on overall plaque vulnerability, plaque phenotype, intraplaque _OSMR_ and _LIFR_ expression, coronary artery calcification burden and cardiovascular disease susceptibility.

**Methods and results**
We queried Genotype-Tissue Expression data and found that rs13168867 (C allele) was associated with decreased _OSMR_ expression and that rs10491509 (A allele) was associated with increased _LIFR_ expression in arterial tissues. No variant was significantly associated with OSM expression.

We associated these two variants with plaque characteristics from 1,443 genotyped carotid endarterectomy patients in the Athero-Express Biobank Study. After correction for multiple testing, rs13168867 was significantly associated with an increased overall plaque vulnerability (β=0.118 ± s.e.=0.040, _p_=3.00x10<sup>-3</sup>, C allele). Looking at individual plaque characteristics, rs13168867 showed strongest associations with intraplaque fat (β=0.248 ± s.e.=0.088, _p_=4.66x10<sup>-3</sup>, C allele) and collagen content (β=-0.259 ± s.e.=0.095, _p_=6.22x10<sup>-3</sup>, C allele), but these associations were not significant after correction for multiple testing. rs13168867 was not associated with intraplaque _OSMR_ expression. Neither was intraplaque _OSMR_ expression associated with plaque vulnerability and no known _OSMR_ eQTLs were associated with coronary artery calcification burden, or cardiovascular disease susceptibility. No associations were found for rs10491509 in the _LIFR_ locus.  

![**Association of OSMR and LIFR variants with overall plaque vulnerability.** Adapted from [Van Keulen D. *et al*. **Front. Cardiovasc. Med. 2021**](https://doi.org/10.3389/fcvm.2021.658915)](images/figure2.jpg)


<br>
**Conclusions**
Our study suggests that rs1316887 in the _OSMR_ locus is associated with increased plaque vulnerability, but not with coronary calcification or cardiovascular disease risk. It remains unclear through which precise biological mechanisms OSM signaling exerts its effects on plaque morphology. However, the OSM-OSMR/LIFR pathway is unlikely to be causally involved in lifetime cardiovascular disease susceptibility.

<br>

#### Analysis Scripts
Surely these scripts will not work immediately on your systems, but they may be used and edited for local use.
 
- *SNP/lookup.sh*</br>
Script to lookup variants in GWAS summary statistics. These data are downloaded to our high-performance computing cluster. The scripts works on our HPC.
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

<br>

#### Data
The data is available through [DataverseNL](https://doi.org/10.34894/0RB5IZ). 

<br>

#### Notes
Scripts will work within the context of a certain Linux environment, for example a CentOS7 system on a SUN Grid Engine background or macOS X Lion+ (version 10.7.[x]+). 


--------------

#### The MIT License (MIT)
##### Copyright (c) 1979-present Sander W. van der Laan | s.w.vanderlaan-2 [at] gmail [dot] com.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:   

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Reference: http://opensource.org.
