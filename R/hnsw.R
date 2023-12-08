#' @importFrom Rcpp evalCpp
#' @useDynLib vecstore, .registration=TRUE

#' @title R6 class representing a hierarchical navigable small worlds (HNSW) Index
#'
#' @description HNSW Index is used for nearest neighbor search based on provided data points.
#'
#' @export
#' @importFrom R6 R6Class
HNSWIndex <- R6::R6Class(
  "HNSWIndex",
  public = list(
    index = NULL,
    dim = NA,
    size = NA,
    label = 1,
    initialize = function(dim = NA, size = NA) {
      self$dim <- dim
      self$size <- size
      self$index <- create_index_hnsw(dim, size)
    },

    #' @description Add a data point to the index
    #' @param data A vector of length (\code{dim}) to be added to the index.
    add = function(data) {
      add_hnsw(self$index, data, self$label)
      self$label = self$label + 1
    },

    #' @description Search for top K nearest neighbors
    #' @param q The query vector of length (\code{dim})
    #' @param k Number of results to return
    find = function(q, k) {
      find_hnsw(self$index, q, k)
    }
  )
)
