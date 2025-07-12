export PATH=/mnt/soft/blast-2.13.0/bin:$PATH
makeblastdb -dbtype prot -in dr.pep
blastp -db dr.pep -query SHA.pep -evalue 1e-5 -num_threads 40 -outfmt 6 -out sha_dr.blast
/mnt/lfj/soft/MCScanX-master/MCScanX sha_dr -s 5 -m 5 
reciprologs -p 20 dr.pep SHA.pep diamondp -o rbh.txt
