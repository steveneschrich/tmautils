#' Test that all data frame columns are logical
#'
#' @param .x A data frame
#'
#' @return A logical indicating if all elements of .x are logical
#' @export
#'
#' @examples
all_logical <- function(.x) {
  purrr::map_lgl(.x, is.logical) |>
    all()
}


#' Test if any elements of data frame are na
#'
#' @param .x data frame
#'
#' @return A logical indicating if any elements are na
#' @export
#'
#' @examples
#' \dontrun{
#' > any_missing(data.frame(A=c(1,2,3),B=c(2,NA,4)))
#' [1] TRUE
#' }
any_missing <- function(.x) {
  purrr::map_lgl(.x, \(y) {any(is.na(y))}) |>
    any()
}

#' Transpose a matrix/data frame into a data frame
#'
#' @description Transpose a matrix/data frame into a data frame, preserving col/row names
#'  and ensuring the result is a data frame.
#'
#'
#' NB: THIS IS BECAUSE OF REV I THINK, CHECK THAT FACT
#' @details I could not find a cleaner way to do this. It appears that [base::t()] will transpose
#' a data.frame into a matrix, not a data.frame. Which is normally fine, but then I want to use
#' the [base::rev()] function, which has different behavior between a matrix and a data frame.
#' Specifically, using [base::rev()] on a matrix yields a reversed vector.
#'
#' At a minimum (for my application), the transpose should convert back into a data.frame. In
#' the general case, this is not so easy as there is no guarantee that the transposed columns
#' are of the same type row-by-row. R type conversion does what it does for this, so the
#' problem is not too extreme.
#'
#' In addition to needing to convert types, we need to ignore the problems with the colnames
#' after transposing since they may not be clean. Data frames typically do this, although I
#' think perhaps the behavior has changed over time.
#'
#' This function does the task of transposing and converting back into
#' a data frame without changing the col/row names (other than transposing them as well).
#'
#' @param .x A matrix or data frame to transpose
#'
#' @return A transposed matrix or data frame, returned as a data frame.
#' @export
#'
#' @examples
td <- function(.x) {
  t(.x) |>
    magrittr::set_colnames(rownames(.x)) |>
    as.data.frame(check.names=FALSE)
}
