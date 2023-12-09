#' Calculate Euclidean Distance
#'
#' This function computes the Euclidean distance between two vectors.
#'
#' @param vec1 The first vector.
#' @param vec2 The second vector.
#' @return The Euclidean distance between the two input vectors.
#'
#' @examples
#' euclidean_distance(c(1, 2, 3), c(4, 5, 6))
euclidean_distance <- function(vec1, vec2) {
  sqrt(sum((vec1 - vec2)^2))
}

#' Calculate Cosine Similarity
#'
#' This function computes the cosine similarity between two vectors.
#'
#' @param vec1 The first vector.
#' @param vec2 The second vector.
#' @return The cosine similarity between the two input vectors.
#'
#' @examples
#' cosine_similarity(c(1, 2, 3), c(4, 5, 6))
cosine_similarity <- function(vec1, vec2) {
  dot_product <- sum(vec1 * vec2)
  magnitude_vec1 <- sqrt(sum(vec1^2))
  magnitude_vec2 <- sqrt(sum(vec2^2))

  cosine_sim <- dot_product / (magnitude_vec1 * magnitude_vec2)
  return(cosine_sim)
}
