# HECA
Human embryonic cell altas
We collected five human embryonic datasets from our previously published studies, including fetal germ cells (FGCs) (GEO number: GSE86146), heart (GEO number: GSE106118), kidney (GEO number: GSE109488), prefrontal cortex (PFC) (GEO number: GSE104276), and cerebral cortex (GEO number: GSE103723), spanning from 4 to 26 weeks of fetal development.

Importantly, we re-organized the five datasets using uniform pipeline and format, which provided a rich and convenient resource for studying human embryonic development. In brief, barcode and UMI information were extracted by UMI-tools form raw reads. After discarding the poly A bases, TSO sequences and low-quality sequences, the clean reads were mapped to GRCh38 reference using STAR aligner. We used featureCounts to annotate the mapped reads and quantified the UMI counts through UMI-tools. We provided the pipeline for users.

These five datasets have been filtered: we discarded cells with gene number below 1,000 and UMI counts below 10,000. We used our newly developed network-based method, SCORE (https://github.com/wycwycpku/RSCORE), to explore the combined data (for the tutoiral, please see: XXX).

If you find these datasets helpful for your study, please consider the following citation:

1. Enhancing single-cell cellular state inference by incorporating molecular network features

Ji Dong, Peijie Zhou, Yichong Wu, Wendong Wang, Yidong Chen, Xin Zhou, Haoling Xie, Jiansen Lu, Xiannian Zhang, Lu Wen, Wei Fu, Tiejun Li, Fuchou Tang
doi: https://doi.org/10.1101/699959
https://www.biorxiv.org/content/10.1101/699959v1

2. and the original publications.
