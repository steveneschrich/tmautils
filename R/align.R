#' Alignment function list
#'
#' @description A list of alignments that rotate/flip a matrix.
#'
#' @details Sometimes a TMA result will be captured in a different orientation from the
#' initial design description. In this case, row and column numbers will not refer back
#' to the correct location. There are markers (blanks) on many TMAs which can help orient
#' the result back to the design.
#'
#' This list is a set of operators that can be applied to a matrix to rotate and/or flip a
#' matrix into different orientations. It consists of different transpose and reverse operators
#' in different orders to generate the various permutations.
#'
#' Note that the contents of the list are quoted functions, so you can print out the function. If
#' you would like to use the function, you would need to use [base::eval()] to evaluate it.
#'
#' @docType data
#' @name alignment_functions
#'
"alignment_functions"


#' Try various alignments of two data frames
#'
#' @description Try various transformations of the target data frame to align against the reference data frame. A
#' overlap function provides the quality of alignment.
#'
#' @details
#'
#' @param reference A data frame assumed to contain the 2D TMA representation of the known TMA orientation.
#' @param target A data frame that may have an alternate 2D TMA representation which, on transformation,
#' can match the reference.
#' @param align_fun Alignment function(s) that are used to rotate, etc the target data frame.
#' @param overlap_fun A function suitable for evaluating overlap in the transformed target compared to reference.
#'
#'
#' @return A list of alignment results (elements overlap and transform) indicating quality of alignment for each
#' transform.
#'
#' @export
#'
#' @examples
try_data_frame_alignments <- function(reference, target, align_fun = tmautils::alignment_functions, overlap_fun = missing_overlap) {

  solutions <- purrr::map(align_fun, \(f) {
    list(
      overlap = overlap_fun(reference, eval(f)(target)),
      transform = f
    )
  })
  solutions
}

#' Generating row/column mapping using an alignment function
#'
#' @description Create a mapping between a source data frame and the desired transform.
#'
#' @details Assuming an alignment (rotation/reverse) is known, create a mapping between
#' coordinates in the src coordinate system (before rotation) into the reference system
#' defined by the transform.
#'
#' The result is a data frame with the prefix of `src` for original coordinates (labels
#' and index) to the transformed (presumably corrected) coordinate system (labels and
#' index). For instance, the source row and columns indexes are `src_row_index` and
#' `src_col_index`. The corrected row/col index are `row_index` and `col_index`.
#'
#' @param target The target(transformed) matrix to generate mappings
#' @param align_fun An alignment function from which mappings are used
#'
#' @return A table of source and target mappings
#' @export
#'
#' @examples
generate_alignment_mapping <- function(target, align_fun = alignment_functions[[1]]) {

  # Create a data frame labelled with row/column coordinates (separated by ___).
  x <- matrix(nrow=nrow(target), ncol=ncol(target),
              dimnames=list(1:nrow(target), 1:ncol(target))) |>
    as.data.frame(check.names=FALSE)
  for (row in 1:nrow(target)) {
    for (col in 1:ncol(target)) {
      x[row,col]<-sprintf("%s___%s", rownames(target)[row], colnames(target)[col])
    }
  }

  # Transform the labelled data frame
  tx <- eval(align_fun)(x)

  # Now we can extract the transformed coordinates (using row_index and tidyr), as well as the original
  # coordinates (from each cell).
  colnames(tx) <- 1:ncol(tx)
  tx$row_index <- 1:nrow(tx)
  coord <- tx |>
    tidyr::pivot_longer(cols = c(dplyr::everything(), -row_index), names_to="col_index", values_to="coordinates") |>
    tidyr::separate(col = coordinates, into=c("src_row_index","src_col_index"), sep = "___", remove=TRUE) |>
    dplyr::mutate(dplyr::across(dplyr::everything(), as.integer))

  coord
}

#' Find TMA alignment between reference matrix and target matrix
#'
#' @description Perform various transforms to target matrix to align missingness
#' patterns with the reference matrix. The translated coordinates are returned.
#'
#' @details Given a matrix representing a TMA result, the goal is to find a transform
#' of the target matrix that aligns missingness patterns in the target and reference matrix.
#'
#' The content of the matrices does not matter; only the missingness patterns are matched. Since
#' it is possible for missingness in the target to include other missing cores, the goal is to find
#' the orientation that matches all reference missing cores. Once this is done, a translation of the
#' coordinates between the reference and target are provided.
#'
#' The translations considered are transpose and column reverse. Combinations of these operators
#' result in all possible shifts: right/left rotate, flip over long or short edge. It is assumed
#' that one of these transformations will lead to perfect alignment of missingness patterns.
#'
#' The output of the function assumes that reference is "correct", therefore the coordinates in the
#' form of `row_index` are in the reference's frame of reference. The `src_row_index` represents the
#' target's frame of reference.
#'
#' @param reference A matrix/data.frame representing the reference TMA design
#' @param target A matrix/data.frame representing stain data that may be reversed or transposed.
#'
#' @return A data.frame of row/column indexes in the original (src) frame of reference and the desired
#' (reference) frame of reference.
#' @export
#'
#' @examples
find_tma_alignment <- function(reference, target) {

  # Try the variations of transformations
  res <- try_data_frame_alignments(reference, target, overlap_fun = missing_overlap)

  # Find the overlap of 1
  full_overlap <- which(purrr::map_lgl(res, \(x){x$overlap==1}))

  if ( length(full_overlap) > 1 ) {
    cli::cli_warn("x"="Multiple alignments of target data match missingness profile of reference.")
  } else {
    message(glue::glue("Alignment solution identified as: {names(full_overlap)}"))
  }

  mapping <- generate_alignment_mapping(target, align_fun = res[[full_overlap]]$transform)

  mapping
}
