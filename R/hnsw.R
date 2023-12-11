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
    #' @field index
    #' The dimension of the vectors to be indexed.
    index = NULL,

    #' @field dim
    #' The dimension of the vectors to be indexed.
    dim = NA,

    #' @field size
    #' The max capacity of the index.
    size = NA,

    #' @description Create a new HNSW vector index.
    #' @param dim The dimension of the vectors to be indexed.
    #' @param size The max capacity of the index.
    #' @param M  Parameter that defines the maximum number of outgoing connections in the graph.
    #' @param ef_construction Parameter that controls speed/accuracy trade-off during the index construction.
    initialize = function(dim = NA, size = NA, M = 16, ef_construction = 100) {
      self$dim <- dim
      self$size <- size
      self$index <- create_index_hnsw(dim, size, M, ef_construction)
    },

    #' @description Add a data point to the index
    #' @param data A vector of length (\code{dim}) to be added to the index.
    add = function(data) {
      add_hnsw(self$index, data, private$label)
      private$label = private$label + 1
    },

    #' @description Search for top K nearest neighbors
    #' @param q The query vector of length (\code{dim})
    #' @param k Number of results to return
    find = function(q, k) {
      find_hnsw(self$index, q, k)
    }
  ),
  private = list(
    label = 1
  )
)
