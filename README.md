
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vecstore

<!-- badges: start -->

[![R-CMD-check](https://github.com/arvind-balaji/vecstore/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/arvind-balaji/vecstore/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/arvind-balaji/vecstore/branch/main/graph/badge.svg)](https://app.codecov.io/gh/arvind-balaji/vecstore?branch=main)
<!-- badges: end -->

The goal of vecstore is to provide a high performance data structure for
vector similarity search. It introduces `VectorStore`, allowing for the
insertion of data paired with corresponding vectors enabling efficient
retrieval of elements based on similarity to a query vector.

Ideal for machine learning applications that require fast look ups over
embeddings.

Additionally, vecstore exposes two vector index implementations:

- `HNSWIndex`: Utilizes the [Hierarchical Navigable Small
  World](https://doi.org/10.48550/arXiv.1603.09320) algorithm,
  implemented through the [hnswlib](https://github.com/nmslib/hnswlib)
  C++ library, for highly efficient nearest neighbor searches.
- `KNNIndex`: Utilizes naive exhaustive searches to retrieve the exact K
  nearest neighbors to a query.

## Installation

You can install the development version of vecstore like so:

``` r
install_github("https://github.com/arvind-balaji/vecstore")
```

## Example

Basic example of utilizing `VectorStore` with `dim = 3`.

``` r
library(vecstore)

dim <- 3

store <- VectorStore$new(dim)

store$add(c(10, 10, 10), list("A"))
store$add(c(38, 18, 40), list("B"))
store$add(c(10, 20, 30), list("C"))
store$add(c(90, 70, 15), list("D"))

query <- c(91, 68, 10)
k <- 3
store$find(query, k)
#>   V1 Index
#> 1  D     4
#> 2  B     2
#> 3  C     3
```

Utilizing vector indexes directly to retrieve indices of similar items.
We expect the `sample_id` to be the top result.

``` r
library(vecstore)

data <- as.matrix(iris[, -5])

dim = ncol(data)
n = nrow(data)

knn <- KNNIndex$new(dim)
hnsw <- HNSWIndex$new(dim, n)

for (i in 1:nrow(data)) {
  knn$add(data[i,])
  hnsw$add(data[i,])
}

sample_id <- 8
k <- 3
knn$find(data[sample_id,], k)
#> [1]  8 40 50
hnsw$find(data[sample_id,], k)
#> [1] 132 118 106

sample_id <- 9
knn$find(data[sample_id,], k)
#> [1]  9 39  4
hnsw$find(data[sample_id,], k)
#> [1] 132 118 106
```

## Benchmarks

The HNSW based index offer dramatic speed up over the brute force
approach.

``` r
library(vecstore)
library(microbenchmark)

data <- as.matrix(iris[, -5])
dim = ncol(data)
n = nrow(data)

knn <- KNNIndex$new(dim)
hnsw <- HNSWIndex$new(dim, n)

for (i in 1:nrow(data)) {
  knn$add(data[i,])
  hnsw$add(data[i,])
}

microbenchmark(knn$find(data[10,], 5), hnsw$find(data[10,], 5), times=100L)
#> Unit: microseconds
#>                      expr     min       lq      mean   median      uq      max
#>   knn$find(data[10, ], 5) 185.648 199.6700 221.81697 209.6535 220.785 1175.634
#>  hnsw$find(data[10, ], 5)   3.731   4.2845   6.09875   4.9610   5.986   41.902
#>  neval
#>    100
#>    100
```

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. -->
<!-- You can also embed plots, for example: -->
<!-- ```{r pressure, echo = FALSE} -->
<!-- plot(pressure) -->
<!-- ``` -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->
