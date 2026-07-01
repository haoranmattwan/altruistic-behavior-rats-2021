# Failure to Find Altruistic Food Sharing in Rats

[![DOI](https://img.shields.io/badge/DOI-10.3389%2Ffpsyg.2021.696025-0b7285)](https://doi.org/10.3389/fpsyg.2021.696025)
[![Open access](https://img.shields.io/badge/article-CC%20BY%204.0-2b8a3e)](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.696025/full)
[![Code license](https://img.shields.io/badge/code-MIT-5c677d)](LICENSE)

This repository is the research compendium for:

> Wan, H., Kirkman, C. F., Jensen, G., & Hackenberg, T. D. (2021). Failure to find altruistic food sharing in rats. *Frontiers in Psychology, 12*, 696025. <https://doi.org/10.3389/fpsyg.2021.696025>

It brings together the study data, Bayesian models, reproducibility workflows, figures, and representative trial videos. The version of record and its peer-reviewed supplementary materials remain available from the [journal article](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.696025/full#supplementary-material).

## Study at a glance

**Question.** Will rats leave high-value food available for a familiar partner when food quantity, food motivation, and access conditions are varied?

**Design.** Three focal rats made repeated choices between sucrose pellets and 30 seconds of social access to a cagemate across seven experimental conditions. The analyses use Bayesian multilevel generalized linear models to estimate food-versus-social choice, response rates, and pellet allocation.

**Finding.** Rats responded for both food and social access, but food sharing was rare. Sharing occurred on approximately 1% of available opportunities, including under low food-motivation conditions. These findings did not support the claim that rats were motivated to share food altruistically under the tested conditions.

## Open materials

| Resource | Description |
| --- | --- |
| [Published article](https://doi.org/10.3389/fpsyg.2021.696025) | Open-access version of record in *Frontiers in Psychology* |
| [`Analysis/Raw_data.csv`](Analysis/Raw_data.csv) | Session-level analysis dataset (145 observations) |
| [`CODEBOOK.md`](CODEBOOK.md) | Variables, condition definitions, and missing-value conventions |
| [`Analysis/Analysis_R.qmd`](Analysis/Analysis_R.qmd) | Annotated R and CmdStan workflow |
| [`Analysis/Analysis_py.ipynb`](Analysis/Analysis_py.ipynb) | Annotated Python and CmdStanPy workflow |
| [`Analysis/archive/published-2021/`](Analysis/archive/published-2021/) | Checksummed, unmodified published analysis source |
| [`config/cmdstan-version.txt`](config/cmdstan-version.txt) | Pinned CmdStan version shared by both workflows |
| [`figures/`](figures/) | Publication figures and source files |
| [`video/`](video/) | Representative food-choice and social-release trials |
| [`CITATION.cff`](CITATION.cff) | Machine-readable citation metadata |

The maintained workflows use modern CmdStan interfaces while retaining the published variables, priors, likelihoods, and sampling configuration. The repository also preserves checksummed copies of the original analysis source; the publisher's copies remain available in the journal's [supplementary materials](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.696025/full#supplementary-material).

## Reproduce the analyses

The setup commands below should be run from the repository root. Compiling the Stan models requires a working C++ toolchain. Both workflows enforce the CmdStan version recorded in `config/cmdstan-version.txt`, use fixed model-specific seeds, and report divergences, maximum-treedepth events, E-BFMI, R-hat, and effective sample sizes. Sampling uses four parallel chains and 24,000 total iterations per model (including warmup), so a complete run can be computationally intensive.

### R

The R environment is recorded in [`renv.lock`](renv.lock) (R 4.4.1).

```r
install.packages("renv")
renv::restore()
cmdstan_version <- trimws(readLines("config/cmdstan-version.txt"))
cmdstanr::install_cmdstan(version = cmdstan_version)
```

Then open `Analysis/Analysis_R.qmd` in RStudio or render it with Quarto from the `Analysis/` directory.

### Python

The Python dependencies are pinned in [`requirements.txt`](requirements.txt).

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt jupyterlab
python -c 'from cmdstanpy import install_cmdstan; install_cmdstan(version=open("config/cmdstan-version.txt").read().strip())'
jupyter lab Analysis/Analysis_py.ipynb
```

The final command can be run from the repository root. If the notebook is opened another way, set its working directory to `Analysis/` before execution.

## Repository structure

```text
.
├── Analysis/           # Data, maintained workflows, Stan models, source archives
├── config/             # Pinned computational-tool versions
├── figures/            # Figure PDFs and editable source files
├── presentation/       # Conference posters, slides, and abstracts
├── video/              # Representative experimental trials
├── CITATION.cff        # Citation metadata
├── CODEBOOK.md         # Dataset documentation
├── LICENSE             # License for repository code
├── renv.lock           # Locked R environment
└── requirements.txt    # Locked Python dependencies
```

## Research transparency

- **Data availability:** The analysis data are included in this repository and in the article's supplementary materials.
- **Ethics:** The animal study was reviewed and approved by the Reed College Institutional Care and Use Committee.
- **Funding:** Reed College Summer Scholarship Funds supported the research.
- **Conflicts of interest:** The authors reported no commercial or financial relationships that could be construed as a potential conflict of interest.
- **Scope:** This repository documents a completed, published study. Corrections that improve reproducibility or documentation are welcome through GitHub issues.

## Citation and reuse

Please cite the article above when using these materials. Citation metadata are available in [`CITATION.cff`](CITATION.cff) and through GitHub's **Cite this repository** menu.

Repository code is available under the [MIT License](LICENSE). The published article is distributed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Article content, third-party materials, and publisher-hosted supplementary files retain their stated licenses; the MIT license does not override those terms.
