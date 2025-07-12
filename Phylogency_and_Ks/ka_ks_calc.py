import sys
import statistics

filename = sys.argv[1]
data = {}
with open(filename, 'r') as f:
    for line in f:
        line = line.strip().split()
        chrom = line[0]
        ka = float(line[1])
        ks = float(line[2])
        kaks = float(line[3])
        if chrom not in data:
            data[chrom] = []
        data[chrom].append((ka, ks, kaks))

results = []
for chrom in data:
    kavals = [x[0] for x in data[chrom]]
    ksvals = [x[1] for x in data[chrom]]
    kaksvals = [x[2] for x in data[chrom]]
    row = [
        chrom,
        statistics.mean(kavals),
        statistics.median(kavals),
        statistics.stdev(kavals),
        statistics.mean(ksvals),
        statistics.median(ksvals),
        statistics.stdev(ksvals),
        statistics.mean(kaksvals),
        statistics.median(kaksvals),
        statistics.stdev(kaksvals)
    ]
    results.append(row)

header = [
    'chrom',
    'ka_mean', 'ka_median', 'ka_stdev',
    'ks_mean', 'ks_median', 'ks_stdev',
    'kaks_mean', 'kaks_median', 'kaks_stdev'
]
print('\t'.join(header))
for row in results:
    print('\t'.join(str(x) for x in row))

