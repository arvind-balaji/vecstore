#' @title VectorStore class using HNSWIndex
#' @description VectorStore class for storing vector and non-vector data using HNSWIndex
#' @export
#' @importFrom R6 R6Class
VectorStore <- R6::R6Class(
  "VectorStore",
  public = list(
    index = NULL,
    dim = NA,
    data = NULL,
    initialize = function(dim = NA) {
      self$dim <- dim
      self$index <- KNNIndex$new(dim)
      self$data <- list()
    },

    #' @description Add a vector and a list of non-vector data to the store
    #' @param vector A vector of length (\code{dim}) to be added to the index.
    #' @param non_vector_data A list of non-vector data corresponding to the vector.
    add = function(vector, non_vector_data) {
      if (length(vector) != self$dim) {
        stop("Vector dimension does not match data dimension.")
      }
      self$index$add(vector)
      self$data <- c(self$data, list(non_vector_data))
    },

    #' @description Search for top K nearest neighbors and return corresponding indexes and non-vector data
    #' @param q The query vector of length (\code{dim}).
    #' @param k Number of nearest neighbors to find.
    #' @return A (q x p) data frame containing indexes of the k nearest neighbors and their corresponding non-vector data.
    find = function(q, k) {
      if (length(q) != self$dim) {
        stop("Query dimension does not match data dimension.")
      }
      if (k > self$index$label - 1) {
        stop("Not enough data to retrive k documents.")
      }
      indices <- self$index$find(q, k)
      non_vector_data <- lapply(self$data[indices], function(item) unlist(item))
      df <- as.data.frame(do.call(rbind, non_vector_data))
      df$Index <- indices
      row.names(df) <- NULL
      return(df)
    }
  )
)