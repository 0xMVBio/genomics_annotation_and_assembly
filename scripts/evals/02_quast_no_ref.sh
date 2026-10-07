#!/bin/bash
#SBATCH --job-name=quast_no_ref
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --output=quast_no_ref_%j.out
#SBATCH --error=quast_no_ref_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"
OUT="$WORKDIR/evaluation/quast_no_ref"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

mkdir -p "$OUT"

apptainer exec --bind /data:/data \
    /containers/apptainer/quast_5.2.0.sif \
    quast.py \
    "$FLYE" \
    "$HIFIASM" \
    "$LJA" \
    --eukaryote \
    --threads "$SLURM_CPUS_PER_TASK" \
    --labels flye,hifiasm,LJA \
    -o "$OUT"