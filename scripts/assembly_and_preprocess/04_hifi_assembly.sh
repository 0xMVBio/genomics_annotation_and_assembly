#!/bin/bash
#SBATCH --job-name=genome_assembly_hifiasm
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=hifiasm_%j.out
#SBATCH --error=hifiasm_%j.err
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

READS="$WORKDIR/Kyr-1/ERR11437320.fastq.gz"
OUT="$WORKDIR/assemblies/hifiasm"

mkdir -p "$OUT"

apptainer exec --bind /data:/data  /containers/apptainer/hifiasm_0.25.0.sif \
    hifiasm \
    -o "$OUT/Pa1" \
    -t "$SLURM_CPUS_PER_TASK" \
    "$READS"
