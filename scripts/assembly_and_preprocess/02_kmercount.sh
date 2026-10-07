#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=jellycount
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mvaldivia/genome_assembly_course/output_fastqc_%j.o
#SBATCH --error=/data/users/mvaldivia/genome_assembly_course/error_fastqc_%j.e
#SBATCH --partition=pshort_el8

USER=$1
WORKDIR=/data/users/${USER}/genome_assembly_course/ 

INPUT={$WORKDIR}$2


jellyfish count \
[-s 5G -t 4 ] \
<(zcat myreads.fastq.gz) \
<(zcat myotherreads.fastq.gz)
