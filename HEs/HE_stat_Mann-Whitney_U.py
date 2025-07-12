import pandas as pd
from scipy.stats import mannwhitneyu
from itertools import combinations

def perform_mann_whitney_test(file_path):
    df = pd.read_csv(file_path, sep='\\t')

    groups = [df.iloc[:, i].dropna() for i in range(4)]  # Four groups in four columns

    test_results = {}
    for (i, group1), (j, group2) in combinations(enumerate(groups), 2):
        test_name = f'Group{i+1}_vs_Group{j+1}'
        test_results[test_name] = mannwhitneyu(group1, group2, alternative='two-sided')

    return test_results

if __name__ == '__main__':
    file_path = 'HE_1.identify'  # Replace with your file path
    results = perform_mann_whitney_test(file_path)
    for test, result in results.items():
        print(f'{test}: U-Statistic={result.statistic}, p-value={result.pvalue}')

