#!/bin/bash
#SBATCH --job-name=merqury_meryl
#SBATCH --time=02:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --output=merqury_meryl_%j.out
#SBATCH --error=merqury_meryl_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

READS="$WORKDIR/Kyr-1/ERR11437320.fastq.gz"
OUT="$WORKDIR/evaluation/merqury"
MERYL="$OUT/meryl"

mkdir -p "$MERYL"

apptainer exec --bind /data:/data \
    /containers/apptainer/merqury_1.3.sif \
    meryl count \
    k=31 \
    output "$MERYL/Kyr-1.meryl" \
    "$READS"

echo "Meryl database:"
ls -lh "$MERYL"