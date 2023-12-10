test_that("add_knn adds data point correctly", {
  index <- create_index_knn(3)
  index <- add_knn(index, c(1, 2, 3))
  expect_equal(dim(index$data), c(1, 3))
  expect_equal(index$data[1, ], c(1, 2, 3))
})

test_that("find_knn finds nearest neighbors correctly", {
  index <- create_index_knn(3)
  index <- add_knn(index, c(1, 2, 3))
  index <- add_knn(index, c(4, 5, 6))
  index <- add_knn(index, c(83, 82, 80))
  indices <- find_knn(index, c(5, 7, 5), k = 3)

  expect_equal(indices, c(2,1,3))
})
