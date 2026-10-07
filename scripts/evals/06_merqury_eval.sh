#!/bin/bash
#SBATCH --job-name=merqury_eval
#SBATCH --time=02:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --output=merqury_eval_%j.out
#SBATCH --error=merqury_eval_%j.err
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mvaldivia/genome_assembly_course"

MERYL="$WORKDIR/evaluation/merqury/meryl/Kyr-1.k31.meryl"
OUT="$WORKDIR/evaluation/merqury"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Pa1.bp.p_ctg.fa"
LJA="$WORKDIR/assemblies/lja/assembly.fasta"

# Check Meryl database
if [ ! -d "$MERYL" ]; then
    echo "ERROR: Meryl database not found:"
    echo "$MERYL"
    exit 1
fi

# Check assemblies
for FASTA in "$FLYE" "$HIFIASM" "$LJA"
do
    if [ ! -f "$FASTA" ]; then
        echo "ERROR: FASTA not found:"
        echo "$FASTA"
        exit 1
    fi
done

mkdir -p "$OUT"

echo "======================================"
echo "Merqury evaluation"
echo "Using existing k=31 Meryl database"
echo "======================================"

# Run everything from the Merqury output directory.
# Merqury 1.3 expects its log directory to be relative.
cd "$OUT" || exit 1

for ASSEMBLY in flye hifiasm lja
do

    echo
    echo "======================================"
    echo "Running Merqury on: $ASSEMBLY"
    echo "======================================"

    if [ "$ASSEMBLY" = "flye" ]; then
        FASTA="$FLYE"
    elif [ "$ASSEMBLY" = "hifiasm" ]; then
        FASTA="$HIFIASM"
    elif [ "$ASSEMBLY" = "lja" ]; then
        FASTA="$LJA"
    fi

    echo "FASTA: $FASTA"
    echo "Output prefix: $ASSEMBLY"
    echo

    apptainer exec \
        --bind /data:/data \
        --env MERQURY=/usr/local/share/merqury \
        /containers/apptainer/merqury_1.3.sif \
        merqury.sh \
        "$MERYL" \
        "$FASTA" \
        "$ASSEMBLY"

    STATUS=$?

    if [ $STATUS -ne 0 ]; then
        echo "ERROR: Merqury failed for $ASSEMBLY"
        exit $STATUS
    fi

    echo "Successfully completed: $ASSEMBLY"

done

echo
echo "======================================"
echo "ALL THREE MERQURY RUNS COMPLETED"
echo "======================================"

echo
echo "Results:"
ls -lh "$OUT"

echo
echo "Log files:"
ls -lh "$OUT/logs"