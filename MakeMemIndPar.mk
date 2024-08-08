SHELL := /bin/bash

# Note that the symbolic links to this makefile are in /nfs/tpolk/mind/freesurfer/func/?mind????
# It will normally be called recursively from the makefile in the func directory above it

# Make sure the Freesurfer subjects directory is set correctly
export SUBJECTS_DIR=/nfs/tpolk/mind/freesurfer

# get subject id from the path
subject=$(shell pwd|egrep -o '[dp]mind[bmoy][0-9][0-9][0-9]')
stripsubject=$(shell pwd|egrep -o 'mind[bmoy][0-9][0-9][0-9]')


.PHONY: fit fitmemory 
.PHONY: fitmemoryunsm fitmemorysm

fit: fitmemory 
fitmemory: fitmemoryunsm fitmemorysm

fitmemoryunsm: memory/sceneobject.ind.sm0.con8.lh/beta.nii.gz memory/sceneobject.ind.sm0.con8.rh/beta.nii.gz memory/sceneobject.ind.sm0.con8.mni305/beta.nii.gz
fitmemorysm: memory/sceneobject.ind.sm8.con8.lh/beta.nii.gz memory/sceneobject.ind.sm8.con8.rh/beta.nii.gz memory/sceneobject.ind.sm8.con8.mni305/beta.nii.gz

memory/sceneobject.ind.sm0.con8.lh/beta.nii.gz: ../sceneobject.ind.sm0.con8.lh/correct.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.lh/correct.object-vs-fix.mat ../sceneobject.ind.sm0.con8.lh/correct.scene-vs-correct.object.mat ../sceneobject.ind.sm0.con8.lh/correct.object-vs-correct.scene.mat ../sceneobject.ind.sm0.con8.lh/correct.object.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.lh/all.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.lh/all.object-vs-fix.mat ../sceneobject.ind.sm0.con8.lh/all.scene-vs-all.object.mat ../sceneobject.ind.sm0.con8.lh/all.object-vs-all.scene.mat ../sceneobject.ind.sm0.con8.lh/all.object.scene-vs-fix.mat convertunsm-memory001 convertunsm-memory002 memory/001/Scenes.Objects.par memory/002/Scenes.Objects.par
	cd .. ;\
	selxavg3-sess -s $(subject) -analysis sceneobject.ind.sm0.con8.lh

../sceneobject.ind.sm0.con8.lh/correct.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast correct.scene-vs-fix -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.lh/correct.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast correct.object-vs-fix -a 2 -a 3 -c 0

../sceneobject.ind.sm0.con8.lh/correct.scene-vs-correct.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast correct.scene-vs-correct.object -a 5 -a 6 -c 2 -c 3

../sceneobject.ind.sm0.con8.lh/correct.object-vs-correct.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast correct.object-vs-correct.scene -a 2 -a 3 -c 5 -c 6
	
../sceneobject.ind.sm0.con8.lh/correct.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast correct.object.scene-vs-fix -a 2 -a 3 -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.lh/all.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast all.scene-vs-fix -a 4 -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.lh/all.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast all.object-vs-fix -a 1 -a 2 -a 3 -c 0
	
../sceneobject.ind.sm0.con8.lh/all.scene-vs-all.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast all.scene-vs-all.object -a 4 -a 5 -a 6 -c 1 -c 2 -c 3

../sceneobject.ind.sm0.con8.lh/all.object-vs-all.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast all.object-vs-all.scene -a 1 -a 2 -a 3 -c 4 -c 5 -c 6

../sceneobject.ind.sm0.con8.lh/all.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.lh -contrast all.object.scene-vs-fix -a 1 -a 2 -a 3 -a 4 -a 5 -a 6 -c 0

	
#### starting rh sm0 

memory/sceneobject.ind.sm0.con8.rh/beta.nii.gz: ../sceneobject.ind.sm0.con8.rh/correct.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.rh/correct.object-vs-fix.mat ../sceneobject.ind.sm0.con8.rh/correct.scene-vs-correct.object.mat ../sceneobject.ind.sm0.con8.rh/correct.object-vs-correct.scene.mat ../sceneobject.ind.sm0.con8.rh/correct.object.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.rh/all.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.rh/all.object-vs-fix.mat ../sceneobject.ind.sm0.con8.rh/all.scene-vs-all.object.mat ../sceneobject.ind.sm0.con8.rh/all.object-vs-all.scene.mat ../sceneobject.ind.sm0.con8.rh/all.object.scene-vs-fix.mat convertunsm-memory001 convertunsm-memory002 memory/001/Scenes.Objects.par memory/002/Scenes.Objects.par
	cd .. ;\
	selxavg3-sess -s $(subject) -analysis sceneobject.ind.sm0.con8.rh

../sceneobject.ind.sm0.con8.rh/correct.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast correct.scene-vs-fix -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.rh/correct.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast correct.object-vs-fix -a 2 -a 3 -c 0

../sceneobject.ind.sm0.con8.rh/correct.scene-vs-correct.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast correct.scene-vs-correct.object -a 5 -a 6 -c 2 -c 3

../sceneobject.ind.sm0.con8.rh/correct.object-vs-correct.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast correct.object-vs-correct.scene -a 2 -a 3 -c 5 -c 6
	
../sceneobject.ind.sm0.con8.rh/correct.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast correct.object.scene-vs-fix -a 2 -a 3 -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.rh/all.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast all.scene-vs-fix -a 4 -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.rh/all.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast all.object-vs-fix -a 1 -a 2 -a 3 -c 0
	
../sceneobject.ind.sm0.con8.rh/all.scene-vs-all.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast all.scene-vs-all.object -a 4 -a 5 -a 6 -c 1 -c 2 -c 3

../sceneobject.ind.sm0.con8.rh/all.object-vs-all.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast all.object-vs-all.scene -a 1 -a 2 -a 3 -c 4 -c 5 -c 6

../sceneobject.ind.sm0.con8.rh/all.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.rh -contrast all.object.scene-vs-fix -a 1 -a 2 -a 3 -a 4 -a 5 -a 6 -c 0
	
### end of rh sm0

memory/sceneobject.ind.sm0.con8.mni305/beta.nii.gz: ../sceneobject.ind.sm0.con8.mni305/correct.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.mni305/correct.object-vs-fix.mat ../sceneobject.ind.sm0.con8.mni305/correct.scene-vs-correct.object.mat ../sceneobject.ind.sm0.con8.mni305/correct.object-vs-correct.scene.mat ../sceneobject.ind.sm0.con8.mni305/correct.object.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.mni305/all.scene-vs-fix.mat ../sceneobject.ind.sm0.con8.mni305/all.object-vs-fix.mat ../sceneobject.ind.sm0.con8.mni305/all.scene-vs-all.object.mat ../sceneobject.ind.sm0.con8.mni305/all.object-vs-all.scene.mat ../sceneobject.ind.sm0.con8.mni305/all.object.scene-vs-fix.mat convertunsm-memory001 convertunsm-memory002 memory/001/Scenes.Objects.par memory/002/Scenes.Objects.par
	cd .. ;\
	selxavg3-sess -s $(subject) -analysis sceneobject.ind.sm0.con8.mni305

../sceneobject.ind.sm0.con8.mni305/correct.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast correct.scene-vs-fix -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.mni305/correct.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast correct.object-vs-fix -a 2 -a 3 -c 0

../sceneobject.ind.sm0.con8.mni305/correct.scene-vs-correct.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast correct.scene-vs-correct.object -a 5 -a 6 -c 2 -c 3

../sceneobject.ind.sm0.con8.mni305/correct.object-vs-correct.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast correct.object-vs-correct.scene -a 2 -a 3 -c 5 -c 6
	
../sceneobject.ind.sm0.con8.mni305/correct.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast correct.object.scene-vs-fix -a 2 -a 3 -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.mni305/all.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast all.scene-vs-fix -a 4 -a 5 -a 6 -c 0

../sceneobject.ind.sm0.con8.mni305/all.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast all.object-vs-fix -a 1 -a 2 -a 3 -c 0
	
../sceneobject.ind.sm0.con8.mni305/all.scene-vs-all.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast all.scene-vs-all.object -a 4 -a 5 -a 6 -c 1 -c 2 -c 3

../sceneobject.ind.sm0.con8.mni305/all.object-vs-all.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast all.object-vs-all.scene -a 1 -a 2 -a 3 -c 4 -c 5 -c 6

../sceneobject.ind.sm0.con8.mni305/all.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm0.con8.mni305 -contrast all.object.scene-vs-fix -a 1 -a 2 -a 3 -a 4 -a 5 -a 6 -c 0

memory/sceneobject.ind.sm8.con8.lh/beta.nii.gz: ../sceneobject.ind.sm8.con8.lh/correct.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.lh/correct.object-vs-fix.mat ../sceneobject.ind.sm8.con8.lh/correct.scene-vs-correct.object.mat ../sceneobject.ind.sm8.con8.lh/correct.object-vs-correct.scene.mat ../sceneobject.ind.sm8.con8.lh/correct.object.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.lh/all.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.lh/all.object-vs-fix.mat ../sceneobject.ind.sm8.con8.lh/all.scene-vs-all.object.mat ../sceneobject.ind.sm8.con8.lh/all.object-vs-all.scene.mat ../sceneobject.ind.sm8.con8.lh/all.object.scene-vs-fix.mat convertunsm-memory001 convertunsm-memory002 memory/001/Scenes.Objects.par memory/002/Scenes.Objects.par
	cd .. ;\
	selxavg3-sess -s $(subject) -analysis sceneobject.ind.sm8.con8.lh

../sceneobject.ind.sm8.con8.lh/correct.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast correct.scene-vs-fix -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.lh/correct.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast correct.object-vs-fix -a 2 -a 3 -c 0

../sceneobject.ind.sm8.con8.lh/correct.scene-vs-correct.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast correct.scene-vs-correct.object -a 5 -a 6 -c 2 -c 3

../sceneobject.ind.sm8.con8.lh/correct.object-vs-correct.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast correct.object-vs-correct.scene -a 2 -a 3 -c 5 -c 6
	
../sceneobject.ind.sm8.con8.lh/correct.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast correct.object.scene-vs-fix -a 2 -a 3 -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.lh/all.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast all.scene-vs-fix -a 4 -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.lh/all.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast all.object-vs-fix -a 1 -a 2 -a 3 -c 0
	
../sceneobject.ind.sm8.con8.lh/all.scene-vs-all.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast all.scene-vs-all.object -a 4 -a 5 -a 6 -c 1 -c 2 -c 3

../sceneobject.ind.sm8.con8.lh/all.object-vs-all.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast all.object-vs-all.scene -a 1 -a 2 -a 3 -c 4 -c 5 -c 6

../sceneobject.ind.sm8.con8.lh/all.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.lh -contrast all.object.scene-vs-fix -a 1 -a 2 -a 3 -a 4 -a 5 -a 6 -c 0
	
#### starting rh sm8 

memory/sceneobject.ind.sm8.con8.rh/beta.nii.gz: ../sceneobject.ind.sm8.con8.rh/correct.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.rh/correct.object-vs-fix.mat ../sceneobject.ind.sm8.con8.rh/correct.scene-vs-correct.object.mat ../sceneobject.ind.sm8.con8.rh/correct.object-vs-correct.scene.mat ../sceneobject.ind.sm8.con8.rh/correct.object.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.rh/all.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.rh/all.object-vs-fix.mat ../sceneobject.ind.sm8.con8.rh/all.scene-vs-all.object.mat ../sceneobject.ind.sm8.con8.rh/all.object-vs-all.scene.mat ../sceneobject.ind.sm8.con8.rh/all.object.scene-vs-fix.mat convertunsm-memory001 convertunsm-memory002 memory/001/Scenes.Objects.par memory/002/Scenes.Objects.par
	cd .. ;\
	selxavg3-sess -s $(subject) -analysis sceneobject.ind.sm8.con8.rh

../sceneobject.ind.sm8.con8.rh/correct.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast correct.scene-vs-fix -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.rh/correct.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast correct.object-vs-fix -a 2 -a 3 -c 0

../sceneobject.ind.sm8.con8.rh/correct.scene-vs-correct.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast correct.scene-vs-correct.object -a 5 -a 6 -c 2 -c 3

../sceneobject.ind.sm8.con8.rh/correct.object-vs-correct.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast correct.object-vs-correct.scene -a 2 -a 3 -c 5 -c 6
	
../sceneobject.ind.sm8.con8.rh/correct.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast correct.object.scene-vs-fix -a 2 -a 3 -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.rh/all.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast all.scene-vs-fix -a 4 -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.rh/all.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast all.object-vs-fix -a 1 -a 2 -a 3 -c 0
	
../sceneobject.ind.sm8.con8.rh/all.scene-vs-all.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast all.scene-vs-all.object -a 4 -a 5 -a 6 -c 1 -c 2 -c 3

../sceneobject.ind.sm8.con8.rh/all.object-vs-all.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast all.object-vs-all.scene -a 1 -a 2 -a 3 -c 4 -c 5 -c 6

../sceneobject.ind.sm8.con8.rh/all.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.rh -contrast all.object.scene-vs-fix -a 1 -a 2 -a 3 -a 4 -a 5 -a 6 -c 0
	
### end of rh sm8

memory/sceneobject.ind.sm8.con8.mni305/beta.nii.gz: ../sceneobject.ind.sm8.con8.mni305/correct.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.mni305/correct.object-vs-fix.mat ../sceneobject.ind.sm8.con8.mni305/correct.scene-vs-correct.object.mat ../sceneobject.ind.sm8.con8.mni305/correct.object-vs-correct.scene.mat ../sceneobject.ind.sm8.con8.mni305/correct.object.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.mni305/all.scene-vs-fix.mat ../sceneobject.ind.sm8.con8.mni305/all.object-vs-fix.mat ../sceneobject.ind.sm8.con8.mni305/all.scene-vs-all.object.mat ../sceneobject.ind.sm8.con8.mni305/all.object-vs-all.scene.mat ../sceneobject.ind.sm8.con8.mni305/all.object.scene-vs-fix.mat convertunsm-memory001 convertunsm-memory002 memory/001/Scenes.Objects.par memory/002/Scenes.Objects.par
	cd .. ;\
	selxavg3-sess -s $(subject) -analysis sceneobject.ind.sm8.con8.mni305

../sceneobject.ind.sm8.con8.mni305/correct.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast correct.scene-vs-fix -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.mni305/correct.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast correct.object-vs-fix -a 2 -a 3 -c 0

../sceneobject.ind.sm8.con8.mni305/correct.scene-vs-correct.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast correct.scene-vs-correct.object -a 5 -a 6 -c 2 -c 3

../sceneobject.ind.sm8.con8.mni305/correct.object-vs-correct.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast correct.object-vs-correct.scene -a 2 -a 3 -c 5 -c 6
	
../sceneobject.ind.sm8.con8.mni305/correct.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast correct.object.scene-vs-fix -a 2 -a 3 -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.mni305/all.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast all.scene-vs-fix -a 4 -a 5 -a 6 -c 0

../sceneobject.ind.sm8.con8.mni305/all.object-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast all.object-vs-fix -a 1 -a 2 -a 3 -c 0
	
../sceneobject.ind.sm8.con8.mni305/all.scene-vs-all.object.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast all.scene-vs-all.object -a 4 -a 5 -a 6 -c 1 -c 2 -c 3

../sceneobject.ind.sm8.con8.mni305/all.object-vs-all.scene.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast all.object-vs-all.scene -a 1 -a 2 -a 3 -c 4 -c 5 -c 6

../sceneobject.ind.sm8.con8.mni305/all.object.scene-vs-fix.mat:
	cd .. ;\
	mkcontrast-sess -analysis sceneobject.ind.sm8.con8.mni305 -contrast all.object.scene-vs-fix -a 1 -a 2 -a 3 -a 4 -a 5 -a 6 -c 0


.PHONY: convertall convertunsm convertsm

convertall: convertunsm convertsm 
convertunsm: convertunsm-memory001 convertunsm-memory002
convertsm: convertsm-memory001 convertsm-memory002


convertunsm-memory001: memory/001/fmcpr.sm0.con8.mni305.2mm.nii.gz 
	mri_convert -tr 2000 $(word 1,$^) $(word 1,$^) ;\
	mri_convert -tr 2000 memory/001/fmcpr.sm0.fsaverage.lh.nii.gz memory/001/fmcpr.sm0.fsaverage.lh.nii.gz ;\
	mri_convert -tr 2000 memory/001/fmcpr.sm0.fsaverage.rh.nii.gz memory/001/fmcpr.sm0.fsaverage.rh.nii.gz ;\
	mri_convert -tr 2000 memory/001/fmcpr.sm0.con8.mni305.2mm.nii.gz memory/001/fmcpr.sm0.con8.mni305.2mm.nii.gz ;\
	touch convertunsm-memory001
	
convertunsm-memory002: memory/002/fmcpr.sm0.con8.mni305.2mm.nii.gz 
	mri_convert -tr 2000 $(word 1,$^) $(word 1,$^) ;\
	mri_convert -tr 2000 memory/002/fmcpr.sm0.fsaverage.lh.nii.gz memory/002/fmcpr.sm0.fsaverage.lh.nii.gz ;\
	mri_convert -tr 2000 memory/002/fmcpr.sm0.fsaverage.rh.nii.gz memory/002/fmcpr.sm0.fsaverage.rh.nii.gz ;\
	mri_convert -tr 2000 memory/002/fmcpr.sm0.con8.mni305.2mm.nii.gz memory/002/fmcpr.sm0.con8.mni305.2mm.nii.gz ;\
	touch convertunsm-memory002

convertsm-memory001: memory/001/fmcpr.sm8.con8.mni305.2mm.nii.gz 
	mri_convert -tr 2000 $(word 1,$^) $(word 1,$^) ;\
	mri_convert -tr 2000 memory/001/fmcpr.sm8.fsaverage.lh.nii.gz memory/001/fmcpr.sm8.fsaverage.lh.nii.gz ;\
	mri_convert -tr 2000 memory/001/fmcpr.sm8.fsaverage.rh.nii.gz memory/001/fmcpr.sm8.fsaverage.rh.nii.gz ;\
	mri_convert -tr 2000 memory/001/fmcpr.sm8.con8.mni305.2mm.nii.gz memory/001/fmcpr.sm8.con8.mni305.2mm.nii.gz ;\
	touch convertsm-memory001
	
convertsm-memory002: memory/002/fmcpr.sm8.con8.mni305.2mm.nii.gz 
	mri_convert -tr 2000 $(word 1,$^) $(word 1,$^) ;\
	mri_convert -tr 2000 memory/002/fmcpr.sm8.fsaverage.lh.nii.gz memory/002/fmcpr.sm8.fsaverage.lh.nii.gz ;\
	mri_convert -tr 2000 memory/002/fmcpr.sm8.fsaverage.rh.nii.gz memory/002/fmcpr.sm8.fsaverage.rh.nii.gz ;\
	mri_convert -tr 2000 memory/002/fmcpr.sm8.con8.mni305.2mm.nii.gz memory/002/fmcpr.sm8.con8.mni305.2mm.nii.gz ;\
	touch convertsm-memory002


.PHONY: preprocall
.PHONY: preprocunsm preprocunsm-memory001 preprocunsm-memory002
.PHONY: preprocsm preprocsm-memory001 preprocsm-memory002

preprocall: preprocunsm preprocsm
preprocunsm: preprocunsm-memory001 preprocunsm-memory002
preprocsm: preprocsm-memory001 preprocsm-memory002


###
preprocunsm-memory001: memory/001/fmcpr.sm0.con8.mni305.2mm.nii.gz
preprocunsm-memory002: memory/002/fmcpr.sm0.con8.mni305.2mm.nii.gz

preprocsm-memory001: memory/001/fmcpr.sm8.con8.mni305.2mm.nii.gz
preprocsm-memory002: memory/002/fmcpr.sm8.con8.mni305.2mm.nii.gz


memory/001/fmcpr.sm0.con8.mni305.2mm.nii.gz: memory/001/f.nii subjectname
	cd .. ;\
	preproc-sess -s $(subject) -surface fsaverage lhrh -mni305 -fwhm 0 -per-run -fsd memory

memory/002/fmcpr.sm0.con8.mni305.2mm.nii.gz: memory/002/f.nii subjectname
	cd .. ;\
	preproc-sess -s $(subject) -surface fsaverage lhrh -mni305 -fwhm 0 -per-run -fsd memory


memory/001/fmcpr.sm8.con8.mni305.2mm.nii.gz: memory/001/f.nii subjectname
	cd .. ;\
	preproc-sess -s $(subject) -surface fsaverage lhrh -mni305 -fwhm 8 -per-run -fsd memory

memory/002/fmcpr.sm8.con8.mni305.2mm.nii.gz: memory/002/f.nii subjectname
	cd .. ;\
	preproc-sess -s $(subject) -surface fsaverage lhrh -mni305 -fwhm 8 -per-run -fsd memory


# subjectname:echo $(stripsubject) > subjectname


print-%  : ; @echo $* = $($*)

