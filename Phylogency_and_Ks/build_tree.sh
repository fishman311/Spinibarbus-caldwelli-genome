for i in protein/*.fa; do /mnt/soft/prequal/prequal $i > $i.prequal; done
for i in protein/*.filtered; do mafft $i > $i.mafft; done
for a in protein/*.mafft; do java -jar /mnt/lfj/soft/BMGE-1.12/BMGE.jar -i $a -t AA -of $a.bmge; done
ls protein/*.bmge > list
/mnt/soft/bin/catsequences/catsequences list
/mnt/soft/RAxML/usefulScripts/convertFasta2Phylip.sh allseqs.fas > allseqs.phy
modeltest-ng-static -i allseqs.fas -p 50 -T raxml -d aa -o modeltest-ng-static
/mnt/soft/RAxML/raxmlHPC-PTHREADS -f a -x 12345 -s allseqs.phy -# 1000 -p 12345 -m  PROTGAMMAIJTT -n MCL_26_species -T 60 &> RAxML.log

