#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mvaldivia/genome_assembly_course/output_fastqc_%j.o
#SBATCH --error=/data/users/mvaldivia/genome_assembly_course/error_fastqc_%j.e
#SBATCH --partition=pshort_el8
USER=$1
WORKDIR=/data/users/${USER}/genome_assembly_course 
INPUT=$2

apptainer exec \
    --bind /data \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc \
    --outdir "$WORKDIR" \
    "$WORKDIR/${INPUT}"/*.fastq.gz

