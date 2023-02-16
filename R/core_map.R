#' Create a data frame from flat TMA coordinates
#'
#' @param x
#' @param row_label
#' @param col_label
#' @param core_id
#'
#' @return
#' @export
#'
#' @examples
core_map <- function(x, row_label = "row_label", col_label="col_label",core_id="core_id") {

  row_label <- rlang::sym(row_label)
  col_label <- rlang::sym(col_label)
  core_id <- rlang::sym(core_id)
  x |>
    dplyr::select({{ row_label }}, {{ col_label }}, {{ core_id}}) |>
    dplyr::arrange( {{row_label}}, {{col_label}}) |>
    tidyr::pivot_wider(
      id_cols={{ row_label }},
      names_from= {{ col_label }},
      values_from={{ core_id}}
    ) |>
    tibble::column_to_rownames(as.character(row_label))
}
