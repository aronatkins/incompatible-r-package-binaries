options(repos = list(CRAN = "https://packagemanager.rstudio.com/all/2021-11-30+Y3JhbjoyMDIxLTExLTI5LDI6NDUyNjIxNTs2RTAyODg4Mw"))

# force a lower rcpp.
renv::install("Rcpp@1.0.6")
# version before rcpp-1.0.7 requirement
renv::install("httpuv@1.6.2")

renv::snapshot(prompt = FALSE)
