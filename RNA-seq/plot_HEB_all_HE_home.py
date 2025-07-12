import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from brokenaxes import brokenaxes
import matplotlib.gridspec as gridspec

plt.rcParams['svg.fonttype'] = 'none'
# 手动设定组织文件顺序
files = [
    "all_HE_home_bla.count.tmp",
    "all_HE_home_bra.count.tmp",
    "all_HE_home_eye.count.tmp",
    "all_HE_home_gill.count.tmp",
    "all_HE_home_heart.count.tmp",
    "all_HE_home_int.count.tmp",
    "all_HE_home_key.count.tmp",
    "all_HE_home_liver.count.tmp",
    "all_HE_home_mus.count.tmp",
    "all_HE_home_skin.count.tmp"
]

# 设置颜色
colors = {"SubA": "#8b92bd", "SubB": "#fc7444", "None": "gray"}

# 创建主图和布局
fig = plt.figure(figsize=(20, 8))
gs = gridspec.GridSpec(2, 5, figure=fig, wspace=0.1, hspace=0.2)

# 保存 brokenaxes 对象以便后处理
broken_axes_list = []

for i, file in enumerate(files):
    row, col = divmod(i, 5)

    # 创建断轴子图
    ax = brokenaxes(ylims=((0, 50), (70, 180)),
                    despine=False, hspace=0.05, d=0.001,
                    subplot_spec=gs[row, col],
                    height_ratios=(1, 6)) 
    broken_axes_list.append(ax)

    # 读取数据
    df = pd.read_csv(file, sep="\t")
    df.columns = df.columns.str.strip()

    # 平均表达 & log2FC
    df['subA_mean'] = df[['subA_rep1', 'subA_rep2', 'subA_rep3']].mean(axis=1)
    df['subB_mean'] = df[['subB_rep1', 'subB_rep2', 'subB_rep3']].mean(axis=1)
    df['log2FC'] = np.log2((df['subA_mean'] + 1) / (df['subB_mean'] + 1))

    # 分类偏倚
    df['bias'] = df['log2FC'].apply(lambda x: 'SubA' if x > 2 else ('SubB' if x < -2 else 'None'))

    # 统计
    subA_count = (df['bias'] == 'SubA').sum()
    subB_count = (df['bias'] == 'SubB').sum()
    total_count = len(df)
    overall_bias = df['log2FC'].mean()
    subA_bias = df[df['bias'] == 'SubA']['log2FC'].mean() if subA_count else 0
    subB_bias = df[df['bias'] == 'SubB']['log2FC'].mean() if subB_count else 0

    # 绘图
    bins = np.linspace(-8, 8, 80)
    for label in ['None', 'SubA', 'SubB']:
        subset = df[df['bias'] == label]
        ax.hist(subset['log2FC'], bins=bins, color=colors[label], alpha=0.8 if label != 'None' else 0.5)
    
    # 标题与坐标轴
    #ax.axs[1].set_xticks([-5, 0, 5]) 
    #ax.set_xticks([-5, 0, 5])
    tissue = file.replace("no_HE_homo_", "").replace(".count.tmp", "")
    ax.set_title(tissue, fontsize=10)
    ax.axs[1].set_xticks([-5, 0, 5])
    ax.axs[1].set_xticklabels(['-5', '0', '5'])
    #ax.set_xlabel("Non-HE-related homoeologs Log2(TPM_A+1/TPM_B+1)", fontsize=8)
    #ax.set_ylabel("Count", fontsize=8)
    ax.tick_params(labelsize=8)

    # 文本注释（在下轴 axs[1] 添加）
    ax.axs[1].text(0.75, 0.80, f"All pairs\nN={total_count}\nBias={overall_bias:.3f}",
                   transform=ax.axs[1].transAxes, ha='right', va='top', fontsize=7)
    ax.axs[1].text(0.15, 0.325, f"SubB\nN={subB_count}\nBias={subB_bias:.3f}",
                   transform=ax.axs[1].transAxes, ha='left', va='top', fontsize=7)
    ax.axs[1].text(0.85, 0.20, f"SubA\nN={subA_count}\nBias={subA_bias:.3f}",
                   transform=ax.axs[1].transAxes, ha='right', va='bottom', fontsize=7)

# 设置统一 y 轴刻度，只有第一个子图显示标签
for i, ax in enumerate(broken_axes_list):
    ax.axs[0].set_yticks([180])
    ax.axs[1].set_yticks([0, 20, 40])

    #if i != 0:
    if i in [0, 5]:
        continue
    elif i in [1, 2, 3, 4, 6, 7, 8, 9]:
        # 其余子图显示刻度线但不显示数值
        ax.axs[0].set_yticklabels([])
        ax.axs[1].set_yticklabels([])
        ax.axs[0].tick_params(left=True, labelleft=False)  # 只显示刻度线
        ax.axs[1].tick_params(left=True, labelleft=False)

        #ax.axs[0].set_yticklabels([])
        #ax.axs[1].set_yticklabels([])
        #ax.axs[0].tick_params(left=False)
        #ax.axs[1].tick_params(left=False)

# 添加图例
handles = [plt.Rectangle((0, 0), 1, 1, color=colors[k]) for k in ['SubA', 'SubB', 'None']]
labels = ['SubA Biased', 'SubB Biased', 'Unbiased']
fig.legend(handles, labels, loc='upper center', ncol=3, fontsize=10)
fig.text(0.5, 0.04, "Non-HE-related homoeologs Log2(TPM_A+1 / TPM_B+1)", ha='center', fontsize=10)
fig.text(0.06, 0.5, "Count", va='center', rotation='vertical', fontsize=10)

# 调整布局并保存
#plt.subplots_adjust(left=0.06, right=0.98, top=0.9, bottom=0.08, wspace=0.3, hspace=0.4)
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.savefig("HEB_10_tissues_HE_brokenaxes.pdf", dpi=300)
plt.savefig("HEB_10_tissues_HE_brokenaxes.png", dpi=300)
plt.savefig("HEB_10_tissues_HE_brokenaxes.svg", dpi=300)
plt.show()

