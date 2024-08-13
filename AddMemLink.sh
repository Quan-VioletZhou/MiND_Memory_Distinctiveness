#!/bin/bash
# This bash script will add data from a session into the MiND project directory structure
# and add all the necessary symbolic links needed by the makefiles.
# It requires a single command line argument which is the name of the directory in the
# /export/subjects directory on the fMRI server (romero.engin) that you want to add.

# First, ask the user for some information that is needed to generate the subjid and session info

read -p 'Please enter the subject ID for the data you want to add (e.g.mindo335 or mindb213): ' subjnum

subject=$subjnum

subjdir=/nfs/tpolk/mind/subjects/$subject
datapath=$subjdir/placebodti/func
fsfastdir=/nfs/tpolk/mind/freesurfer/func/p$subject

ln -sf /nfs/tpolk/mind/lib/makefiles/MakeMemIndPar.mk $fsfastdir/MakeMemIndPar.mk

mkdir $fsfastdir/memory
mkdir $fsfastdir/memory/001
mkdir $fsfastdir/memory/002

ln -s $subjdir/placebodti/func/memory/run_01/tprun_01.nii $fsfastdir/memory/001/f.nii
ln -s $subjdir/placebodti/func/memory2/run_01/tprun_01.nii $fsfastdir/memory/002/f.nii


ln -sf /nfs/tpolk/mind/Echo/memory_subject_par/$subjnum.Scenes.Objects.001.par $fsfastdir/memory/001/Scenes.Objects.par
ln -sf /nfs/tpolk/mind/Echo/memory_subject_par/$subjnum.Scenes.Objects.002.par $fsfastdir/memory/002/Scenes.Objects.par



