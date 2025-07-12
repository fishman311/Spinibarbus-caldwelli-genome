import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
from scipy.signal import find_peaks

data = pd.read_csv('he.ks', sep='\t')

plt.figure(figsize=(8, 6))
colors = ['#1663A9', '#C75C46', '#48C0BF', '#D3E1AE', '#E83133']
#peak_annotations = []
for i, column in enumerate(data.columns):
    if column == 'header':
        continue
    values = data[column]
    density = sns.kdeplot(values, color=colors[i], label=column)
    peaks, _ = find_peaks(density.get_lines()[i].get_ydata())
#   print(f"Peaks for {column}:")
    if len(peaks) > 0:
        peak = peaks[0]
        x = density.get_lines()[i].get_xdata()[peak]
        y = density.get_lines()[i].get_ydata()[peak]
#       print(f"({x:.4f}")
#       peak_annotations = sorted(peak_annotations, key=lambda x: x[1])
        plt.annotate(f'{x:.4f}', xy=(x, y), xytext=(x, y+0.01),
                     arrowprops=dict(arrowstyle='->', lw=1))
plt.xlabel('Synonymous substitution rate (Ks)')
plt.ylabel('Perventage of gene pairs')
plt.legend()
plt.xlim(0, 0.4)
plt.title('KS Value Density Curve')
plt.savefig('HE.svg')











