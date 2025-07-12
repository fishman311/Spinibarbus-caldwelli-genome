export PATH=/mnt/lfj/soft/OrthoFinder:$PATH
export PATH=/mnt/lfj/soft/OrthoFinder/bin:$PATH
orthofinder -f ../00.pep/ -S diamond -s tree -t 100 -M msa


less N0.GeneCount.csv | awk '{valid=1; for (i=4; i<=21; i++) {if ($i != 0 && $i != 1) {valid=0; break}} if (valid) print}' | awk '$9==1' | awk -F'\t' '{sum1 = $4 + $5 + $6 + $7 + $10 + $11 + $16 + $17 + $18 + $19 + $20 + $21}
             {sum2 = $8 + $9 + $12 + $13 + $14 + $15}
             {if (sum1 >= 4 && sum2 >=5) print}' | awk '($4 + $5 >= 1) && ($6 + $7 >= 1) && ($10 + $11 >= 1) && ($16 + $17 >= 1) && ($18 + $19 >= 1) && ($20 + $21 >= 1)' | cut -f1 > N0.GeneCount.filter_2.group.id
grep -Fwf N0.GeneCount.filter_2.group.id N0.tsv > tmp_2.txt
../generate_files.sh
#!/bin/bash

while IFS=$'\t' read -r filename col2 col3 id4 id5 id6 id7 id8 id9 id10 id11 id12 id13 id14 id15 id16 id17 id18 id19 id20 id21; do
    echo -e "$id4\n$id5\n$id6\n$id7\n$id8\n$id9\n$id10\n$id11\n$id12\n$id13\n$id14\n$id15\n$id16\n$id17\n$id18\n$id19\n$id20\n$id21" > "$filename"
done < tmp_2.txt


find . -type f -exec sed -i '/^$/d' {} +
for i in N0.*; do seqkit grep -f $i ../../../../../merge.pep > $i.pep & done
for i in *.pep; do mafft $i > $i.mafft & done
sed -i '/^>/ s/^\(....\).*/\1/'

for file in *.out; do echo -e "$(basename "$file" .out)\t$(head -n 1 "$file")"; done > paml_out.txt
less paml_out.txt | grep -v 'nan' > paml_out_filted.txt

grep 'dre' * | sed 's/:/\t/g' | sed 's/dre_//g' |  sort >  ../group_dre.txt
awk 'NR==FNR{a[$1]=$2; next} {$3=a[$2]} 1'  /backup/lfj/genome/zebrafish/pr_id2gene_name group_dre.txt | sed 's/ /\t/g' > group_dre_name.txt
awk 'NR==FNR{a[$1]=$3; next} {$1=a[$1]} 1'  group_dre_name.txt 07.paml_out/paml_out_filted.txt > paml_out_filted_for_TRACCER.txt


for i in *.pep; do mafft $i > $i.mafft & done
/mnt/lfj/soft/paml-4.10.7/bin/baseml baseml.ctl
less ../07.paml_out/paml_out_filted.txt | sed 's/\t/\n/g' | awk 'NR%2==1 {print ">" $0} NR%2==0 {print}' > a.tmp
python /mnt/lfj/soft/TRACCER/TRACCER.py --mastertree=tree.txt --gtrees=a.tmp --outgroup=oma,phu,lro,cer,pgu,dre --hastrait=lca,lcb,ssb,shb,prb,ccb,cab,ssa,sha,pra,caa,cca
python /mnt/lfj/soft/TRACCER/TRACCER.py --mastertree=tree.txt --gtrees=a.tmp --outgroup=dre --hastrait=lca,lcb,ssb,shb,prb,ccb,cab,ssa,sha,pra,caa,cca --outname dre_outgroup_random_control

awk 'NR==FNR{a[$1]=$3; next} {$1=a[$1]} 1' OFS='\t'  ../group_dre_name.txt dre_outgroup.TRACCER.txt

