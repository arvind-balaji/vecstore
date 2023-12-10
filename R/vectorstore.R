#' @title VectorStore class.
#' @description VectorStore class for storing vector and non-vector data.
#' @export
#' @importFrom R6 R6Class
VectorStore <- R6::R6Class(
  "VectorStore",
  public = list(
    #' @field size
    #' The current number of elements in the vector store.
    size = 0,
    #' @description Initialize a new vector store.
    #' @param index A vector index, either \code{HNSWIndex} or \code{KNNIndex}.
    initialize = function(index = NULL) {
      private$index <- index
      private$data <- list()
    },

    #' @description Add a vector and a list of non-vector data to the store
    #' @param vector A vector of length (\code{dim}) to be added to the index.
    #' @param non_vector_data A list of non-vector data corresponding to the vector.
    add = function(vector, non_vector_data) {
      if (length(vector) != private$index$dim) {
        stop("Vector dimension does not match data dimension.")
      }
      private$index$add(vector)
      private$data <- c(private$data, list(non_vector_data))
      self$size = self$size + 1
    },

    #' @description Search for top K nearest neighbors and return corresponding indexes and non-vector data
    #' @param q The query vector of length (\code{dim}).
    #' @param k Number of nearest neighbors to find.
    #' @return A (q x p) data frame containing indexes of the k nearest neighbors and their corresponding non-vector data.
    find = function(q, k) {
      if (length(q) != private$index$dim) {
        stop("Query dimension does not match data dimension.")
      }
      if (k > self$size) {
        stop("Not enough data to retrive k documents.")
      }
      indices <- private$index$find(q, k)
      print(indices)
      non_vector_data <- lapply(private$data[indices], function(item) unlist(item))
      print(private$data)
      df <- as.data.frame(do.call(rbind, non_vector_data))
      df$Index <- indices
      row.names(df) <- NULL
      return(df)
    }
  ),
  private = list(
    data = NULL,
    index = NULL
  )
)
