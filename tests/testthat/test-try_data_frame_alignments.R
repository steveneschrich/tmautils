test_that("try_data_frame_alignments basic works", {
  expect_equal(try_data_frame_alignments(iris,iris, overlap_fun = equal_overlap)[[1]], list(overlap=1, transform=quote(I)))
})
