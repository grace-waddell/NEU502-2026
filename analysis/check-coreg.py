import mne
from mne_bids import BIDSPath, get_head_mri_trans

bids_path = BIDSPath(
    subject='001',
    session='01',
    task='oddball',
    run='01',
    datatype='meg',
    root='/Users/markpinsk/opm-projects/oddball/data/oddball/bids'
)

subjects_dir = '/Users/markpinsk/opm-projects/oddball/data/oddball/bids/derivatives/freesurfer'

trans = get_head_mri_trans(
    bids_path=bids_path,
    fs_subject='sub-001_ses-01',
    fs_subjects_dir=subjects_dir,
)

info = mne.io.read_info('/Users/markpinsk/opm-projects/oddball/data/oddball/bids/sub-001/ses-01/meg/sub-001_ses-01_task-oddball_run-01_split-01_meg.fif')

mne.viz.plot_alignment(
    info=info,
    trans=trans,
    subject='sub-001_ses-01',
    subjects_dir=subjects_dir,
    surfaces='head',
    dig=True,
    meg=True,
    coord_frame='mri',
)

input("Press Enter to close...")