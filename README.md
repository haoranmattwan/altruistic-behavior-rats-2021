# Analysis and Materials for "Failure to Find Altruistic Food Sharing in Rats" (Wan et al., 2021)

This repository contains the analysis scripts, figures, and supporting materials for the peer-reviewed publication:

> Wan, H., Kirkman, C. F., Jensen, G., & Hackenberg, T. D. (2021). Failure to find altruistic food sharing in rats. *Frontiers in Psychology*, *12*, Article 696025. https://doi.org/10.3389/fpsyg.2021.696025

The project's primary goal was to systematically examine the conditions under which a rat might share food with a partner, testing claims of altruism in prior literature.

The raw data for this study is available in the Supplementary Material of the original publication, which can be accessed at the publisher's website: <https://www.frontiersin.org/articles/10.3389/fpsyg.2021.696025/full#supplementary-material>.

------------------------------------------------------------------------

## Repository Contents

This repository is organized into the following components:

-   **`/figures`**: This directory contains the analysis scripts written in **R** using a Quarto document format (`analysis.qmd`) and in **Python** Jupyter Notebook that serves as a direct counterpart to the R analysis. It contains the complete workflow for running the three hierarchical Bayesian models in Stan via the `cmdstanr` interface.

-   **`/figures`**: This directory contains the figures generated for the manuscript.

-   **`/presentation`**: This directory contains a conference poster that summarizes the research study.

-   **`/video`**: This directory contains videos from two representative trials during experiments.

------------------------------------------------------------------------

## Methodology Snapshot

The statistical analyses were conducted using multilevel generalized linear models implemented in the Stan programming language. This Bayesian approach was used to model three distinct behavioral outcomes:

1.  **Food vs. Social Choice**: A hierarchical binomial logistic regression was used to model the proportion of choices made between food and a social partner.
2.  **Response Rates**: A hierarchical negative binomial regression was implemented to model the absolute rates of food and social choices, accounting for overdispersion in the count data.
3.  **Food Intake**: A second hierarchical negative binomial regression was used to model the number of pellets consumed, shared, or left behind.

------------------------------------------------------------------------

## How to Run the Code

To execute the analysis scripts, you will need the appropriate environment and the data file downloaded from the journal's supplementary materials.

### R Environment (`analysis.qmd`)

1.  **Required Packages**: `cmdstanr` and `readr`.
2.  **Installation**: `R     install.packages(c("cmdstanr", "readr"))     cmdstanr::install_cmdstan()`

### Python Environment (`analysis.ipynb`)

1.  **Required Packages**: `cmdstanpy` and `pandas`.
2.  **Installation**: `bash     pip install cmdstanpy pandas` Then, run the following in Python to install the Stan backend: `python     import cmdstanpy     cmdstanpy.install_cmdstan()`