less ../homo.cover.ks | awk '$1~/SHA05/' | awk '$6~/SHB05/' | sort -k3n | head -n 137 | awk '{print$12}' > chr5.ks
less ../homo.cover.ks | awk '$1~/SHA09/' | awk '$6~/SHB09/' | sort -k3n | head -n 44 | awk '{print$12}' > chr9.ks
less ../homo.cover.ks | awk '$1~/SHA16/' | awk '$6~/SHB16/' | sort -k3n | head -n 60 | awk '{print$12}' > chr16.ks
less ../homo.cover.ks | awk '$1~/SHA17/' | awk '$6~/SHB17/' | awk '$4>=24512341' |  sort -k4 | head -n 73 | awk '{print$12}' > chr17_b2a.ks
less ../homo.cover.ks | awk '$1~/SHA17/' | awk '$6~/SHB17/' | awk '$4>=24512341' |  sort -k4 | tail -n 104 | awk '{print$12}' > chr17_a2b.ks
paste -d "\t" all_chr.ks chr5.ks chr17_a2b.ks chr16.ks chr9.ks > he.ks
 python ks_plot_4.py

