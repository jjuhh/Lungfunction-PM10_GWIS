pheno=$1
geno=$2
wd=$3

n=1855
polyfunDir='/mnt/gmi-analysis01/_90.User_Data/juhyunk/program/polyfun'
plink2="/gmi-l1/_90.User_Data/juhyunk/program/plink/plink2.0/plink2"
phenotypeFile="/gmi-l1/_90.User_Data/juhyunk/project/fineDustGWIS/rawFiles/SNUH6FM_airpol5.pheno.JH.filtered.txt"
covarFile="/gmi-l1/_90.User_Data/juhyunk/project/fineDustGWIS/rawFiles/SNUH6FM_airpol5.pheno.txt"
covarName="center,age,height,bmi,smok,smok_pkyr,mod_vig_yn,PM10"
covarParam="1,2,3,4,5,6,7,8,9,17"

# 00. make Env
mkdir -p ${wd}/assocResults
mkdir -p ${wd}/finemapping
mkdir -p ${wd}/finemapping/input
mkdir -p ${wd}/finemapping/output

#if [[ -f ${wd}/assocResults/${wd}/assocResults/pm10.${pheno}.glm.linear ]]; then
#	echo "Plink file already exist!"
#else
#	${plink2} --bfile ${geno} \
#	--pheno ${phenotypeFile} \
#	--pheno-name ${pheno} \
#	--glm interaction \
#	--maf 0.01 \
#	--hwe 0.0005 \
#	--covar ${phenotypeFile} \
#	--covar-name ${covarName} \
#	--covar-variance-standardize \
#	--parameters ${covarParam} \
#	--ci 0.95 \
#	--allow-no-sex \
#	--out ${wd}/assocResults/pm10 \
#	--threads 20
#fi

# output : ${wd}/assocResults/pm10.${pheno}.glm.linear

#fgrep ADDxPM10 ${wd}/assocResults/pm10.${pheno}.glm.linear |  awk '$14<1e-05 {print $0}' > ${wd}/assocResults/pm10.${pheno}.glm.linear.1e-05
#sh ~/codes/GWAS/annovar.sh ${wd}/assocResults/pm10.${pheno}.glm.linear.1e-05 ${wd}/assocResults 

# 02. Create a munged summary statistics file in a PolyFun-friendly parquet format
#echo -e 'Preparing Finemapping'

#echo -e 'CHR\tSNP\tBP\tBETA\tSE\tZ\tP\tALLELE1\tALLELE0' > ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.summary
#fgrep "ADDxPM10" ${wd}/assocResults/pm10.${pheno}.glm.linear | awk '{print $1,$3,$2,$9,$10,$13,$14,$6,$4}' OFS='\t' >>  ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.summary

#rm ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.summary.tmp*

#python ${polyfunDir}/munge_polyfun_sumstats.py \
#	--sumstats ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.summary \
# 	--n ${n} \
#	--out ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.parquet

# 03. creating job files 
echo -e 'Creating job files'
for chr in {1..22}
do echo $chr
python ${polyfunDir}/create_finemapper_jobs.py \
    --geno ${geno} \
    --sumstats ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.parquet \
    --n ${n} \
    --method susie \
    --chr $chr \
    --max-num-causal 10 \
    --out-prefix ${wd}/finemapping/output/polyfun_all.${pheno}.chr${chr} \
    --jobs-file ${wd}/finemapping/output/polyfun_all_jobs.${pheno}.chr${chr}.txt \
    --non-funct \
    --allow-missing \
    --thread 20
done


for chr in {1..22}
do echo ${chr}
sh ${wd}/finemapping/output/polyfun_all_jobs.${pheno}.chr${chr}.txt
done

#python ${polyfunDir}/aggregate_finemapper_results.py \
#    --out-prefix ${wd}/finemapping/output/polyfun_all \
#    --sumstats ${wd}/finemapping/input/${pheno}.assoc.ADDxPM10.parquet \
#    --out ${wd}/finemapping/output/polyfun_agg.${pheno}.txt.gz
