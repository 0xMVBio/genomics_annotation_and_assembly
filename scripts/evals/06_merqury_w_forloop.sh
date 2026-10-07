#!/bin/bash
#SBATCH --job-name=merqury_all
#SBATCH --time=02:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --output=merqury_all_%j.out
#SBATCH --error=merqury_all_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

READS="$WORKDIR/Kyr-1/ERR11437320.fastq.gz"
OUT="$WORKDIR/evaluation/merqury"
MERYL_DIR="$OUT/meryl"
MERYL="$MERYL_DIR/Kyr-1.k31.meryl"

mkdir -p "$MERYL_DIR"

echo "=== Creating Meryl database (k=31) ==="

apptainer exec --bind /data:/data \
    /containers/apptainer/merqury_1.3.sif \
    meryl count \
    k=31 \
    output "$MERYL" \
    "$READS"

if [ $? -ne 0 ]; then
    echo "ERROR: Meryl failed."
    exit 1
fi

echo "=== Meryl completed ==="
echo

for ASSEMBLY in flye hifiasm lja
do

    if [ "$ASSEMBLY" = "flye" ]; then
        FASTA="$WORKDIR/assemblies/flye/assembly.fasta"

    elif [ "$ASSEMBLY" = "hifiasm" ]; then
        FASTA="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fa"

    elif [ "$ASSEMBLY" = "lja" ]; then
        FASTA="$WORKDIR/assemblies/lja/assembly.fasta"
    fi

    echo "======================================"
    echo "Running Merqury on $ASSEMBLY"
    echo "FASTA: $FASTA"
    echo "======================================"

    if [ ! -f "$FASTA" ]; then
        echo "ERROR: FASTA not found: $FASTA"
        exit 1
    fi

    apptainer exec --bind /data:/data \
        --env MERQURY=/usr/local/share/merqury \
        /containers/apptainer/merqury_1.3.sif \
        merqury.sh \
        "$MERYL" \
        "$FASTA" \
        "$OUT/$ASSEMBLY"

    if [ $? -ne 0 ]; then
        echo "ERROR: Merqury failed for $ASSEMBLY."
        exit 1
    fi

    echo "Finished: $ASSEMBLY"
    echo

done

echo "======================================"
echo "ALL MERQURY ANALYSES COMPLETED"
echo "======================================"

ls -lh "$OUT"