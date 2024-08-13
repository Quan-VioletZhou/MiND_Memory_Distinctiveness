# MiND_Memory_Distinctiveness
Created by Violet Zhou for the Michigan Neural Distinctiveness Project

This is a repository to store the scripts we use for neuroimaging analysis during the fMRI memory task

We want to explore how neural activation in the whole brain area is different when people are trying to memorize object stimuli versus scene stimuli

All the shell and make files should be run in a Linux environment, while the R script should be run on a Windows environment.

Workflow: 
1 - download the 2 log file from MiND memory task record (Presentation files)
2 - change the 2 log files to .par files for freesurfer analysis
  2.1 using Turbo for the initiated responses
  2.2 using Par_creater for transform 
3 - upload the 2 .par files to Linux machine ../memory/parfile
4 - run the AddMemLink.sh to generate the symbolic links for makefiles, raw data, and .par files
5 - in the individual folder ../mind/freesurfer/func/pmindo162 run MakeMemIndPar.mk
6 - to view the first-level analysis result, cd to the result directory 
  6.1 using command "tksurfer fsaverage lh inflated"
  6.2 load overlay ces.nii in the folder
  6.3 view --> configuration --> change the threshold to visualize the activation 
7 - for group level analysis:
  7.1 generate the subject list in the ../mind/freesurfer/func
  7.2 run the command: isxconcat-sess -sf sessidlist -analysis sceneobject.sm0.lh -contrast scene-vs-object -o group
(Change this to sessidlist25H for healthy older adults)
  7.3 Cd to /nfs/tpolk/freesurfer/func/group/sceneobject.sm0.lh/scene-vs-object/
  run command: 
  mri_glmfit --y ces.nii.gz \
  --osgm \
  --surface fsaverage lh \
  --glmdir my-glm\
  --save-eres \
  --nii.gz
8 - visualize the group level analysis:
tksurferfv fsaverage lh inflated -aparc -overlay my-glm/osgm/sig.nii.gz -fminmax 2 3

