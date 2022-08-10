# Argument #
vcf=$1
outdir=$2

# program #
table_annovar='/mnt/gmi_lustre/_90.User_Data/juhyunk/programs/annovar/table_annovar.pl'
humandb='/mnt/gmi_lustre/_90.User_Data/juhyunk/programs/annovar/humandb/'
conver2annovar='/mnt/gmi_lustre/_90.User_Data/juhyunk/programs/annovar/convert2annovar.pl'
vcf_name=`basename ${vcf}`

# Run #
${conver2annovar} -format vcf4old ${vcf} --includeinfo > ${vcf}.annovar

${table_annovar} ${vcf}.annovar ${humandb} --buildver hg19 -out ${outdir}/${vcf_name} -remove -protocol refGene,tfbsConsSites,wgRna,targetScanS,gwasCatalog,1000g2015aug_all,1000g2015aug_afr,1000g2015aug_amr,1000g2015aug_eas,1000g2015aug_eur,1000g2015aug_sas,snp138,clinvar_20200316,gnomad_exome,gnomad_genome -operation gx,r,r,r,r,f,f,f,f,f,f,f,f,f,f -nastring NA  -otherinfo

