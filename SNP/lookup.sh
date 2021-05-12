#!/bin/bash
#

#$ -S /bin/bash 																			# the type of BASH you'd like to use
#$ -N lookup  																	# the name of this script
# -hold_jid some_other_basic_bash_script  													# the current script (basic_bash_script) will hold until some_other_basic_bash_script has finished
#$ -o /hpc/dhl_ec/svanderlaan/projects/lookups/oncostatinm/lookup.log  								# the log file of this job
#$ -e /hpc/dhl_ec/svanderlaan/projects/lookups/oncostatinm/lookup.errors 							# the error file of this job
#$ -l h_rt=00:15:00  																		# h_rt=[max time, e.g. 02:02:01] - this is the time you think the script will take
#$ -l h_vmem=8G  																			#  h_vmem=[max. mem, e.g. 45G] - this is the amount of memory you think your script will use
# -l tmpspace=64G  																		# this is the amount of temporary space you think your script will use
#$ -M s.w.vanderlaan-2@umcutrecht.nl  														# you can send yourself emails when the job is done; "-M" and "-m" go hand in hand
#$ -m ea  																					# you can choose: b=begin of job; e=end of job; a=abort of job; s=suspended job; n=no mail is send
#$ -cwd  																					# set the job start to the current directory - so all the things in this script are relative to the current directory!!!
#
### INTERACTIVE SHELLS
# You can also schedule an interactive shell, e.g.:
#
# qlogin -N "basic_bash_script" -l h_rt=02:00:00 -l h_vmem=24G -M s.w.vanderlaan-2@umcutrecht.nl -m ea
#
# You can use the variables above (indicated by "#$") to set some things for the submission system.
# Another useful tip: you can set a job to run after another has finished. Name the job 
# with "-N SOMENAME" and hold the other job with -hold_jid SOMENAME". 
# Further instructions: https://wiki.bioinformatics.umcutrecht.nl/bin/view/HPC/HowToS#Run_a_job_after_your_other_jobs
#
# It is good practice to properly name and annotate your script for future reference for
# yourself and others. Trust me, you'll forget why and how you made this!!!

### Creating display functions
### Setting colouring
NONE='\033[00m'
BOLD='\033[1m'
ITALIC='\033[3m'
OPAQUE='\033[2m'
FLASHING='\033[5m'
UNDERLINE='\033[4m'

RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
### Regarding changing the 'type' of the things printed with 'echo'
### Refer to: 
### - http://askubuntu.com/questions/528928/how-to-do-underline-bold-italic-strikethrough-color-background-and-size-i
### - http://misc.flogisoft.com/bash/tip_colors_and_formatting
### - http://unix.stackexchange.com/questions/37260/change-font-in-echo-command

### echo -e "\033[1mbold\033[0m"
### echo -e "\033[3mitalic\033[0m" ### THIS DOESN'T WORK ON MAC!
### echo -e "\033[4munderline\033[0m"
### echo -e "\033[9mstrikethrough\033[0m"
### echo -e "\033[31mHello World\033[0m"
### echo -e "\x1B[31mHello World\033[0m"

function echobold { #'echobold' is the function name
    echo -e "${BOLD}${1}${NONE}" # this is whatever the function needs to execute, note ${1} is the text for echo
}
function echoitalic { 
    echo -e "${ITALIC}${1}${NONE}" 
}
function echocyan { 
    echo -e "${CYAN}${1}${NONE}" 
}

function echonooption { 
    echo -e "${OPAQUE}${RED}${1}${NONE}"
}

# errors
function echoerrorflash { 
    echo -e "${RED}${BOLD}${FLASHING}${1}${NONE}" 
}
function echoerror { 
    echo -e "${RED}${1}${NONE}"
}

# errors no option
function echoerrornooption { 
    echo -e "${YELLOW}${1}${NONE}"
}
function echoerrorflashnooption { 
    echo -e "${YELLOW}${BOLD}${FLASHING}${1}${NONE}"
}

### MESSAGE FUNCTIONS
script_copyright_message() {
	echo ""
	THISYEAR=$(date +'%Y')
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "+ The MIT License (MIT)                                                                                 +"
	echo "+ Copyright (c) 2016-${THISYEAR} Sander W. van der Laan                                                        +"
	echo "+                                                                                                       +"
	echo "+ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and     +"
	echo "+ associated documentation files (the \"Software\"), to deal in the Software without restriction,         +"
	echo "+ including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, +"
	echo "+ and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, +"
	echo "+ subject to the following conditions:                                                                  +"
	echo "+                                                                                                       +"
	echo "+ The above copyright notice and this permission notice shall be included in all copies or substantial  +"
	echo "+ portions of the Software.                                                                             +"
	echo "+                                                                                                       +"
	echo "+ THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT     +"
	echo "+ NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                +"
	echo "+ NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES  +"
	echo "+ OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN   +"
	echo "+ CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                            +"
	echo "+                                                                                                       +"
	echo "+ Reference: http://opensource.org.                                                                     +"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}
script_arguments_error() {
	echoerror "$1" # ERROR MESSAGE
	echoerror "- Argument #1  -- name of the stain as it appears in the filenames, e.g. FIBRIN."
# 	echoerror "- Argument #2  -- path_to CellProfiler pipeline, e.g. FIBRIN.cppipe."
# 	echoerror "- Argument #3  -- path_to working directory, i.e. where all the image-subdirectories are."
# 	echoerror "- Argument #4  -- starting letters/characters of the image-subdirectories, e.g. IMG or AE or AAA."
	echoerror ""
	echoerror "An example command would be: .lookup.sh [arg1: OUTPUTFILE]"
	echoerror "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  	# The wrong arguments are passed, so we'll exit the script now!
  	exit 1
}

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "                         LOOKUP OSMR VARIANTS"
echo ""
echoitalic "* Written by  : Sander W. van der Laan"
echoitalic "* E-mail      : s.w.vanderlaan-2@umcutrecht.nl"
echoitalic "* Last update : 2019-07-01"
echoitalic "* Version     : v1.0.1"
echo ""
echoitalic "* Description : This script will lookup OSMR/OSM/LIFR variants in GWAS ."
echoitalic "                summary statistics for a variety of cardiometabolic diseases."
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Today's: "$(date)
TODAY=$(date +"%Y%m%d")
echo ""

if [[ $# -lt 1 ]]; then 
	echo "Oh, computer says no! Number of arguments found "$#"."
	script_arguments_error "You must supply correct arguments when running *** slideQuantify ***!"
		
else

	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echobold "The following directories are set."
	DHLDIR="/hpc/dhl_ec"
	GWASDATASETS="${DHLDIR}/data/_gwas_datasets/"
	PROJECTDIR="${DHLDIR}/svanderlaan/projects/lookups/oncostatinm"

	SOFTWARE=/hpc/local/CentOS7/dhl_ec/software
	QCTOOL=${SOFTWARE}/qctool_v1.5-linux-x86_64-static/qctool

	OUTPUTFILENAME="$1" # depends on arg1
	
	echo "Group  directory___________ ${DHLDIR}"
	echo "GWAS data directory________ ${GWASDATASETS}"
	echo "Project directory__________ ${PROJECTDIR}"
	echo "Software directory_________ ${SOFTWARE}"
	echo "Where \"qctool\" resides_____ ${QCTOOL}"
	echo ""

	### Make directories for script if they do not exist yet (!!!PREREQUISITE!!!)
	if [ ! -d ${PROJECTDIR}/CROSSTRAITS/ ]; then
		mkdir -v ${PROJECTDIR}/CROSSTRAITS/
	fi
	OUTPUTDIR=${PROJECTDIR}/CROSSTRAITS

	PHENOTYPE="oncostatinm"
	VARIANTLIST="variantlist.withproxies.txt"

	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echobold "Extracting some data."

	echo "Phenotype Locus Distance R2 ProxyID ProxyCHR ProxyBP ProxyMajor ProxyMinor ProxyMAF VariantID CHR BP EffectAllele OtherAllele BETA SE OR Weight Pval EAF MAF N N_cases N_ctrls" > ${OUTPUTDIR}/${OUTPUTFILENAME}.txt

	while IFS='' read -r VARIANTOFINTEREST || [[ -n "$VARIANTOFINTEREST" ]]; do
		### EXAMPLE VARIANT LIST
		###	1			2	3	4				5				6		7			8	9		10		11
		### VariantID	Chr	BP	VariantID_v2	VariantID_v3	Locus	Distance	R2	MAJOR	MINOR	MAF
		### rs12519923	5	38472541	5:38472541	5:38472541:SNP	rs10491509	-76	1	T	G	0.316103
		### rs10491509	5	38472617	5:38472617	5:38472617:SNP	rs10491509	0	1	G	A	0.316103
	
		LINE=${VARIANTOFINTEREST}
	# 	echo "$LINE"
		VARIANT=$(echo "${LINE}" | awk '{ print $1 }')
		VARIANT_v2=$(echo "${LINE}" | awk '{ print $4 }')
		VARIANT_v3=$(echo "${LINE}" | awk '{ print $5 }')
		VARIANTFORFILE=$(echo "${LINE}" | awk '{ print $1 }' | sed 's/\:/_/g')
		CHR=$(echo "${LINE}" | awk '{ print $2 }')
		BP=$(echo "${LINE}" | awk '{ print $3 }')
		LOCUS=$(echo "${LINE}" | awk '{ print $6 }')
		DISTANCE=$(echo "${LINE}" | awk '{ print $7 }')
		R2=$(echo "${LINE}" | awk '{ print $8 }')
		MAJOR=$(echo "${LINE}" | awk '{ print $9 }')
		MINOR=$(echo "${LINE}" | awk '{ print $10 }')
		MAF=$(echo "${LINE}" | awk '{ print $11 }')
	
		echo ""
		echoitalic "Extracting data for [ ${VARIANT} on chr${CHR}:${BP} (${MINOR}/${MAJOR}, ${MAF}) for locus ${LOCUS} (r2 = ${R2}, distance = ${DISTANCE})]."	

	# 	echo ""
	# 	echo "> AAA (2017)"
	# 	DATAPHENO="AAA_GWAS_2017"
	# 	DATADIR="_AAA_GWAS"
	# 	DATAFILE="AAA_MetaGWAS_Metal.2017.CircRes2017.edit.txt"
	# 	
	# 	# Head 
	# 	# VariantID CHR POS AlleleA AlleleB Weight Zscore Pvalue Direction HetISq HetChiSq HetDf HetPVal
	# 	# rs12124819 1 776546 A G 14177.0 0.635 0.5256 -+++-+ 0.0 4.905 5.0
	# 	# rs10900604 1 798400 A G 14177.0 -1.556 0.1198 ----+- 0.0 2.989 5.0
	# 	# rs11240777 1 798959 A G 14177.0 1.467 0.1424 ++++-+ 0.0 2.137 5.0
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $2, $3, $4, $5, "NA", "NA", "NA", $6, $7, "NA", "NA", "NA", "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> AFGen (2018)"
	# 	DATAPHENO="AF_GWAS_2018"
	# 	DATADIR="_AFGen"
	# 	DATAFILE="AF_HRC_GWAS_ALLv11.txt"
	# 	
	# 	# Column		Description
	# 	# 1 MarkerName	SNPID
	# 	# 2 Allele1		Effect allele
	# 	# 3 Allele2		Non effect allele
	# 	# 4 chr			Chromosome
	# 	# 5 pos 		Position hg_19/b37
	# 	# 6 Effect		Beta
	# 	# 7 StdErr		Standard error
	# 	# 8 P.value		P-value
	# 	
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $4, $5, $2, $3, $6, $7, "NA", "NA", $8, "NA", "NA", "NA", "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> UKB_BP (2018) -- diastolic blood pressure"
	# 	DATAPHENO="UKB_DBP_GWAS_2018"
	# 	DATADIR="_BloodPressure/_UKB_BP"
	# 	DATAFILE="UKB-ICBPmeta750k_DBPsummaryResults.txt"
	# 
	# 	# HEAD
	# 	#	1			2		3		4	5		6	 7	8				9
	# 	# MarkerName Allele1 Allele2 Freq1 Effect StdErr P TotalSampleSize N_effective
	# 	# 10:100000625:SNP a g 0.5663 -0.0432 0.0174 0.01294 757601 756275
	# 	# 10:100000645:SNP a c 0.7935 0.0263 0.0214 0.218 757599 754442
	# 	# 10:100001867:SNP t c 0.0139 -0.0424 0.0839 0.6128 742538 595603
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT_v3'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, "NA", "NA", $2, $3, $5, $6, "NA", "NA", $7, $4, "NA", $8, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> UKB_BP (2018) -- systolic blood pressure"
	# 	DATAPHENO="UKB_SBP_GWAS_2018"
	# 	DATADIR="_BloodPressure/_UKB_BP"
	# 	DATAFILE="UKB-ICBPmeta750k_SBPsummaryResults.txt"
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT_v3'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, "NA", "NA", $2, $3, $5, $6, "NA", "NA", $7, $4, "NA", $8, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> UKB_BP (2018) -- pulse pressure"
	# 	DATAPHENO="UKB_PP_GWAS_2018"
	# 	DATADIR="_BloodPressure/_UKB_BP"
	# 	DATAFILE="UKB-ICBPmeta750k_PPsummaryResults.txt"
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT_v3'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, "NA", "NA", $2, $3, $5, $6, "NA", "NA", $7, $4, "NA", $8, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> UKB HF (2018) -- heart failure"
	# 	DATAPHENO="UKB_HF_GWAS_2018"
	# 	DATADIR="_UKB_heartfailure"
	# 	DATAFILE="HF_HRC_GWAS_UKBB_EUR.txt"
	# 
	# 	# Head
	# 	#	1			  2	3		4				5				6		7	8		9			10
	# 	# MarkerName	chr	pos	effect_allele	noneffect_allele	beta	n	ncase	ncontrol	p.value
	# 	# rs10399793	1	49298	T	C	0.0579103532848338	394156	6504	387652	0.0648124
	# 	# rs2462492	1	54676	C	T	-0.0328238567354712	394156	6504	387652	0.292881
	# 	
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $2, $3, $4, $5, $6, "NA", "NA", "NA", $10, "NA", "NA", $7, $8, $9 }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> UKB CAD (2017) -- coronary artery disease"
	# 	DATAPHENO="UKB_CAD_GWAS_2017"
	# 	DATADIR="_CARDIoGRAM/ukbiobank_cardiogramplusc4d"
	# 	DATAFILE="UKBB.GWAS1KG.EXOME.CAD.SOFT.META.PublicRelease.300517.txt"
	# 
	# 	# Head
	# 	#	1			  2					3		4			5				6					7						8		9			10			11				12		13
	# 	# Markername      snptestid       chr     bp_hg19 effect_allele   noneffect_allele        effect_allele_freq      logOR   se_gc   p-value_gc      n_samples       exome   info_ukbb
	# 	# 1:569406_G_A    rs561255355     1       569406  G       A       0.99858 0.05191 0.27358 0.849496        154959  yes     0.41
	# 	# 1:751756_T_C    rs143225517     1       751756  C       T       0.14418 0.00546 0.01416 0.699604        254199  no      0.98
	# 	# 1:753405_C_A    rs3115860       1       753405  C       A       0.17332 0.00316 0.0138  0.818922        255643  no      0.98
	# 	
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$2 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $2, $3, $4, $5, $6, $8, $9, "NA", "NA", $10, $7, "NA", $11, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> Nelson CAC (2015) -- coronary artery calcification"
	# 	DATAPHENO="CAC_GWAS_2015"
	# 	DATADIR="_CAC/1kgp3_gonl5"
	# 	DATAFILE="NELSON_AGATSTON_LOG.ALL.out"
	# 
	# 	# Head
	# 	#	1	2	3 4	  5	  6	  7	   8 9	10
	# 	# SNP CHR POS CA NCA CAF BETA SE P INFO
	# 	# 1:10177:A:AC 1 10177 AC A 0.390152 -0.0224607 0.118388 0.849542 0.404154
	# 	# rs145072688:10352:T:TA 1 10352 TA T 0.434714 -0.165649 0.11667 0.155782 0.3995
	# 	# rs62636508 1 10519 C G 0.00453167 -0.655609 0.836157 0.433069 0.431329
	# 	# chr1:10539 1 10539 A C 0.00109645 -0.679038 1.96865 0.730178 0.32117
	# 	
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$2 == '$CHR' && $3 == '$BP' ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $2, $3, $4, $5, $7, $8, "NA", "NA", $9, $6, "NA", "NA", "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt

		echo "> HeartValve Calcification (2013) -- aortic valve"
		DATAPHENO="HV_AVC_GWAS_2013"
		DATADIR="_HeartValve"
		DATAFILE="AVC_meta_results_dbGAP_2013Jan08.edit.txt"
	
		### Genomewide associations were performed with the presence of aortic-valve calcification (n=6942) and
		### mitral annular calcification ( n=3795) defined by Agatston score > 0 and identified by computed tomography (CT) among participants of
		### white European ancestry from three cohorts participating in the Cohorts for Heart and Aging Research
		### in Genomic Epidemiology consortium (FHS, MESA, and AGES).
		### 
		### The results were published February 7, 2013 in the New England Journal of Medicine, Thanassoulis G et al. "Genetic Associations with Valvular Calcification and Aortic Stenosis" PMID: XXXXX.
		### 
		### Each cohort analyzed the AVC (FHS, MESA, and AGES) and MAC (FHS and MESA) adjusting for age, sex, and PCs.
		### Inverse variance weighted meta-analysis was performed on SNPs with MAF >= 0.01 and OEVAR > 0.3.
		### Meta-analytic results were limited to SNPs that were analyzed in more than one cohort.
		### 
		### The following variables are available in the results:
		### 
		### SNP_ID = rsID name
		### Noncoded allele
		### Coded (target) allele
		### Coded allele frequency
		### Sample Size
		### Min OEVAR = minimum observed/expect variance ratio among analyzed studies; estimate of the quality of imputation
		### Max OEVAR  = maximum observed/expect variance ratio among analyzed studies; estimate of the quality of imputation
		### P value = meta-analytic p-value for association
	
		### Head
		###	1		2					3			 		4	  						5	  		6	  		7	   		8 	
		### SNP_ID	Noncoded_allele	Coded_(target)_allele	Coded_allele_frequency	Sample_size	Min_OEVAR	Max_OEVAR	P_value
		### rs7655493	c	t	0.4596	6942	0.845	0.971564	0.3901
		### rs8181001	c	a	0.8131	6942	0.802797	0.956763573108982	0.631
		### rs4935417	g	a	0.7822	6942	0.545177	1	0.415	
	
		zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
		awk '$1 == "'$VARIANT'" ' | \
		awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, "NA", "NA", $3, $2, "NA", "NA", "NA", "NA", $8, $4, "NA", $5, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	
		echo "> HeartValve Calcification (2013) -- mitral valve"
		DATAPHENO="HV_MAC_GWAS_2013"
		DATADIR="_HeartValve"
		DATAFILE="MAC_meta_results_dbGAP_2013Jan08.edit.txt"
	
		zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
		awk '$1 == "'$VARIANT'" ' | \
		awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, "NA", "NA", $3, $2, "NA", "NA", "NA", "NA", $8, $4, "NA", $5, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	
	# 	echo "> Type 2 Diabetes (2018)"
	# 	DATAPHENO="T2D_GWAS_2018"
	# 	DATADIR="_DIAGRAM"
	# 	DATAFILE="Mahajan.NatGenet2018b.T2D.European.add1kGphase1Markers.txt"
	# 
	# 	# Head
	# 	# 1		2	3 4	 5	 6	 7	  8	 9		10	11
	# 	# SNP Chr Pos EA NEA EAF Beta SE Pvalue Neff Marker
	# 	# 1:100000012 1 100000012 T G 0.25 -0.026 0.0073 4.0e-04 231420 rs10875231
	# 	# 1:10000006 1 10000006 A G 0.0047 -0.038 0.056 4.9e-01 225429 rs186077422
	# 	# 1:100000135 1 100000135 A T 0.99 -0.033 0.055 5.5e-01 226311 rs114947036
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$11 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $11, $2, $3, $4, $5, $7, $8, "NA", "NA", $9, $6, "NA", $10, "NA", "NA" }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> Ischemic stroke (2018) -- all stroke (AS)"
	# 	DATAPHENO="MEGASTROKE_AS_GWAS_2018"
	# 	DATADIR="_ISGC/megastroke"
	# 	DATAFILE="MEGASTROKE.1.AS.MANTRA.GC_filtered_X_nocases_het.txt"
	# 
	# 	# Head
	# 	# 1				2				3 		4	 5	 		6	 	7	  	8	 		9				10			11		12				13			14			15	16		17		18		19		20		21		22		23		24			25		26			27		28		29				30			31	
	# 	# MarkerName	functional_anno	gene	chr	position	type	MANTRA	Ref_allele	Effect_allele	N_studies	Log10BF	P_heterogeneity	Direction	METAL	Allele1	Allele2	Freq1	FreqSE	MinFreq	MaxFreq	Effect	StdErr	P-value	Direction	HetISq	HetChiSq	HetDf	HetPVal	TotalSampleSize	TotalCases	TotalStudies
	# 	# rs4951859	intergenic	LOC100288069(dist=15611),LINC00115(dist=31907)	1	729679	SNV	MANTRA	C	G	3	-0.38790	0.145	-?++??	METAL	c	g	0.2335	0.1563	0.1664	0.6118	0.0123	0.01770.4859	-+?+??	57.7	4.728	2	0.09406	367000	35034	11
	# 	# rs142557973	intergenic	LOC100288069(dist=17650),LINC00115(dist=29868)	1	731718	SNV	MANTRA	T	C	3	-0.63098	0.085	+?+-??	METAL	t	c	0.8570	0.0157	0.8121	0.8633	-0.0020	0.01970.9203	++?-??	0.0	1.105	2	0.5755	361976	33621	13
	# 	# rs141242758	intergenic	LOC100288069(dist=20281),LINC00115(dist=27237)	1	734349	SNV	MANTRA	T	C	3	-0.58869	0.105	-?+-??	METAL	t	c	0.8612	0.0143	0.8171	0.8664	-0.0017	0.01860.9276	-+?-??	0.0	0.595	2	0.7428	374268	37968	14
	# 
	# 	# Files
	# 	# MEGASTROKE.1.AS.MANTRA.GC_filtered_X_nocases_het.txt.gz
	# 	# MEGASTROKE.2.IS.MANTRA.GC_filtered_X_nocases_het.txt.gz
	# 	# MEGASTROKE.3.LAS.MANTRA.GC_filtered_X_nocases_het.txt.gz
	# 	# MEGASTROKE.4.CE.MANTRA.GC_filtered_X_nocases_het.txt.gz
	# 	# MEGASTROKE.5.SVD.MANTRA.GC_filtered_X_nocases_het.txt.gz
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $4, $5, $15, $16, $21, $22, "NA", "NA", $23, $17, "NA", $29, $30, $29-$30 }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> Ischemic stroke (2018) -- all ischemic stroke (IS)"
	# 	DATAPHENO="MEGASTROKE_IS_GWAS_2018"
	# 	DATADIR="_ISGC/megastroke"
	# 	DATAFILE="MEGASTROKE.2.IS.MANTRA.GC_filtered_X_nocases_het.txt"
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $4, $5, $15, $16, $21, $22, "NA", "NA", $23, $17, "NA", $29, $30, $29-$30 }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> Ischemic stroke (2018) -- large artery stroke (LAS)"
	# 	DATAPHENO="MEGASTROKE_LAS_GWAS_2018"
	# 	DATADIR="_ISGC/megastroke"
	# 	DATAFILE="MEGASTROKE.3.LAS.MANTRA.GC_filtered_X_nocases_het.txt"
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $4, $5, $15, $16, $21, $22, "NA", "NA", $23, $17, "NA", $29, $30, $29-$30 }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> Ischemic stroke (2018) -- cardioembolic stroke (CE)"
	# 	DATAPHENO="MEGASTROKE_CE_GWAS_2018"
	# 	DATADIR="_ISGC/megastroke"
	# 	DATAFILE="MEGASTROKE.4.CE.MANTRA.GC_filtered_X_nocases_het.txt"
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $4, $5, $15, $16, $21, $22, "NA", "NA", $23, $17, "NA", $29, $30, $29-$30 }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt
	# 
	# 	echo "> Ischemic stroke (2018) -- small vessel disease (SVD)"
	# 	DATAPHENO="MEGASTROKE_SVD_GWAS_2018"
	# 	DATADIR="_ISGC/megastroke"
	# 	DATAFILE="MEGASTROKE.5.SVD.MANTRA.GC_filtered_X_nocases_het.txt"
	# 
	# 	zcat ${GWASDATASETS}/${DATADIR}/${DATAFILE}.gz | \
	# 	awk '$1 == "'$VARIANT'" ' | \
	# 	awk '{ print "'$DATAPHENO'", "'$LOCUS'", "'$DISTANCE'", "'$R2'", "'$VARIANT'", "'$CHR'", "'$BP'", "'$MAJOR'", "'$MINOR'", "'$MAF'", $1, $4, $5, $15, $16, $21, $22, "NA", "NA", $23, $17, "NA", $29, $30, $29-$30 }' >> ${OUTPUTDIR}/${OUTPUTFILENAME}.txt

	done < ${VARIANTLIST}

### END of if-else statement for the number of command-line arguments passed ###
fi

script_copyright_message
