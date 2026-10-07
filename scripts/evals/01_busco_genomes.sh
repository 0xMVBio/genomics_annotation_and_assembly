#!/bin/bash
#SBATCH --job-name=busco_genomes
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --output=busco_genomes_%j.out
#SBATCH --error=busco_genomes_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"
OUT="$WORKDIR/evaluation/busco_genomes"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

mkdir -p "$OUT"

apptainer exec --bind /data:/data \
    /containers/apptainer/busco_5.7.1.sif \
    busco \
    -f  \
    -i "$FLYE" \
    -o flye \
    -l brassicales_odb10 \
    -m genome \
    -c "$SLURM_CPUS_PER_TASK" \
    --out_path "$OUT"

apptainer exec --bind /data:/data \
    /containers/apptainer/busco_5.7.1.sif \
    busco \
    -i "$HIFIASM" \
    -o hifiasm \
    -l brassicales_odb10 \
    -m genome \
    -c "$SLURM_CPUS_PER_TASK" \
    --out_path "$OUT"

apptainer exec --bind /data:/data \
    /containers/apptainer/busco_5.7.1.sif \
    busco \
    -i "$LJA" \
    -o lja \
    -l brassicales_odb10 \
    -m genome \
    -c "$SLURM_CPUS_PER_TASK" \
    --out_path "$OUT"
