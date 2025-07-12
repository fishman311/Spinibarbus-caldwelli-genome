#fastp
for i in $(cat pair.txt); do fastp -i ${i}_1.fq.gz -o ${i}_1.clean.fq.gz -I ${i}_2.fq.gz -O ${i}_2.clean.fq.gz -w 16 & done

#hisat2
for i in $(cat pair.txt); do hisat2 -p 10 -x /sh_RNA/02.cleanreads/Sh --dta -1 ${i}_1.clean.fq.gz -2 ${i}_2.clean.fq.gz --known-splicesite-infile /sh_RNA/02.cleanreads/Sho_splice_sites.txt -t --no-unal | samtools sort -@ 28 > ${i}.bam & done

#htseq
#!/bin/bash

bam_list=(
1bla 1bra 1eye 1fin 1gill 1heart 1int 1key 1liver 1mus 1skin
2bla 2bra 2eye 2fin 2gill 2heart 2key 2liver 2mus 2skin
3bra 3eye 3gill 3heart 3int 3liver 3mus 3skin
4bla 4int 4key
)

for sample in "${bam_list[@]}"; do
  htseq-count -m intersection-nonempty -n 20 -s no -t gene -i ID "${sample}.bam" /sh_RNA/02.cleanreads/Sho.gff > "${sample}.count" &
done

wait


#Count2TPM
perl countTPM.pl length countfile outfile



