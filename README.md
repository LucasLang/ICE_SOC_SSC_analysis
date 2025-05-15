This is the Snakemake workflow for reproducing the calculations and data analysis of our paper

**Treating Spin–Orbit Coupling and Spin–Spin Coupling in the Framework of the Iterative Configuration Expansion Selected CI**

In order to run the workflow, you need to have [Julia](https://julialang.org/) with the [OutputParser.jl](https://github.com/LucasLang/OutputParser.jl) package installed.
Furthermore, you need [Snakemake](https://snakemake.readthedocs.io) in your path.

Once you have Julia, you can install `OutputParser.jl` via starting the Julia REPL by typing `julia` in a terminal, then entering Pkg mode by pressing the `]` key and entering the following command:
- `add https://github.com/LucasLang/OutputParser.jl`

In order to install Snakemake, you can e.g. enter the following commands (requires conda, e.g. through a [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://docs.anaconda.com/free/anaconda/install/) installation):
```bash
conda config --set channel_priority strict
conda create --name snakemake python=3.11
conda activate snakemake
conda install -c conda-forge -c bioconda snakemake
```

Usage:
```bash
cd workflow
snakemake -c1 --use-conda --conda-frontend conda
```
