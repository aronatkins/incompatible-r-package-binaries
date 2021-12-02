options(repos = list(CRAN = "https://packagemanager.rstudio.com/all/2021-09-01+Y3JhbjoyMDIxLTA4LTMxLDI6NDUyNjIxNTs3Rjc5MTcxQw"))

# force a lower rcpp.
renv::install("Rcpp@1.0.6")
# version before rcpp-1.0.7 requirement
renv::install("httpuv@1.6.2")

renv::snapshot(prompt = FALSE)
