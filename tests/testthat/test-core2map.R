
lin <- tibble::tribble(
  ~row, ~col, ~val,
  1,1,"(1,1)",
  1,2,"(1,2)",
  1,3,"(1,3)",
  2,1,"(2,1)",
  2,2,"(2,2)",
  2,3,"(2,3)"
)
linmap <- data.frame(
  `1`=c("(1,1)","(2,1)"),
  `2`=c("(1,2)","(2,2)"),
  `3`=c("(1,3)","(2,3)"),
  check.names=FALSE,
  row.names=c("1","2")
)

test_that("basic core2map works", {
  expect_equal(core2map(lin, row=row,col=col,val=val), linmap )
  expect_equal(core2map(lin, row=row,col=col),
               core2map(lin |>
                          dplyr::mutate(val = paste0(row,"_",col)), row=row,col=col,val=val))
})
