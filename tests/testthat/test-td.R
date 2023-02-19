
df <- data.frame(
  `1Col` = c("A","B","C"),
  `2Col` = c("D","E","F"),
  `3Col` = c("G","H","I"),
  check.names=FALSE,
  row.names=c("1Row","2Row","3Row")
)
tdf <- data.frame(
  `1Row` = c("A","D","G"),
  `2Row` = c("B","E","H"),
  `3Row` = c("C","F","I"),
  check.names=FALSE,
  row.names=c("1Col","2Col","3Col")
)

test_that("basic transpose works", {
  expect_equal(td(df),tdf )
  expect_equal(td(td(df)), df)
})

test_that("two transposes equals original", {
  expect_equal(td(td(iris)), (apply(iris,2,as.character) |> as.data.frame(row.names = as.character(rownames(iris)))))
})

test_that("full rotation/reverse equals original", {
  expect_equal(td(rev(td(rev(td(rev(td(rev(iris)))))))), apply(iris,2,as.character) |>
                 as.data.frame(row.names = as.character(rownames(iris))
  ))
})
