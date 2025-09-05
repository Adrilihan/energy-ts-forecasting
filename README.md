# Time Series Modelling of Energy Consumption Data

This project was developed as part of the Time Series curriculum unit,
taught by Professor Isabel Pereira. The objective was to implement and evaluate
classical time series models on a real-world dataset. For this, we selected
hourly energy consumption data from the municipality of
Aveiro for the year 2023, provided by E-REDES[^1].

The models that were initially implemented were SARIMA, GARCH, and
Holt-Winters (Exponential Smoothing). However, after unsatisfactory results,
it was concluded that something was missing from our analysis. Later on, we
realized that the assumption of only one seasonality in the data was
incorrect. Due to the high-frequency sampling, multiple seasonal patterns were
present—daily (day and night), monthly (weekdays and weekends), and even yearly
(seasons)—which the previous models could not adequately capture.

Because of this, other methods were explored and the *Prophet* model was
found[^2][^3]. It corroborated the presence of multiple seasonalities and, in
addition, improved the modeling.

<p align="center">
  <img 
    style="width: 50%;
           height: 50%;"
    src="https://github.com/user-attachments/assets/909b0524-72da-466f-aa9a-b0e7e15e970a" 
    alt="Prophet multiple seasonality decomposition.">
</p>

Yet, as the curriculum unit focused on classical time series models, we searched
for a way to incorporate multiple seasonalities into those models. We found that
it was possible to use exogenous variables to explain the volatility, which we
chose to model using Fourier series[^4]. This approach yielded the best results.

<p align="center">
  <img 
    style="width: 50%;
           height: 50%;"
    src="https://github.com/user-attachments/assets/4e126e78-058a-4cea-85d5-fdf8562ba68e" 
    alt="ARIMA with Fourier regressors forecast.">
</p>

The full RMarkdown file is `aveiro-consumo-energia.Rmd`, but note that it is
written in **Portuguese**.

## Data sources

- [Energy consumption in the Aveiro municipality for the year 2023](https://e-redes.opendatasoft.com/explore/dataset/consumos_horario_codigo_postal/table/?sort=datahora&refine.codigo_postal=3810&refine.datahora=2023&dataChart=eyJxdWVyaWVzIjpbeyJjaGFydHMiOlt7InR5cGUiOiJsaW5lIiwiZnVuYyI6IlNVTSIsInlBeGlzIjoiY29uc3VtbyIsInNjaWVudGlmaWNEaXNwbGF5Ijp0cnVlLCJjb2xvciI6IiNGRkRDMDAifV0sInhBeGlzIjoiZGF0YWhvcmEiLCJtYXhwb2ludHMiOm51bGwsInRpbWVzY2FsZSI6ImhvdXIiLCJzb3J0IjoiIiwiY29uZmlnIjp7ImRhdGFzZXQiOiJjb25zdW1vc19ob3JhcmlvX2NvZGlnb19wb3N0YWwiLCJvcHRpb25zIjp7InNvcnQiOiJkYXRhaG9yYSIsInJlZmluZS5jb2RpZ29fcG9zdGFsIjoiMzgxMCIsInJlZmluZS5kYXRhaG9yYSI6IjIwMjMifX19XSwiZGlzcGxheUxlZ2VuZCI6dHJ1ZSwiYWxpZ25Nb250aCI6dHJ1ZSwidGltZXNjYWxlIjoiIn0%3D)

Export the selected records as Excel `.xlsx` format.

## References

[^1]: E-REDES – Distribuição de Eletricidade. (n.d.). *E-REDES Open Data Portal*. https://e-redes.opendatasoft.com/pages/homepage/

[^2]: PBR Notes on DS. (2022, October 29). *DS Projects: 4c Hourly Energy Data Time Series Analysis* [Video]. YouTube. https://www.youtube.com/watch?v=m9nzK1SNY3I

[^3]: Taylor, S. J., & Letham, B. (2017). Forecasting at scale. *PeerJ Preprints*, 5, e3190v2. https://doi.org/10.7287/peerj.preprints.3190v2


[^4]: Hyndman, R. J., & Athanasopoulos, G. (2021). *Forecasting: Principles and Practice* (3rd ed.). OTexts. https://otexts.com/fpp3/
