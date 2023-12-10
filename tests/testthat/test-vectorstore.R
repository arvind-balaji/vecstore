test_that("Initialization creates VectorStore object", {
  index <- HNSWIndex$new(dim = 3, size = 10)
  vs <- VectorStore$new(index)
  expect_equal(vs$size, 0)
})

test_that("Adding data increments size", {
  index <- HNSWIndex$new(dim = 2, size = 10)
  vs <- VectorStore$new(index)

  vector <- c(1, 2)
  non_vector <- list("A")

  vs$add(vector, non_vector)
  expect_equal(vs$size, 1)

  # Check dimension mismatch
  expect_error(vs$add(c(1, 2, 3), non_vector), "Vector dimension does not")
})

test_that("Finding nearest neighbors returns expected results", {
  index <- HNSWIndex$new(dim = 2, size = 10)
  vs <- VectorStore$new(index)
  vectors <- list(c(1, 1), c(2, 2), c(3, 3))
  non_vectors <- list(list(name = "John", age = 30), list(name = "Alice", age = 25), list(name = "Bob", age = 35))

  for (i in 1:length(vectors)) {
    vs$add(vectors[[i]], non_vectors[[i]])
  }

  query <- c(1.25, 1.25)
  k <- 2
  result <- vs$find(query, 2)

  expect_equal(nrow(result), k)
  expect_equal(ncol(result), length(non_vectors[[1]]) + 1)
  expect_equal(result$Index, c(1, 2))
  expect_error(vs$find(query, 10), "Not enough")
  expect_error(vs$find(c(1), 10), "Query dim")
})
