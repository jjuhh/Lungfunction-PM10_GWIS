# Lungfunction_x_PM10_GWAS-

# Workflow
1. Cleaning Genotype (maf > 0.01, hwe < 0.0005)
2. Cleaning phenotype (FEV1 -> sr, FVC -> ln norm)
3. Conduct interaction anlaysis using Plink2.0 (--glm interaction)
4. Annotating risk SNPs using annovar
5. Finding causal SNP by Fine mapping using PolyFun(method : susie)
6. Integrating with snATAC atlas to find actually influencing cell types
7. Figuring out risk allele that could change TF binding affinity
8. Summary all of the results above


## 0. Sample description


## 1. Cleaning Genotype 


## 2. Cleaning phenotype (FEV1 -> sr, FVC -> ln norm)
I used two phenotype related with lung function : FEV1 and FVC
Before conduction association analysis, check the phenotype's distribution.

Before normalizaiton, FEV1 and FVC phenotypes are not (p < 0.05)
![image](https://user-images.githubusercontent.com/68099699/183866376-a290e8b2-5a9b-4ad5-80f5-7ab1cf61b05f.png)
![image](https://user-images.githubusercontent.com/68099699/183866424-1ac3929d-8c81-40a5-b849-c1100388d796.png)

![image](https://user-images.githubusercontent.com/68099699/183866732-4afd1aea-346d-4839-80b8-8fe404b1d2f9.png)
![image](https://user-images.githubusercontent.com/68099699/183866757-6120f3eb-a7f2-4c29-8306-0c6c8e04624a.png)

However, after normalization, They are (p > 0.05)
![image](https://user-images.githubusercontent.com/68099699/183866902-74265dcf-dda2-4dbd-a656-6ec9200c0def.png)
![image](https://user-images.githubusercontent.com/68099699/183866949-3180ba07-c9fb-451a-8fda-b2ce9bb7f8a7.png)

![image](https://user-images.githubusercontent.com/68099699/183866988-f5c12221-c302-4ab7-b5b0-2d3dc2b3fbb4.png)
![image](https://user-images.githubusercontent.com/68099699/183867001-2d839fe8-5e7c-42ca-b0c6-d6232fb7a375.png)


