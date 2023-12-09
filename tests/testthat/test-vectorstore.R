test_that("Initialization creates VectorStore object", {
  vs <- VectorStore$new(dim = 3)
  expect_identical(vs$dim, 3)
  expect_equal(vs$size, 0)
})

test_that("Adding data increments size", {
  vs <- VectorStore$new(dim = 2)
  vector <- c(1, 2)
  non_vector <- list(name = "John", age = 30)

  vs$add(vector, non_vector)
  expect_equal(vs$size, 1)

  # Check dimension mismatch
  expect_error(vs$add(c(1, 2, 3), non_vector), "Vector dimension does not match data dimension.")
})

test_that("Finding nearest neighbors returns expected results", {
  vs <- VectorStore$new(dim = 2)
  vectors <- list(c(1, 1), c(2, 2), c(3, 3))
  non_vectors <- list(list(name = "John", age = 30), list(name = "Alice", age = 25), list(name = "Bob", age = 35))

  for (i in 1:length(vectors)) {
    vs$add(vectors[[i]], non_vectors[[i]])
  }

  query <- c(1.5, 1.5)
  k <- 2
  result <- vs$find(query, k)

  expect_equal(nrow(result), k)
  expect_equal(ncol(result), length(non_vectors[[1]]) + 1)
  expect_equal(result$Index, c(1, 2))
})
