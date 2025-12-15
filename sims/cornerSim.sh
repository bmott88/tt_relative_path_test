#!/bin/bash
set -e

DATE=$(date +%s)

# --------------------------------------------------
# Input handling (.sch or .spice)
# --------------------------------------------------
INPUT="$1"

if [ -z "$INPUT" ]; then
    echo "Usage: $0 <testbench.sch | testbench.spice>"
    exit 1
fi

EXT="${INPUT##*.}"
BASENAME="$(basename "$INPUT" .${EXT})"

case "$EXT" in
    sch)
        NETLIST_SRC="$HOME/.xschem/simulations/${BASENAME}.spice"
        ;;
    spice)
        NETLIST_SRC="$INPUT"
        ;;
    *)
        echo "ERROR: Input must be .sch or .spice"
        exit 1
        ;;
esac

if [ ! -f "$NETLIST_SRC" ]; then
    echo "ERROR: Netlist '$NETLIST_SRC' not found"
    exit 1
fi

echo "Using netlist: $NETLIST_SRC"
cp "$NETLIST_SRC" .
NETLIST="${BASENAME}.spice"

LOG="${BASENAME}_${DATE}.log"

# --------------------------------------------------
# Corner selection
# --------------------------------------------------
echo "Select process corner(s): tt ss ff sf fs all"
read CORNER
echo ""

if [ "$CORNER" = "all" ]; then
    MASTER_CSV="${BASENAME}_all_${DATE}.csv"
fi

# --------------------------------------------------
# CSV cleanup
# --------------------------------------------------
clean_csv() {
    local in=$1
    local out=$2
    awk '{printf "%s", $1; for(i=2;i<=NF;i+=2) printf " %s",$i; print ""}' "$in" > "$out"
}

# --------------------------------------------------
# Corner simulation
# --------------------------------------------------
corner_simulate() {
    local C=$1

    local TEMPNETLIST="${BASENAME}_${C}.spice"
    local CSV="${BASENAME}_${C}_${DATE}.csv"
    local CLEANED="${BASENAME}_${C}_clean.csv"

    echo "Simulating corner: $C"
    cp "$NETLIST" "$TEMPNETLIST"

    # ---- verify wrdata exists exactly once ----
    COUNT=$(grep -c "^[[:space:]]*wrdata[[:space:]]" "$TEMPNETLIST" || true)

    if [ "$COUNT" -ne 1 ]; then
        echo "ERROR: Expected exactly one wrdata line"
        rm "$TEMPNETLIST"
        exit 1
    fi

    # ---- replace ONLY the CSV filename ----
    sed -i \
        "s|^\([[:space:]]*wrdata[[:space:]]\)[^[:space:]]\+|\1${CSV}|" \
        "$TEMPNETLIST"

    # ---- run ngspice ----
    ngspice -b -Dcorner="$C" "$TEMPNETLIST" >> "$LOG"

    clean_csv "$CSV" "$CLEANED"

    if [ "$CORNER" = "all" ]; then
        awk -v c="$C" '{print $0, c}' "$CLEANED" >> "$MASTER_CSV"
        echo "" >> "$MASTER_CSV"
        rm "$CSV" "$CLEANED"
    else
        mv "$CLEANED" "$CSV"
    fi

    rm "$TEMPNETLIST"
}

# --------------------------------------------------
# Run simulations
# --------------------------------------------------
if [ "$CORNER" = "all" ]; then
    for C in tt ss ff sf fs; do
        corner_simulate "$C"
    done
else
    corner_simulate "$CORNER"
fi

# --------------------------------------------------
# Organize output
# --------------------------------------------------
OUTDIR="cornerSim_${BASENAME}_${CORNER}_data"
mkdir -p "$OUTDIR/log"

mv "$LOG" "$OUTDIR/log"

if [ -f "$MASTER_CSV" ]; then
    mv "$MASTER_CSV" "$OUTDIR"
else
    mv "${BASENAME}_${CORNER}_${DATE}.csv" "$OUTDIR"
fi

echo ""
echo "Simulation complete."
echo "Results stored in: $OUTDIR"

