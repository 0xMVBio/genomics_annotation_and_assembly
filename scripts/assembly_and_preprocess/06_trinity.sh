#!/bin/bash
#SBATCH --job-name=genome_assembly_trinity
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=trinity_%j.out
#SBATCH --error=trinity_%j.err
#SBATCH --partition=pibu_el8


READS_R1="/data/users/mvaldivia/genome_assembly_course/RNAseq_Sha/ERR754081_1.fastq.gz"
READS_R2="/data/users/mvaldivia/genome_assembly_course/RNAseq_Sha/ERR754081_2.fastq.gz"
OUT="/data/users/mvaldivia/genome_assembly_course/assemblies/trinity"

mkdir -p "$OUT"

module load Trinity

Trinity \
    --seqType fq \
    --max_memory 64G \
    --CPU "$SLURM_CPUS_PER_TASK" \
    --left "$READS_R1" \
    --right "$READS_R2" \
    --output "$OUT"
