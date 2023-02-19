test_that("missing_overlap with no missingness works.", {
  expect_equal(missing_overlap(iris, iris),0)
})

ma <- mb <- iris
ma[1,4]<-NA
mb[4,1]<-NA

test_that("missing_overlap with no overlap works.", {
  expect_equal(missing_overlap(ma,mb ), 0)
})

ma<-mb<-iris
ma[1,4]<-NA
mb[1,4]<-NA
test_that("missing_overlap with complete overlap works.",{
  expect_equal(missing_overlap(ma,mb), 1)
})


test_that("missing_overlap works with mixed types",{
  expect_equal(missing_overlap(ma, as.matrix(mb)), 1)
})

test_that("missing_overlap works with different dimensions", {
  expect_equal(missing_overlap(iris, t(iris)), 0)
})
