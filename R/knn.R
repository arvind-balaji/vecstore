#' Create an index for k-Nearest Neighbors (kNN) search
#'
#' This function initializes an empty index for kNN search with a specified dimension.
#'
#' @param dim The dimension of the feature space.
#' @return A list containing an initialized index with an empty data matrix.
#' @export
#'
#' @examples
#' index <- create_index_knn(3)
create_index_knn <- function(dim) {
  return(list(data = matrix(nrow = 0, ncol = dim)))
}

#' Add a data point to the index
#'
#' This function appends a new data point to the existing kNN index.
#'
#' @param index The index to which the data will be added.
#' @param data The data point to be added to the index.
#' @return An updated index with the new data point added.
#' @export
#'
#' @examples
#' index <- create_index_knn(3)
#' index <- add_knn(index, c(1, 2, 3))
add_knn <- function(index, data) {
  return(list(data = rbind(index$data, data)))
}

#' Search for top K nearest neighbors
#'
#' This function finds the k nearest neighbors to a query vector within the index.
#'
#' @param index The index containing the data points.
#' @param q The query vector of length (\code{dim}) for which neighbors are to be found.
#' @param k The number of nearest neighbors to find.
#' @return Indices of the k nearest neighbors.
#' @export
#'
#' @examples
#' index <- create_index_knn(3)
#' index <- add_knn(index, c(1, 2, 3))
#' I <- find_knn(index, c(2, 3, 4), k = 2)
find_knn <- function(index, q, k = 5) {
  distances <- apply(index$data, 1, function(row) euclidean_distance(q, row))
  indices <- order(distances)[1:k]
  return(indices)
}


#' @title R6 class representing a k-Nearest Neighbors (kNN) Index
#'
#' @description kNN Index is used for nearest neighbor search based on provided data points.
#'
#' @export
#' @importFrom R6 R6Class
KNNIndex <- R6::R6Class(
  "KNNIndex",
  public = list(
    #' @field dim
    #' The dimension of the vectors to be indexed.
    dim = NA,

    #' @field size
    #' The current number of elements in the index.
    size = NA,

    #' @description Create a new KNN vector index.
    #' @param dim The dimension of the vectors to be indexed.
    initialize = function(dim = NA) {
      self$dim <- dim
      self$index <- create_index_knn(dim)
    },

    #' @description Add a data point to the index
    #' @param data A vector of length (\code{dim}) to be added to the index.
    add = function(data) {
      self$index <- add_knn(self$index, data)
      si
    },

    #' @description Search for top K nearest neighbors
    #' @param q The query of vector of length (\code{dim})
    #' @param k Number of results to return
    find = function(q, k) {
      find_knn(self$index, q, k)
    }
  ),
  private = list(
    index = NULL
  )
)

