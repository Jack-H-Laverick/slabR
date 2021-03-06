
rounding_error <- 14                      # How close is close enough for results from Rcpp/R to be identical

array <- array(rnorm(36), dim = c(3,3,4)) # Randomly populate an array for testing

test_that("Single depth-averaged columns are correct", {

  scheme <- data.frame(x = 3, y = 3, depth = 1:4, voxel = 1, weight = 1)                   # Summary scheme
  
    expect_equal(round(slab(array, scheme, fun = "weighted mean"), digits = rounding_error),# test
                 round(mean(as.numeric(array[3, 3, 1:4])), digits = rounding_error))       # R equivalent)
})

test_that("Single zonal summaries are correct", {
  
  scheme <- data.frame(x = 3, y = 1:3, depth = 1, voxel = 1, weight = 1)                   # Summary scheme
  
  expect_equal(round(slab(array, scheme, fun = "weighted mean"), digits = rounding_error), # test
               round(mean(as.numeric(array[3, 1:3, 1])), digits = rounding_error))         # R equivalent
})

test_that("Single slab summaries are correct (horizontal and vertical)", {
  
  scheme <- data.frame(x = rep(c(1,2), each = 4), y = rep(c(1,2), times =4),               # Summary scheme
                       depth = c(1,1,2,2,1,1,2,2), voxel = 1, weight = 1)        
  
  expect_equal(round(slab(array, scheme, fun = "weighted mean"), digits = rounding_error), # test
               round(mean(as.numeric(array[1:2, 1:2, 1:2])), digits = rounding_error))     # R equivalent
})

test_that("Multiple slab summaries at once are correct", {
  
  slab1 <- data.frame(x = 1, y = 1:2, depth = c(1,1,2,2), voxel = 1, weight = 1)           # Slab 1 summary
  slab2 <- data.frame(x = 2, y = 1:2, depth = c(1,1,2,2), voxel = 2, weight = 1)           # Slab 2 summary
  slab3 <- data.frame(x = 1, y = 1:2, depth = c(3,3,4,4), voxel = 3, weight = 1)           # Slab 3 summary
  scheme <- rbind(slab1, slab2, slab3)                                                     # Total summary scheme
  
  expect_equal(round(slab(array, scheme, fun = "weighted mean"), digits = rounding_error), # test
               c(round(mean(as.numeric(array[1, 1:2, 1:2])), digits = rounding_error),     # R equivalent
                 round(mean(as.numeric(array[2, 1:2, 1:2])), digits = rounding_error),
                 round(mean(as.numeric(array[1, 1:2, 3:4])), digits = rounding_error)))
})