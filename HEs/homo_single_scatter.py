import argparse
import matplotlib.pyplot as plt
import pandas as pd
import glob

parser = argparse.ArgumentParser(description='Plot scatter plot from input file')

parser.add_argument('-i', '--input', type=str, help='Input file name')
parser.add_argument('-o', '--output', type=str, help='Output file name')

args = parser.parse_args()

df = pd.read_csv(args.input, header=None, delim_whitespace=True)

data = df.iloc[:, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]]

fig, ax = plt.subplots()
ax.scatter(data.iloc[:, 2], data.iloc[:, 3], s=1.5, color=(1, 0.25, 0.6),marker='^',label='B8_I')
ax.scatter(data.iloc[:, 10], data.iloc[:, 11], s=0.5, color=(1, 0.75, 0.8), label='B8_S')
ax.scatter(data.iloc[:, 6], data.iloc[:, 7], s=0.5, color=(1, 0.5, 0.7), label='B8_H')
ax.scatter(data.iloc[:, 0], data.iloc[:, 1], s=1.5, color=(0.308, 0.143, 0.555),marker='^',label='A8_I')
ax.scatter(data.iloc[:, 8], data.iloc[:, 9], s=0.5, color=(0.708, 0.543, 0.955), label='A8_S')
ax.scatter(data.iloc[:, 4], data.iloc[:, 5], s=0.5, color=(0.408, 0.243, 0.655), label='A8_H')

handles, labels = ax.get_legend_handles_labels()
leg1 = ax.legend(handles[:3], labels[:3], loc="upper right", bbox_to_anchor=(1.22, 0.9),labelspacing=1)
leg2 = ax.legend(handles[3:], labels[3:], loc="lower right", bbox_to_anchor=(1.22, 0.1),labelspacing=1)
ax.add_artist(leg1)

plt.savefig(args.output + ".pdf", dpi=300, bbox_inches="tight")

