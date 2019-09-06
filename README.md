# Human embryonic cell altas (HECA)

We collected five human embryonic datasets from our previously published studies spanning from 4 to 26 weeks of fetal development, including:

**1. Fetal germ cells (FGCs) (GEO: GSE86146)  
2. Heart (GEO: GSE106118)  
3. Kidney (GEO: GSE109488)  
4. Prefrontal cortex (PFC) (GEO: GSE104276)  
5. Cerebral cortex (GEO: GSE103723)**

Data Loading is easy in R: temp <- readRDS("XXX.rds")

Importantly, we re-organized the five datasets using uniform pipeline and format, which provided a rich and convenient resource for studying human embryonic development. In brief, barcode and UMI information were extracted by UMI-tools form raw reads. After discarding the poly A bases, TSO sequences and low-quality sequences, the clean reads were mapped to GRCh38 reference using STAR aligner. We used featureCounts to annotate the mapped reads and quantified the UMI counts through UMI-tools. We provided the pipeline for users.

These five datasets have been filtered: we discarded cells with gene number below 1,000 and UMI counts below 10,000. We used our newly developed network-based method, **SCORE** (https://github.com/wycwycpku/RSCORE), to explore the combined data (for the tutorial, please see: https://github.com/zorrodong/HECA/blob/master/RSCORE_Tutorial_for_HECA/RSCORE_Tutorial_for_HECA.pdf).

If you find these datasets helpful for your study, please consider the following citation:

**1. Enhancing single-cell cellular state inference by incorporating molecular network features**  
   *Ji Dong, Peijie Zhou, Yichong Wu, Wendong Wang, Yidong Chen, Xin Zhou, Haoling Xie, Jiansen Lu, Xiannian Zhang, Lu Wen, Wei Fu, Tiejun Li, Fuchou Tang  
   doi: https://doi.org/10.1101/699959  
   https://www.biorxiv.org/content/10.1101/699959v1*

**2. and the original publications.**

**Note**
2019.09.06, BioGrid human PPI database: 9606_ppi_matrix_BioGRID-3.5.176.Rda is now available.
2019.08.17, BioGrid human PPI database: 9606_ppi_matrix_BioGRID-3.5.175.Rda is now available.
