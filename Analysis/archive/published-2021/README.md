# Published Analysis Archive

This directory preserves byte-for-byte copies of the analysis source files distributed with Wan et al. (2021). They are retained as an immutable scientific reference and are not intended for direct editing.

Source publication:

> Wan, H., Kirkman, C. F., Jensen, G., & Hackenberg, T. D. (2021). Failure to find altruistic food sharing in rats. *Frontiers in Psychology, 12*, 696025. <https://doi.org/10.3389/fpsyg.2021.696025>

| File | SHA-256 |
| --- | --- |
| `SharingStanMultilevelAnalysis.R` | `35fb46776986168a738a9020e9e41dd7a61dbcba865ac568bc855de68b6cf6e5` |
| `pair_multilevel_model.stan` | `a700adea0b70974bb1920c93e19b0632160bc81d2ea367325745e0df919a6218` |
| `resp_rate_multilevel_model.stan` | `746b7a6a9a98c8b9e7fc8fb74a4b0963ee314077a053adaa72857ad84600b5c6` |
| `intake_multilevel_model.stan` | `83e665cb4ddecc797a73fe62751964ef7d8769d3219691e7afb1568967da48cd` |

The maintained R and Python workflows in the parent `Analysis/` directory use modern CmdStan interfaces while retaining the published variables, priors, likelihoods, and sampling configuration.
