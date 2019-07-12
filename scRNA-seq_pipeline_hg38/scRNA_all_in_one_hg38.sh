############################################
### Tanglab Single-Cell RNA-Seq Pipeline ###
### Author: Zorro Dong                   ###
### Date: 2018-07-25                     ###
############################################

#USAGE: sh scRNA_all_in_one_hg38.sh sample

sample=$1

######Reference and scripts######
genomeDir=/home/software/database/CellRanger-GRCh38-1.2.0/star
ref=/home/software/database/CellRanger-GRCh38-1.2.0/fasta/genome.fa
gtf=/home/software/database/CellRanger-GRCh38-1.2.0/genes/genes.gtf
barcode=/home/software/pipeline/Tanglab_Single_Cell_RNA_Seq/barcode_96_8bp.txt
trim_script=/home/software/pipeline/Tanglab_Single_Cell_RNA_Seq/trim_TSO_polyA.pl
norm_script=/home/software/pipeline/Tanglab_Single_Cell_RNA_Seq/scRNA_Normalization.R

#######Tools#######
umi_tools=/data1/dongji/software/anaconda/bin/umi_tools
STAR=/home/software/installed_software/STAR-2.6.0a/bin/Linux_x86_64/STAR
perl=/usr/bin/perl
seqtk=/date/dongji/bin/seqtk
featureCounts=/data1/dongji/software/subread-1.6.2-Linux-x86_64/bin/featureCounts
samtools=/home/software/installed_software/anaconda2/bin/samtools
Rscript=/home/software/installed_software/R-3.3.2/bin/Rscript

######Step1 Extract Barcode and UMI######
$umi_tools extract --bc-pattern=CCCCCCCCNNNNNNNN \
                  --stdin $sample/${sample}*2.f*q.gz \
                  --stdout $sample/$sample.R1.extracted.fq.gz \
                  --read2-stdout \
                  --read2-in $sample/${sample}*1.f*q.gz \
                  --filter-cell-barcode \
                  --whitelist=$barcode

######Step2 Trim TSO and PolyA######
$perl $trim_script $sample/$sample.R1.extracted.fq.gz $sample/$sample.R1.trim.fq.gz 0
$seqtk trimfq $sample/$sample.R1.trim.fq.gz | gzip - > $sample/$sample.R1.clean.fq.gz

######Step3 Mapping With STAR######
$STAR --runThreadN 4 \
     --genomeDir $genomeDir \
     --readFilesIn $sample/$sample.R1.clean.fq.gz \
     --readFilesCommand zcat \
     --outFilterMultimapNmax 1 \
     --outFileNamePrefix $sample/$sample. \
     --outSAMtype BAM SortedByCoordinate

######Step4 Add feature using featureCounts of subread#######
$featureCounts -a $gtf -o $sample/gene_assigned -R BAM $sample/$sample.Aligned.sortedByCoord.out.bam -T 4

#######Step5 sort and index bam file######
$samtools sort -m 15000000000 $sample/$sample.Aligned.sortedByCoord.out.bam.featureCounts.bam -o $sample/$sample.assigned_sorted.bam
$samtools index $sample/$sample.assigned_sorted.bam && rm $sample/$sample.R1.extracted.fq.gz $sample/$sample.R1.trim.fq.gz $sample/$sample.R1.clean.fq.gz $sample/$sample.Aligned.sortedByCoord.out.bam.featureCounts.bam $sample/$sample.Aligned.sortedByCoord.out.bam

######Step6 get umi count table######
$umi_tools count --per-gene --gene-tag=XT --per-cell --wide-format-cell-counts -I $sample/$sample.assigned_sorted.bam -S $sample/$sample.UMI_counts.tsv

#######Step7 Normalization umi count table######
$Rscript $norm_script $sample
