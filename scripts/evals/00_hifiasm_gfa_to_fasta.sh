#!/bin/bash

#SBATCH --job-name=hifiasm_fasta
#SBATCH --time=00:15:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --output=hifiasm_fasta_%j.out
#SBATCH --error=hifiasm_fasta_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

GFA="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.gfa"
FASTA="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fasta"

awk '$1 == "S" {print ">"$2"\n"$3}' "$GFA" > "$FASTA"

echo "Created:"
ls -lh "$FASTA"
