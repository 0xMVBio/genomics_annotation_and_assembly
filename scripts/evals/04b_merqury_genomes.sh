#!/bin/bash
#SBATCH --job-name=merqury_genomes
#SBATCH --time=02:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --output=merqury_genomes_%j.out
#SBATCH --error=merqury_genomes_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

OUT="$WORKDIR/evaluation/merqury"
MERYL="$OUT/meryl/Kyr-1.meryl"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

mkdir -p "$OUT"

apptainer exec --bind /data:/data \
    --env MERQURY=/usr/local/share/merqury \
    /containers/apptainer/merqury_1.3.sif \
    merqury.sh \
    "$MERYL" \
    "$FLYE" \
    "$OUT/flye"

apptainer exec --bind /data:/data \
    --env MERQURY=/usr/local/share/merqury \
    /containers/apptainer/merqury_1.3.sif \
    merqury.sh \
    "$MERYL" \
    "$HIFIASM" \
    "$OUT/hifiasm"

apptainer exec --bind /data:/data \
    --env MERQURY=/usr/local/share/merqury \
    /containers/apptainer/merqury_1.3.sif \
    merqury.sh \
    "$MERYL" \
    "$LJA" \
    "$OUT/lja"