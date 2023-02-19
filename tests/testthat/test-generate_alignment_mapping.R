firis <- iris
colnames(firis)<-1:5
irisres <- tibble::tibble(
  row_index = rep(1:150,each=5),
  col_index = rep(1:5, times=150),
  src_row_index = row_index,
  src_col_index = col_index
)

iristres <- tibble::tibble(
  row_index = rep(1:5,each=150),
  col_index = rep(1:150, times=5),
  src_row_index = col_index,
  src_col_index = row_index
)
test_that("multiplication works", {
  expect_equal(generate_alignment_mapping(firis, align_fun=I),irisres )
  expect_equal(generate_alignment_mapping(firis, align_fun=td), iristres)
})
