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

#' Add an item to the kNN index
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
#' index <- add_item_knn(index, c(1, 2, 3))
add_item_knn <- function(index, data) {
  return(list(data = rbind(index$data, data)))
}

#' Find k Nearest Neighbors (kNN)
#'
#' This function finds the k nearest neighbors to a query vector within the index.
#'
#' @param index The index containing the data points.
#' @param q The query vector for which neighbors are to be found.
#' @param k The number of nearest neighbors to find (default is 5).
#' @return Indices of the k nearest neighbors.
#' @export
#'
#' @examples
#' index <- create_index_knn(3)
#' index <- add_item_knn(index, c(1, 2, 3))
#' I <- find_knn(index, c(2, 3, 4), k = 2)
find_knn <- function(index, q, k = 5) {
  distances <- apply(index$data, 1, function(row) euclidean_distance(q, row))
  indices <- order(distances)[1:k]
  return(indices)
}
