
array <- array(rnorm(36), dim = c(3,3,4)) # Randomly populate an array for testing

test_that("Unsupported summaries cause an error", {

  scheme <- data.frame(x = 3, y = 3, depth = 1:4, voxel = 1, weight = 1)                   # Summary scheme
  
  expect_error(slab(array, scheme, fun = "mistake"),                                     # test
               "summary operation 'mistake' not supported. Choose from 'mean' or 'weighted mean'")
})
