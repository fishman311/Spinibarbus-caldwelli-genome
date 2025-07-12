lastz Sho_A05.fa Sho_B05.fa --chain --format=general:name1,strand1,start1,end1,name2,strand2,start2,end2,identity,coverage --ambiguous=iupac > chr5.txt
lastz Sho_A09.fa Sho_B09.fa --chain --format=general:name1,strand1,start1,end1,name2,strand2,start2,end2,identity,coverage --ambiguous=iupac > chr9.txt
lastz Sho_A16.fa Sho_B16.fa --chain --format=general:name1,strand1,start1,end1,name2,strand2,start2,end2,identity,coverage --ambiguous=iupac > chr16.txt
lastz Sho_A17.fa Sho_B17.fa --chain --format=general:name1,strand1,start1,end1,name2,strand2,start2,end2,identity,coverage --ambiguous=iupac > chr17.txt

less chr17.txt | sort -k3n | awk '$4>27205126' | cut -f10 > chr17_he.identify
less chr16.txt | head -n 1114 | cut -f10 > chr16_he.identify
less chr9.txt | sort -k3n | head -n 873 | cut -f10 > chr9_he.identify
less chr5.txt | sort -k3n  | head -n 307 | cut -f10  >  chr5_he.identify

paste -d "\t" chr16_he.identify chr9_he.identify chr17_he.identify chr5_he.identify > HE.identify

