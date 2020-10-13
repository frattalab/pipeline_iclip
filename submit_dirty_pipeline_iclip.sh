#!/bin/bash
#Submit to the cluster, give it a unique name
#$ -S /bin/bash

#$ -cwd
#$ -V
#$ -l h_vmem=12G,h_rt=48:00:00,tmem=12G
#$ -pe smp 2

# join stdout and stderr output
#$ -j y
#$ -R y
#$ -N iclip_pipeline_submit

conda activate iCount
snakemake -p -s pipeline_iclip.smk --cores 2 --rerun-incomplete
