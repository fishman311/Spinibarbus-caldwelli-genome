from ete3 import Tree
import argparse

parser = argparse.ArgumentParser(description='Prune tree based on species list.')
parser.add_argument('-i', '--input', type=str, help='Input species list file')
parser.add_argument('-o', '--output', type=str, help='Output pruned tree file')
args = parser.parse_args()

selected_species = []
with open(args.input, "r") as file:
    for line in file:
        species_name = line.strip()
        selected_species.append(species_name)

t = Tree('tree.nwk')

t.prune(selected_species)

t.write(outfile=args.output)

with open(args.output, "r") as file:
    content = file.read()

content = content.replace("1", "").replace(":", "")

with open(args.output, "w") as file:
    file.write(content)
