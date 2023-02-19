
all_na<-data.frame(A=c(NA,NA,NA),B=c(NA,NA,NA))

test_that("different dims in overlap is 0", {
  expect_equal(equal_overlap(iris,t(iris)),0)
  expect_equal(missing_overlap(all_na, t(all_na)),0)
})
test_that("full overlap works", {
  expect_equal(equal_overlap(iris,iris),1)
  expect_equal(missing_overlap(all_na, all_na),1)
})

test_that("no overlap works", {
  expect_equal(missing_overlap(all_na, data.frame(A=c(1,2,3),B=c(1,2,3))),0)
  expect_equal(equal_overlap(iris[,1:4],iris[,1:4]+1),0)
})
