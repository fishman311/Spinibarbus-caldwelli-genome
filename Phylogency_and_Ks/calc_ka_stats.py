import sys
import statistics

# 读取输入文件
input_file = sys.argv[1]
with open(input_file) as f:
    data = [line.strip().split('\t') for line in f]

# 计算每个染色体的ka平均值、中值和标准差
chromosomes = set([row[0] for row in data])
results = []
for chromosome in chromosomes:
    kas = [float(row[1]) for row in data if row[0] == chromosome]
    mean = statistics.mean(kas)
    median = statistics.median(kas)
    stdev = statistics.stdev(kas)
    results.append([chromosome, mean, median, stdev])

# 输出结果
for row in results:
    print('\t'.join([str(val) for val in row]))

