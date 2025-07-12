mkdir denovo
cd denovo
mkdir ltr_finder
cd ltr_finder
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/denovo_predict/bin/denovo_repeat_find.pl --queue st.q --pro_code PARTER --cpu_num 1  -LTR_FINDER -cpu 100 -cutf 100 -run qsub  -tRNA /dellfsqd2/ST_OCEAN/USER/songyue/database/tRNA/danRer7-tRNAs.fa /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta &
cd ..
mkdir repeatmodeler
cd repeatmodeler
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/denovo_predict/bin/denovo_repeat_find.pl --queue st.q --pro_code PARTER --cpu_num 1  -RepeatModeler /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta  &
cd ..
cd ..
mkdir known
cd known
mkdir trf
cd trf
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/find_repeat/bin/find_repeat.pl --queue st.q --pro_code PARTER --cpu_num 1  -trf -cpu 100 -cutf 100 -run qsub  -resource vf=3G -period_size 2000 /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta &
cd ..
mkdir repeatmasker
cd repeatmasker
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/find_repeat/bin/find_repeat.pl --queue st.q --pro_code PARTER --cpu_num 1  -repeatmasker -cpu 100 -cutf 100 -run qsub  -resource vf=3G -lib /zfsqd1/biosoft/pipeline/DNA//DNA_annotation/database/RepBase/RepBase21.01/RepeatMaskerLib.embl.lib /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta &
cd ..
mkdir proteinmask
cd proteinmask
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/find_repeat/bin/find_repeat.pl --queue st.q --pro_code PARTER --cpu_num 1  -proteinmask -cpu 100 -cutf 100 -run qsub  -resource vf=3G -pvalue 0.0001 /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta &
cd ..
cd ..
cd denovo
cd ltr_finder
cat /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/LTR_Result/*ltr_finder > /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/sh_hap1_HiC.fasta.ltr_finder
perl /dellfsqd2/ST_OCEAN/USER/songyue/bin/02.program/LTR_findere_filter.AddStrand.pl /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/sh_hap1_HiC.fasta.ltr_finder sh_hap1_HiC.fasta
mkdir filter
cd filter
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/sh_hap1_HiC.fasta.LTR.fa sh_hap1_HiC.fasta.LTR.fa
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/build_lib/build_library.no_pwd.pl --queue st.q --pro_code PARTER --cpu_num 1  --cpu  100 sh_hap1_HiC.fasta.LTR.fa LTR_FINDER &
cd ..
cd ..
cd ..
cd denovo
mkdir repeatmasker
cd repeatmasker
cat /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/filter/sh_hap1_HiC.fasta.LTR.fa.final.library /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/repeatmodeler/result/consensi.fa.classified > final.library
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/find_repeat/bin/find_repeat.pl --queue st.q --pro_code PARTER --cpu_num 1  -repeatmasker -cpu 100 -cutf 100 -run qsub  -resource vf=3G -lib /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/repeatmasker/final.library /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta &
cd ..
cd ..
mkdir statistics
cd statistics
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/sh_hap1_HiC.fasta sh_hap1_HiC.fasta
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/repeatmasker/sh_hap1_HiC.denovo.RepeatMasker.gff denovo_tmp.gff
perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/01.repeat_finding/denovo_predict/bin/change_ID.pl denovo_tmp.gff
mv denovo_tmp.gff.denovo.gff denovo.gff
rm denovo_tmp.gff
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/repeatmasker/sh_hap1_HiC.denovo.RepeatMasker.out denovo.out
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/known/trf/sh_hap1_HiC.TRF.gff trf.gff
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/known/repeatmasker/sh_hap1_HiC.known.RepeatMasker.gff repeatmasker.gff
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/known/repeatmasker/sh_hap1_HiC.known.RepeatMasker.out repeatmasker.out
ln -s /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/known/proteinmask/sh_hap1_HiC.RepeatProteinMask.gff proteinmask.gff
cat denovo.gff trf.gff repeatmasker.gff proteinmask.gff  > all.gff
cat denovo.gff repeatmasker.gff proteinmask.gff  > all_without_trf.gff
nohup perl /zfsqd1/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/Auto_pipline/auto_repeat/stat.pl -denovo -trf -repeatmasker -proteinmask  sh_hap1_HiC.fasta &
cd ..
mv /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/filter/sh_hap1_HiC.fasta.LTR.fa.final.library /zfsqd1/ST_OCEAN/USRS/songyue/xiamendaxue_liufujiang/repeatannotion/hap1_sh_repeat/denovo/ltr_finder/sh_hap1_HiC.fasta.LTR.fa.final.library
rm -r ./denovo/ltr_finder/LTR_Result
rm -r ./*/*/*.cut ./*/*/nohup.out ./*/*/*.shell ./*/*/*.shell.* ./*/*/*.sh ./*/*/*.sh.* 
rm -r ./*/*/filter

