test_that("euclidean_distance computes correct Euclidean distance", {
  expect_equal(euclidean_distance(c(1, 2, 3), c(1, 2, 3)), 0)
  expect_equal(euclidean_distance(c(1, 0), c(0, 1)), sqrt(2))
  expect_equal(euclidean_distance(c(1, 2, 3), c(4, 5, 6)), sqrt(27))
})


test_that("cosine_similarity computes correct cosine similarity", {
  expect_equal(cosine_similarity(c(1, 2, 3), c(1, 2, 3)), 1)
  expect_equal(cosine_similarity(c(1, 0), c(0, 1)), 0)
  expect_equal(cosine_similarity(c(1, 2, 3), c(4, 5, 6)), 0.9746318, tolerance = 1e-6)
})
