#!/bin/bash
#SBATCH --job-name=busco_trinity
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --output=busco_trinity_%j.out
#SBATCH --error=busco_trinity_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

TRINITY="$WORKDIR/assemblies/trinity.Trinity.fasta"
OUT="$WORKDIR/evaluation/busco_trinity"

mkdir -p "$OUT"

apptainer exec --bind /data:/data \
    /containers/apptainer/busco_5.7.1.sif \
    busco \
    -f \
    -i "$TRINITY" \
    -o trinity \
    -l brassicales_odb10 \
    -m transcriptome \
    -c "$SLURM_CPUS_PER_TASK" \
    --out_path "$OUT"
