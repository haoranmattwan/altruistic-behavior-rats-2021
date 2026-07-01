# Data Codebook

## Dataset

[`Raw_data.csv`](https://osf.io/qrbzj/) is hosted in the study's [OSF project](https://osf.io/jczsv/) and is not distributed through this repository. It contains 145 session-level observations from three focal rats across seven experimental conditions. Each row is one 30-minute experimental session.

The comma-separated file uses integer values throughout. A value of `-1` means that a measure was not applicable or was not recorded for that session; it is not a behavioral count and should be treated as missing.

## Variables

| Variable | Type | Description |
| --- | --- | --- |
| `Rat` | Identifier | Focal-rat identifier (`4`, `6`, or `8`). |
| `Condition` | Integer | Experimental condition (`1`–`7`); see the condition table below. |
| `FoodAmmt` | Count | Number of sucrose pellets arranged per food-lever response. The original variable name is retained for compatibility. |
| `Social` | Count | Number of social-lever responses (social releases) during the session. `-1` in Condition 5, when the social option was unavailable. |
| `Food` | Count | Number of food-lever responses during the session. |
| `Sharing` | Count | Number of pellets shared with the partner under the study's operational definition. `-1` when not applicable. |
| `TimesShared` | Count | Number of sharing episodes recorded during the session. This measure was recorded only for a subset of later-condition sessions; `-1` otherwise. |
| `PelletsLeft` | Count | Number of pellets left unconsumed at the end of the food-access period. Recorded in Conditions 5 and 7; `-1` otherwise. |

The published analysis constructs its `CP` pellet outcome as `Food * FoodAmmt`, with `LP = PelletsLeft` and `SP = Sharing`. The maintained R and Python workflows preserve those definitions exactly. Consult the article for the conceptual distinction among pellets produced, consumed, shared, and left behind.

## Experimental conditions

| Condition | Pellets per response | Food location | Home-cage chow | Food-access period | Social option |
| ---: | ---: | --- | --- | --- | --- |
| 1 | 1 | Tray | Restricted | Not applicable | Available |
| 2 | 2 | Tray | Restricted | Not applicable | Available |
| 3 | 4 | Tray | Restricted | Not applicable | Available |
| 4 | 4 | Tray | Unrestricted | Not applicable | Available |
| 5 | 5 | Right tube | Unrestricted | 30 seconds | Unavailable |
| 6 | 5 | Right tube | Unrestricted | Until all pellets were consumed | Available |
| 7 | 5 | Right tube | Unrestricted | 30 seconds | Available |

## Operational definition of sharing

The study defined sharing as a sequence in which the focal rat produced food, left food available, and then released the partner, permitting the partner to consume the remaining food. Condition 5 had no partner present and therefore no opportunity for sharing.

## Provenance

The dataset accompanies:

> Wan, H., Kirkman, C. F., Jensen, G., & Hackenberg, T. D. (2021). Failure to find altruistic food sharing in rats. *Frontiers in Psychology, 12*, 696025. <https://doi.org/10.3389/fpsyg.2021.696025>

The data and archival electronic supplement are available from [OSF](https://osf.io/jczsv/). The peer-reviewed article is available from the [publisher](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.696025/full).
