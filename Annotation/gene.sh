#!/bin/bash
cwd=$PWD
genome=sh_hap1.masked.fasta

# /tools/remask.pl seriola.map.pilon03.fasta all_without_trf.gff > Seriola.masked.fasta

mkdir $cwd/Augustus && cd $cwd/Augustus
export export AUGUSTUS_CONFIG_PATH="/01_software/mamba/envs/augustus/config:$AUGUSTUS_CONFIG_PATH"
export PATH="/01_software/hmmer/bin/:$PATH"
export PATH="/01_software/mamba/envs/augustus/bin/":$PATH
export PATH="/01_software/mamba/envs/augustus/scripts/":$PATH
export PYTHONPATH=/software/Annotation/busco/src:$PYTHONPATH

nohup perl /share/biosoft/pipeline/DNA/DNA_annotation/Annotation_pipeline1_1.0/01.gene_finding/denovo-predict/bin/denovo-predict.pl --augustus zebrafish --cpu 40 --queue st.q --pro_code PARTER $cwd/$genome &
cd $cwd

mkdir $cwd/Genescan && cd $cwd/Genescan
nohup perl /share/biosoft/pipeline/DNA/DNA_annotation/Annotation_pipeline1_1.0/01.gene_finding/denovo-predict/bin/denovo-predict.pl --genscan /share/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/02.gene_finding/denovo-predict/dat/genscan_para/HumanIso.smat --cpu 40 --queue st.q --pro_code PARTER $cwd/$genome &
cd $cwd

mkdir $cwd/Glimmer && cd $cwd/Glimmer
nohup perl /share/biosoft/pipeline/DNA/DNA_annotation/Annotation_2016a/bin/02.gene_finding/denovo-predict/GlimmerHMM/glimmerHmm_prediction_2016a.pl --glimmerHMM /share/biosoft/pipeline/DNA/DNA_annotation/software/gene/GlimmerHMM-3.0.4/trained_dir/zebrafish --cpu 40 --run qsub --queue st.q --pro_code PARTER $cwd/$genome &
cd $cwd


export WISECONFIGDIR="/zfsqd1/biosoft/pipeline/DNA/DNA_annotation/software/gene/genewise/wise2.4.1/wisecfg/"
export PATH=/share/app/perl-5.10.1/bin/:$PATH
export PERL5LIB=/share/app/perl_lib/lib/perl5:/share/app/perl_lib/share/perl5:/share/app/perl_lib/lib64/perl5:/share/app/perl-5.10.1/lib/5.10.1:/share/app/perl-5.10.1/lib/site_perl/5.10:$PERL5LIB
export LD_LIBRARY_PATH="/share/app/mysql/lib:$LD_LIBRARY_PATH"
prot=/project/database/carp/carp.final.reform.pep
genome=/repeatannotion/01.hap1_sh_repeat/sh_hap1_HiC.fasta

nohup perl /Software/blat_homolog_annotation_pipeline/blat_homolog_annotation.pl -p $prot -r $genome -t 5 -a 0.3 -d 0.2 -c 20 -s 1234 -e 1000 -q "-P PARTER -l vf=5g,num_proc=5" &
export WISECONFIGDIR="/zfsqd1/biosoft/pipeline/DNA/DNA_annotation/software/gene/genewise/wise2.4.1/wisecfg/"
export PATH=/share/app/perl-5.10.1/bin/:$PATH
export PERL5LIB=/share/app/perl_lib/lib/perl5:/share/app/perl_lib/share/perl5:/share/app/perl_lib/lib64/perl5:/share/app/perl-5.10.1/lib/5.10.1:/share/app/perl-5.10.1/lib/site_perl/5.10:$PERL5LIB
export LD_LIBRARY_PATH="/share/app/mysql/lib:$LD_LIBRARY_PATH"
prot=/project/database/goldfish/goldfish.final.reform.pep
genome=/repeatannotion/01.hap1_sh_repeat/sh_hap1_HiC.fasta

nohup perl /Software/blat_homolog_annotation_pipeline/blat_homolog_annotation.pl -p $prot -r $genome -t 5 -a 0.3 -d 0.2 -c 20 -s 1234 -e 1000 -q "-P PARTER -l vf=5g,num_proc=5" &
export WISECONFIGDIR="/zfsqd1/biosoft/pipeline/DNA/DNA_annotation/software/gene/genewise/wise2.4.1/wisecfg/"
export PATH=/share/app/perl-5.10.1/bin/:$PATH
export PERL5LIB=/share/app/perl_lib/lib/perl5:/share/app/perl_lib/share/perl5:/share/app/perl_lib/lib64/perl5:/share/app/perl-5.10.1/lib/5.10.1:/share/app/perl-5.10.1/lib/site_perl/5.10:$PERL5LIB
export LD_LIBRARY_PATH="/share/app/mysql/lib:$LD_LIBRARY_PATH"
prot=/project/database/onm/onm.final.reform.pep
genome=/repeatannotion/01.hap1_sh_repeat/sh_hap1_HiC.fasta

nohup perl /Software/blat_homolog_annotation_pipeline/blat_homolog_annotation.pl -p $prot -r $genome -t 5 -a 0.3 -d 0.2 -c 20 -s 1234 -e 1000 -q "-P PARTER -l vf=5g,num_proc=5" &
export WISECONFIGDIR="/zfsqd1/biosoft/pipeline/DNA/DNA_annotation/software/gene/genewise/wise2.4.1/wisecfg/"
export PATH=/share/app/perl-5.10.1/bin/:$PATH
export PERL5LIB=/share/app/perl_lib/lib/perl5:/share/app/perl_lib/share/perl5:/share/app/perl_lib/lib64/perl5:/share/app/perl-5.10.1/lib/5.10.1:/share/app/perl-5.10.1/lib/site_perl/5.10:$PERL5LIB
export LD_LIBRARY_PATH="/share/app/mysql/lib:$LD_LIBRARY_PATH"
prot=/project/database/pho/ph.pep
genome=/repeatannotion/01.hap1_sh_repeat/sh_hap1_HiC.fasta

nohup perl /Software/blat_homolog_annotation_pipeline/blat_homolog_annotation.pl -p $prot -r $genome -t 5 -a 0.3 -d 0.2 -c 20 -s 1234 -e 1000 -q "-P PARTER -l vf=5g,num_proc=5" &

4、	RNA_seq 注释

cat ./00.data/samples.lst | while read line; do
fwd=/repeatannotion/04.RNA/00.data/$line/${line}_1.clean.fq.gz
rev=/repeatannotion/04.RNA/00.data/$line/${line}_2.clean.fq.gz
echo /software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x $PWD/sh_hap1_HiC.fasta -1 $fwd -2 $rev \| /share/app/samtools-1.9/bin/samtools view -b -@ 1 - \| /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T ${line} -o ${line}-sorted.bam >> step2.sh
done

# before run step2.sh , check phred value 33 or 64
cat 00.data/samples.lst | while read line; do
    echo /software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie $PWD/step2.sh.32071.qsub/${line}-sorted.bam -o $PWD/step2.sh.32071.qsub/${line}.gtf >> step3.sh
    echo $PWD/step2.sh.32071.qsub/${line}.gtf >> gtf.list
done
/software/Aligner/hisat2/hisat2-build sh_hap1_HiC.fasta sh_hap1_HiC.fasta -p 20
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_42/DP8400026080BL_L01_42_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_42/DP8400026080BL_L01_42_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_42 -o DP8400026080BL_L01_42-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_43/DP8400026080BL_L01_43_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_43/DP8400026080BL_L01_43_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_43 -o DP8400026080BL_L01_43-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_44/DP8400026080BL_L01_44_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_44/DP8400026080BL_L01_44_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_44 -o DP8400026080BL_L01_44-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_45/DP8400026080BL_L01_45_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_45/DP8400026080BL_L01_45_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_45 -o DP8400026080BL_L01_45-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_46/DP8400026080BL_L01_46_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_46/DP8400026080BL_L01_46_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_46 -o DP8400026080BL_L01_46-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_47/DP8400026080BL_L01_47_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_47/DP8400026080BL_L01_47_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_47 -o DP8400026080BL_L01_47-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_48/DP8400026080BL_L01_48_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_48/DP8400026080BL_L01_48_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_48 -o DP8400026080BL_L01_48-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_57/DP8400026080BL_L01_57_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_57/DP8400026080BL_L01_57_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_57 -o DP8400026080BL_L01_57-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_58/DP8400026080BL_L01_58_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_58/DP8400026080BL_L01_58_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_58 -o DP8400026080BL_L01_58-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_59/DP8400026080BL_L01_59_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_59/DP8400026080BL_L01_59_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_59 -o DP8400026080BL_L01_59-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_60/DP8400026080BL_L01_60_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_60/DP8400026080BL_L01_60_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_60 -o DP8400026080BL_L01_60-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_61/DP8400026080BL_L01_61_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_61/DP8400026080BL_L01_61_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_61 -o DP8400026080BL_L01_61-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_62/DP8400026080BL_L01_62_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026080BL_L01_62/DP8400026080BL_L01_62_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026080BL_L01_62 -o DP8400026080BL_L01_62-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026718BR_L01_60/DP8400026718BR_L01_60_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026718BR_L01_60/DP8400026718BR_L01_60_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026718BR_L01_60 -o DP8400026718BR_L01_60-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026719BR_L01_46/DP8400026719BR_L01_46_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026719BR_L01_46/DP8400026719BR_L01_46_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026719BR_L01_46 -o DP8400026719BR_L01_46-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400026719BR_L01_59/DP8400026719BR_L01_59_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400026719BR_L01_59/DP8400026719BR_L01_59_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400026719BR_L01_59 -o DP8400026719BR_L01_59-sorted.bam
/software/Aligner/hisat2/hisat2 --dta --phred33 -p 1 -x /repeatannotion/04.RNA/sh_hap1_HiC.fasta -1 /repeatannotion/04.RNA/00.data/DP8400027213BL_L01_316/DP8400027213BL_L01_316_1.clean.fq.gz -2 /repeatannotion/04.RNA/00.data/DP8400027213BL_L01_316/DP8400027213BL_L01_316_2.clean.fq.gz | /share/app/samtools-1.9/bin/samtools view -b -@ 1 - | /share/app/samtools-1.9/bin/samtools sort -@ 1 - -T DP8400027213BL_L01_316 -o DP8400027213BL_L01_316-sorted.bam
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_42-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_42.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_43-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_43.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_44-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_44.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_45-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_45.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_46-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_46.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_47-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_47.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_48-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_48.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_57-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_57.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_58-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_58.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_59-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_59.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_60-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_60.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_61-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_61.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_62-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026080BL_L01_62.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026718BR_L01_60-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026718BR_L01_60.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026719BR_L01_46-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026719BR_L01_46.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026719BR_L01_59-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400026719BR_L01_59.gtf
/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400027213BL_L01_316-sorted.bam -o /repeatannotion/04.RNA/step2.sh.32071.qsub/DP8400027213BL_L01_316.gtf
#!/bin/bash
export PATH=/share/app/perl-5.22.0/bin:$PATH
export PERL5LIB=/software/TransDecoder-TransDecoder-v5.0.2/util/../PerlLib:$PERL5LIB
base=/software/TransDecoder-TransDecoder-v5.0.2
#/software/Assembler/stringtie-1.3.5.Linux_x86_64/stringtie --merge gtf.list -o Sh_hap1.merged.gtf
/home/bin/perl $base/util/gtf_genome_to_cdna_fasta.pl Sh_hap1.merged.gtf /repeatannotion/04.RNA/sh_hap1_HiC.fasta > transcripts.fasta
/home/bin/perl $base/TransDecoder.LongOrfs -t transcripts.fasta

ln -s transcripts.fasta.transdecoder_dir/longest_orfs.pep
/home/bin/fastaDeal.pl --cutf 200 longest_orfs.pep 
mkdir blast.qsub  pfam.qsub
for i in `seq 1 200`
do
echo "/home/bin/blastp -query ../longest_orfs.pep.cut/longest_orfs.pep.${i} -db /share/biosoft/database/Pub/swissprot/RNA/release-2017_09/uniprot_sprot.fasta  -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 1 > blastp.${i}.outfmt6 ; echo done " > blast.qsub/blast.${i}.sh
echo "/home/bin/hmmscan --cpu 1 --domtblout pfam.${i}.domtblout /share/biosoft/database/Pub/Pfam/Pfam-A.hmm ../longest_orfs.pep.cut/longest_orfs.pep.${i} ; echo done " > pfam.qsub/pfam.${i}.sh
done
cd blast.qsub
for i in `seq 1 200`
do
    qsub -cwd -q st.q -P PARTER -l num_proc=1,vf=0.5G -binding linear:1 blast.${i}.sh
done
cd ..
cd pfam.qsub 
for i in `seq 1 200`
do
    qsub -cwd -q st.q -P PARTER -l num_proc=1,vf=0.5G -binding linear:1 pfam.${i}.sh
done
cd ..
### $1 number of pfam splitted,in this case 50 
cat pfam.qsub/pfam.1.domtblout > pfam.domtblout
for i in `seq 2 200`
do
    less pfam.qsub/pfam.${i}.domtblout |grep -v '^#' >> pfam.domtblout
done

cat blast.qsub/blast*outfmt6 > blastp.outfmt6

#!/bin/bash

export PATH=/share/app/perl-5.22.0/bin:$PATH
export PERL5LIB=/software/TransDecoder-TransDecoder-v5.0.2/util/../PerlLib:$PERL5LIB
/software/TransDecoder-TransDecoder-v5.0.2/TransDecoder.Predict -t transcripts.fasta --retain_pfam_hits pfam.domtblout --retain_blastp_hits blastp.outfmt6

#gtf2gff $1 gtf
export PATH=/share/app/perl-5.22.0/bin:$PATH
export PERL5LIB=/software/TransDecoder-TransDecoder-v5.0.2/util/../PerlLib:$PERL5LIB
base=/software/TransDecoder-TransDecoder-v5.0.2
$base/util/gtf_to_alignment_gff3.pl Sh_hap1.merged.gtf > transcripts.gff3
$base/util/cdna_alignment_orf_to_genome_orf.pl transcripts.fasta.transdecoder.gff3 transcripts.gff3  transcripts.fasta > transcripts.fasta.transdecoder.genome.gff3


mkdir 01.Partitioning_re
cd 01.Partitioning_re

echo "/01_software/EVidenceModeler-1.1.1/EvmUtils/partition_EVM_inputs.pl --genome /repeatannotion/05.evm/sh_hap1_HiC.fasta --gene_predictions /repeatannotion/05.evm/00_envidence/all.gff --segmentSize 1000000 --overlapSize 2000 --partition_listing partitions_list.out; echo Finished" > partition.sh

#qsub -cwd -l vf=1g,num_proc=1 -binding linear:1 -P PARTER -q st.q partition.sh
cd ../

work_dir=/repeatannotion/05.evm
genome=sh_hap1_HiC.fasta
gff=all.gff
weight=weights.txt

mkdir 02.CommandSet_re
cd 02.CommandSet_re
/01_software/EVidenceModeler-1.1.1/EvmUtils/write_EVM_commands.pl --partitions ../01.Partitioning_re/partitions_list.out --genome $work_dir/$genome --gene_predictions $work_dir/$gff --weights $work_dir/$weight --output_file_name evm.out > CommandSet.sh
/bin/02.program/qsub-sge.pl --cpu 1 --lines 1 --maxjob 150 --resource "vf=1G" -q st.q -P PARTER CommandSet.sh &

cd ../
mkdir 03.recombine_EVM_partial
cd 03.recombine_EVM_partial
echo "/01_software/EVidenceModeler-1.1.1/EvmUtils/recombine_EVM_partial_outputs.pl --partitions ../01.Partitioning_re/partitions_list.out --output_file_name evm.out " > recombine_EVM_partial_output.sh
/bin/02.program/qsub-sge.pl --cpu 1 --lines 1 --maxjob 150 --resource "vf=1G" -q st.q -P PARTER recombine_EVM_partial_output.sh
cd ../


mkdir 04.Convert
cd 04.Convert

echo 'export PERL5LIB=/Software/Perl528/lib/perl5/5.28.1/:$PATH
/01_software/EVidenceModeler-1.1.1/EvmUtils/convert_EVM_outputs_to_GFF3.pl --partitions ../01.Partitioning_re/partitions_list.out --output_file_name evm.out --genome /repeatannotion/05.evm/sh_hap1_HiC.fasta ' > convert_EVM_outputs.sh

/bin/02.program/qsub-sge.pl --cpu 1 --lines 1 --maxjob 150 --resource "vf=1G" -q st.q -P PARTER convert_EVM_outputs.sh

cd ../

mkdir 05.cat_evm

find ./01.Partitioning_re -regex ".*evm.out.gff3" -exec cat {} \; > ./05.cat_evm/evm.all.gff3

mkdir 06.evalution
cd 06.evalution

export BUSCO_CONFIG_FILE="/bin/BUSCO/config/config.ini"
/share/app/python-3.4.3/bin/python /bin/BUSCO/run_BUSCO.py -i ./evm.all.pep -c 10 -o busco -m prot -l /bin/BUSCO/db/actinopterygii_odb9

