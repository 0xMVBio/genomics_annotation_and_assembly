#!/bin/bash
#SBATCH --job-name=nucmer_comparisons
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --output=nucmer_comparisons_%j.out
#SBATCH --error=nucmer_comparisons_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
OUT="$WORKDIR/evaluation/nucmer"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

mkdir -p "$OUT/reference"
mkdir -p "$OUT/pairwise"

# Check input files
for FILE in "$REF" "$FLYE" "$HIFIASM" "$LJA"; do
    if [ ! -f "$FILE" ]; then
        echo "ERROR: File not found: $FILE"
        exit 1
    fi
done

echo "=== NUCmer: assemblies vs Arabidopsis reference ==="

# Flye vs reference
echo "Running Flye vs reference..."
apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix="$OUT/reference/flye_vs_reference" \
    --breaklen 1000 \
    --mincluster 1000 \
    "$REF" "$FLYE"

apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot \
    -R "$REF" \
    -Q "$FLYE" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$OUT/reference/flye_vs_reference" \
    "$OUT/reference/flye_vs_reference.delta"


# Hifiasm vs reference
echo "Running Hifiasm vs reference..."
apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix="$OUT/reference/hifiasm_vs_reference" \
    --breaklen 1000 \
    --mincluster 1000 \
    "$REF" "$HIFIASM"

apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot \
    -R "$REF" \
    -Q "$HIFIASM" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$OUT/reference/hifiasm_vs_reference" \
    "$OUT/reference/hifiasm_vs_reference.delta"


# LJA vs reference
echo "Running LJA vs reference..."
apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix="$OUT/reference/lja_vs_reference" \
    --breaklen 1000 \
    --mincluster 1000 \
    "$REF" "$LJA"

apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot \
    -R "$REF" \
    -Q "$LJA" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$OUT/reference/lja_vs_reference" \
    "$OUT/reference/lja_vs_reference.delta"


echo "=== NUCmer: pairwise assembly comparisons ==="

# Flye vs Hifiasm
echo "Running Flye vs Hifiasm..."
apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix="$OUT/pairwise/flye_vs_hifiasm" \
    --breaklen 1000 \
    --mincluster 1000 \
    "$FLYE" "$HIFIASM"

apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot \
    -R "$FLYE" \
    -Q "$HIFIASM" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$OUT/pairwise/flye_vs_hifiasm" \
    "$OUT/pairwise/flye_vs_hifiasm.delta"


# Flye vs LJA
echo "Running Flye vs LJA..."
apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix="$OUT/pairwise/flye_vs_lja" \
    --breaklen 1000 \
    --mincluster 1000 \
    "$FLYE" "$LJA"

apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot \
    -R "$FLYE" \
    -Q "$LJA" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$OUT/pairwise/flye_vs_lja" \
    "$OUT/pairwise/flye_vs_lja.delta"


# Hifiasm vs LJA
echo "Running Hifiasm vs LJA..."
apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix="$OUT/pairwise/hifiasm_vs_lja" \
    --breaklen 1000 \
    --mincluster 1000 \
    "$HIFIASM" "$LJA"

apptainer exec --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot \
    -R "$HIFIASM" \
    -Q "$LJA" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$OUT/pairwise/hifiasm_vs_lja" \
    "$OUT/pairwise/hifiasm_vs_lja.delta"


echo "=== ALL NUCmer/MUMmer comparisons completed ==="
echo "Results are in: $OUT"