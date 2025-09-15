# GrowthGuard

GrowthGuard is an open-source Shiny app from Causalytics Impact that helps caregivers and clinicians visualize child growth using CDC–WHO standards. The app runs entirely without server-side data storage and supports English and Spanish.

Repo: https://github.com/aakbarie/GrowthGuard

## Features

- Personalized growth charts: Weight-for-age and Height-for-age, using CDC–WHO datasets
- Bilingual UI: English and Spanish with dynamic switching
- Privacy-first: No server-side data storage; processing happens in-session
- Easy exports: Download CSV (inputs) and PDF (chart)
- Clear medical disclaimers (educational use only)

## Quick Start

1) Clone the repository

```bash
git clone https://github.com/aakbarie/GrowthGuard.git
cd GrowthGuard
```

2) Install dependencies (R 4.2+ recommended)

```r
install.packages(c(
  "shiny", "shinydashboard", "shinyWidgets",
  "tidyverse", "lubridate", "shinyjs", "markdown",
  "shinycssloaders"
))
```

3) Run locally

```r
shiny::runApp()
```

## Deploy to shinyapps.io

```r
install.packages("rsconnect")
rsconnect::setAccountInfo(name = "YOUR_NAME", token = "YOUR_TOKEN", secret = "YOUR_SECRET")
rsconnect::deployApp(appDir = ".", appName = "growthguard", account = "YOUR_NAME")
```

Use `rsconnect::showLogs(..., streaming = TRUE)` to tail logs if needed.

## Project Structure

```
R/                # App logic and helpers
  MygrowthFun.R   # Orchestrates plot generation; sources grafici*.R
  Posts/Growth/   # Plot scripts + .rda data used by grafici*.R
www/              # Static assets (CSS, images)
content/          # Markdown content (About, Medical Info) in en/es
app.R             # UI + server
translations.R    # i18n dictionary (en/es)
global.R          # age() helpers
```

## Medical Disclaimer (Important)

This tool is for informational and educational purposes only and is not a medical device. It does not diagnose, treat, cure, or prevent any condition. Always consult a qualified healthcare professional for medical advice.

## Data Sources and Attribution

- CDC Growth Charts (2000)
- WHO Growth Standards (2006)

Confirm redistribution rights for datasets before publishing modified versions. If redistribution is restricted, provide scripts to regenerate `.rda` files from public sources rather than committing the binaries.

## Contributing

Contributions are welcome! Open issues/PRs for bugs or enhancements. Please keep PRs focused and include a brief rationale.

## License

MIT © Causalytics Impact — see [LICENSE](LICENSE).

## Contact

https://causalyticsimpact.com/

For questions: open a GitHub issue or contact the maintainers.
