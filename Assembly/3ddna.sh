export PATH=/home/lfj/lastz-1.03.73/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/java/jdk-11.0.1/bin:$PATH
export PYTHONPATH=/soft/conda/lib/python3.9/site-packages/
mkdir tmp
export JAVA_TOOL_OPTIONS="-Djava.io.tmpdir=/hap1_juicer/03.3ddna/tmp -XX:ParallelGCThreads=10"
export TMPDIR=/hap1_juicer/03.3ddna/tmp
/soft/3d-dna-201008/run-asm-pipeline.sh -m haploid -r 1 sh_hap1.fa merged_nodups.txt 
