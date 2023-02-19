#' Create a data frame from flat TMA coordinates
#'
#' @param x A data frame to use
#' @param row The column name for TMA row information
#' @param col The column name for TMA column information
#' @param val The column to display in each cell. If omitted (or NULL), generate a coordinate display `(row,col)`.
#'
#' @return A data frame representing the row/col arrangement of the table
#' @export
#'
#' @examples
core2map <- function(x, row, col, val = NULL) {

  stopifnot("Column name for row index must be included" = !missing(row))
  stopifnot("Column name for col index must be included" = !missing(col))
  # Protect parameters so they can be examined (if they are symbols).
  row <- rlang::enquo(row)
  col <- rlang::enquo(col)
  val <- rlang::enquo(val)

  stopifnot("Row/col values must be included." = !rlang::is_missing(row) && !rlang::is_missing(col))
  stopifnot(all(c(rlang::as_name(row), rlang::as_name(col)) %in% colnames(x)))

  # If null, construct a temporary label for the matrix
  if ( rlang::quo_is_null(val) ) {
    x <- dplyr::mutate(x, tmpcore2map = paste0({{ row }},"_",{{ col }}))
    val <- rlang::quo(tmpcore2map)
  }

  stopifnot(rlang::as_name(val) %in% colnames(x))

  x |>
    dplyr::select({{ row }}, {{ col }}, {{ val }}) |>
    dplyr::arrange( {{row }}, {{col }}) |>
    tidyr::pivot_wider(
      id_cols={{ row }},
      names_from= {{ col }},
      values_from={{ val }}
    ) |>
    tibble::column_to_rownames(rlang::as_name(row))
}
