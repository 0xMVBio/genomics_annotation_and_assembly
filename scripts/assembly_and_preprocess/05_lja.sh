#!/bin/bash
#SBATCH --job-name=genome_assembly_lja
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=lja_%j.out
#SBATCH --error=lja_%j.err

READS="/data/users/mvaldivia/genome_assembly_course/Kyr-1/ERR11437320.fastq.gz"
OUT="/data/users/mvaldivia/genome_assembly_course/assemblies/lja"

mkdir -p "$OUT"

apptainer exec  --bind /data:/data  /containers/apptainer/lja-0.2.sif \
    lja \
    --reads "$READS" \
    --output-dir "$OUT" \
    --threads "$SLURM_CPUS_PER_TASK"
