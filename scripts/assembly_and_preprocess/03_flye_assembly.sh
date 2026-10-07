#!/bin/bash
#SBATCH --job-name=genome_assembly_flye
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=flye_%j.out
#SBATCH --error=flye_%j.err
#SBATCH --partition=pibu_el8

READS="/data/users/mvaldivia/genome_assembly_course/Kyr-1/ERR11437320.fastq.gz"
OUT="/data/users/mvaldivia/genome_assembly_course/assemblies/flye"

mkdir -p "$OUT"

apptainer exec --bind /data:/data /containers/apptainer/flye_2.9.5.sif \
    flye \
    --pacbio-hifi "$READS" \
    --out-dir "$OUT" \
    --threads "$SLURM_CPUS_PER_TASK"
