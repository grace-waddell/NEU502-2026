#!/bin/bash

# ==== EDITABLE DEFAULTS ====
# Modify these parameters for your analysis

# Valid PIPELINE options:
# nifti | bids | freesurfer | coreg | preproc | sensor | source | all | func | anat
# Each pipeline has an associated run_*.sh script.

PIPELINE="coreg"
EXPERIMENT="oddball"
ANALYSIS="analysis1"
SESSION="01"
SUBJECT="001"


# Paths (adjust for your cluster environment)
FREESURFER_HOME="/Applications/freesurfer/8.1.0"

ROOT_DIR="/Users/markpinsk/opm-projects-dryrun/oddball"
CONFIG_BASE="/Users/markpinsk/opm-projects-dryrun/oddball/data/oddball/configs/oddball"
DATA_BASE="/Users/markpinsk/opm-projects-dryrun/oddball/data"

# Processing options
MAX_WORKERS=8 #Ideal for MBP M1 Pro 2021 which has 10 cores (8 performance + 2 efficiency cores)

# ==== END EDITABLE DEFAULTS ====


# ============================================================================
# Derived variables (do not edit below unless necessary)
# ============================================================================



# Construct freesurfer paths
SUBJECTS_DIR="/Users/markpinsk/opm-projects-dryrun/oddball/data/oddball/bids/derivatives/freesurfer"
mkdir -p "$SUBJECTS_DIR"


# Path to the mne-opm.sh script (run/ is sibling to mne-opm/)
MNE_OPM_DIR="/Users/markpinsk/dryrun/mne-opm"
cd "$MNE_OPM_DIR"


# ============================================================================
# Environment setup
# ============================================================================

export MPLBACKEND=qt5agg
export MNE_BROWSER_BACKEND=qt

# Print job info
echo "============================================"
echo "MNE-OPM Local Job"
echo "============================================"
echo "Job ID:        $SLURM_JOB_ID"
echo "Array Task ID: $SLURM_ARRAY_TASK_ID"
echo "Subject:       $SUBJECT"
echo "Pipeline:      $PIPELINE"
echo "Experiment:    $EXPERIMENT"
echo "Analysis:      $ANALYSIS"
echo "Session:       $SESSION"
echo "Start time:    $(date)"
echo "============================================"

# ============================================================================
# Run the pipeline
# ============================================================================

# Call mne-opm.sh with all parameters
sh mne-opm.sh "$PIPELINE" \
    --exp "$EXPERIMENT" \
    --sub "$SUBJECT" \
    --analysis "$ANALYSIS" \
    --session "$SESSION" \
    --data "$DATA_BASE" \
    --config "$CONFIG_BASE" \
    --fs "$FREESURFER_HOME" \
    --subjects-dir "$SUBJECTS_DIR" \
    --workers "$MAX_WORKERS"\
    --fail-on-first-crash

# Capture exit status
EXIT_STATUS=$?

# ============================================================================
# Cleanup and reporting
# ============================================================================

echo "============================================"
echo "End time: $(date)"
echo "Exit status: $EXIT_STATUS"
echo "============================================"

exit $EXIT_STATUS
