# Incompatible R package binaries

Installed R packages are not always compatible with other packages installed
into the same library. 

This repository contains an example of what may happen when installing from
source packages in one environment and installing from binary packages in
another.

This example uses an RStudio Package Manager repository time-stamp.
<https://packagemanager.rstudio.com/all/2021-09-01+Y3JhbjoyMDIxLTA4LTMxLDI6NDUyNjIxNTs3Rjc5MTcxQw">
This corresponds to a date after the Rcpp-1.0.7 release, but just prior to the
httpuv-1.6.3 release. The httpuv-1.6.3 started requiring Rcpp-1.0.7 to help
folks avoid the binary package incompatibility seen here.

RSPM does not currently support binary packages on macOS, but it does support
binaries for Ubuntu 18.04 (Bionic Beaver). We take advantage of this
difference in order to create a situation where a development (macOS)
environment has a working configuration, yet the same environment will fail to
run in the "production" (Ubuntu Linux) environment. This difference in
behavior is caused by installing R packages binary packages on Linux.

```bash
R -s -f bootstrap.R
R -s -f install.R
```

```bash
# Successfully run an httpuv server. Control-C to stop.
R -s -f run.R
```

```bash
# Fail to run in Linux; renv automatically discovers and uses binary packages.
docker run -it --rm \
    -v $(pwd):/content \
    -w /content \
    rstudio/r-base:3.6.3-bionic \
    R -s -f run.R
```

The resulting error is:

```
> httpuv::runServer("127.0.0.1", 5000, list(call = function(req) list(status = 200)))
Error in makeTcpServer(host, port, private$appWrapper$onHeaders, private$appWrapper$onBodyData,  :
  function 'Rcpp_precious_remove' not provided by package 'Rcpp'
Calls: <Anonymous> ... startServer -> <Anonymous> -> initialize -> makeTcpServer
Execution halted
```

To clean-up and retry this experiment, run the following within this
repository:

```bash
rm -rf .Rprofile renv renv.lock
```

This example uses `renv` to demonstrate the problem, but its use is not
required. The project configuration uses a bare library and disables the
global `renv` cache, as neither the system library nor the cache are in known
states.
