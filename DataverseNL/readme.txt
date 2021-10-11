#README
author: Sander W. van der Laan | s.w.vanderlaan-2@umcutrecht.nl
last edit: 2021-10-11

This folder contains the data as it was shared through DataverseNL.


FILES
vsd_genes_interest.txt												Matix of gene counts normalized through DESeq2 functiona "VST" (ref: https://rdrr.io/bioc/DESeq2/man/varianceStabilizingTransformation.html)
metadata_vulnerability.txt											Meta data matching the gene count matrix
aegs_combo_1kGp3GoNL5_RAW_chr5.OSMR.vcf.gz							VCF file of genotype probabilities (https://en.wikipedia.org/wiki/Variant_Call_Format)
aegs_combo_1kGp3GoNL5_RAW_chr5.OSMR.sample							OXFORD-style file format of samples in genetic data, matching VCF and .GEN file; note this file is edited to include the STUDY_NUMBERS, see below (https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.html#input_file_formats, https://www.well.ox.ac.uk/~gav/qctool/documentation/sample_file_formats.html)
aegs_combo_1kGp3GoNL5_RAW_chr5.OSMR.gen								OXFORD-style file format of genetic data, matching VCF and .sample file (https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.html#input_file_formats, https://www.well.ox.ac.uk/~gav/qctool/documentation/genotype_file_formats.html)
20020410_Approval_Protocol_TME_Athero-Express_Biobank_Study.pdf		METC Approval of the Athero-Express Biobank Study
20211007_DMP_Athero-Express_Biobank_Study.pdf						DMP of the Athero-Express Biobank Study
Athero-Express_Biobank_Study_IC_versie_4.doc						Example Informed Consent of the Athero-Express Biobank Study

The sample-file was edited to include the STUDY_NUMBERS and also stored in 
'aegs_combo_1kGp3GoNL5_RAW_chr5.OSMR.xlsx'; the matching was done based on 
'20190115_AEGS_AExoS_FAM_SAMPLE_FILE_BASE_MINIMAL_v1_2.xlsx'.

'aegs_combo_1kGp3GoNL5_RAW_chr5.OSMR.xlsx' is stored in /Users/swvanderlaan/OneDrive - UMC Utrecht/PLINK/analyses/lookups/2019_vankeulen_d_osmr/data
'20190115_AEGS_AExoS_FAM_SAMPLE_FILE_BASE_MINIMAL_v1_2.xlsx' is stored in /Users/swvanderlaan/OneDrive - UMC Utrecht/Genomics/AE-AAA_GS_DBs/_AE_Omics

Note that these files are not shared through Git! 


Sample file columns

Column					Description												Values (when applicable)
ID_1					ID1 for SNPTEST; unique patient ID (UPID). 
						Note this is NOT the hospital number, the UPID 
						is automatically and randomly generated to 
						indicate an individual so that we can couple 
						sampleIDs (STUDY_NUMBERS) to individuals. This 
						was necessary since one individual can be 
						operated multiple times on the same artery, 
						and obviously we only need to genotype once. 	
ID_2					ID2 for SNPTEST; combination of UPID and 	
missing					missing data column; legacy column for SNPTEST	
STUDY_NUMBER			sample ID, the unique study number in the AE	
COHORT					genotyping array										0 = Affy SNP5, 1 = Affy Axiom CEU)
STUDY_TYPE				type of surgery											1 = CEA, 2 = FEA, 3 = Other
sex						gender	
Age						age at inclusion in years	
OR_year					year of surgery	
OR_year_C				date of surgery in epochs	
PC1						principal component 1	
PC2						principal component 2	
PC3						principal component 3	
PC4						principal component 4	
PC5						principal component 5	
PC6						principal component 6	
PC7						principal component 7	
PC8						principal component 8	
PC9						principal component 9	
PC10					principal component 10	
Calcification_bin		amount of calcification								0 = no/minor staining; 1 = moderate/heavy staining
Collagen_bin			amount of collagen									0 = no/minor staining; 1 = moderate/heavy staining
SMC_bin					amount of smooth muscle cells						0 = no/minor staining; 1 = moderate/heavy staining
Macrophages_bin			amount of macrophages								0 = no/minor staining; 1 = moderate/heavy staining
Fat40_bin				atheroma size at 40%								0 = no/<40% fat; 1 = >40% fat
Fat10_bin				atheroma size at 10%								0 = no/<10% fat; 1 = >10% fat
IPH						intraplaque hemorrhage								0 = no; 1 = yes
Macrophages_BC			% of macrophages	
SMC_BC					% of smooth muscle cells	
Neutrophils_BC			number of neutrophils	
Mastcells_BC			number of mast cells	
VesselDensityAvg_BC		number of intraplaque vessels per 3-4- hotspots	
Stability				plaque vulnerability index	0-4, where 0 is most stable, 4 is least stable