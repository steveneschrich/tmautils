#' Compute overlap of missingness in two tables
#'
#' @description Given two tables (data frames or matrices), this function computes
#' the proportion (of reference) of overlap in missing values between the reference
#' and target table.
#'
#' @details  This function takes two tables (data frames or matrices) that can contain
#' some missing data values. The output of the function is the percentage of overlapped
#' missing values between the two tables relative to the number of missing values in the
#' reference (first argument).
#'
#' As an example, consider a tissue microarray matrix M of size NxP (reference). The first
#' five rows have the first value missing `M[1:5,1]` is NA. Then consider a target matrix T
#' of size NxP (target). This matrix has only the first element missing `M[1,1]` is `NA`. In this
#' case, the overlap is one position `(M[1,1])` divided by 5 positions (in reference), or 0.2.
#'
#' This function can be helpful in trying to identify orientations of a tissue microarray in
#' the case that one set of data is rotated/flipped from the reference definition of the TMA.
#' Should this happen, one could calculate the overlap of many different orientations to find
#' the one that best aligns with reference.
#'
#' @param reference A table representing the reference state to compare against
#' @param target Another table that may overlap in missingness with reference
#'
#' @return A percentage of missing value overlap (number overlapping divided by total missing in reference)
#' @export
#'
#' @examples
#' \dontrun{
#' > missing_overlap(data.frame(a=c(1,NA),b=c(2,NA)), data.frame(ap=c(2,NA), bp = c(2,3)))
#' [1] 0.5
#' }
missing_overlap <- function(reference, target) {

  # First check, the data frames/matrices need to be the same size. Actually,
  # we can still do it, just figure out where to chop off (not now).
  if ( !all(dim(reference) == dim(target)) ||
       !any(is.na(reference)) ) {
    return(0)
  }

  reference <-is.na(reference)
  target <- is.na(target)

  length(which(reference & target))/length(which(reference & TRUE))

}

#' Compute overlap of equal values between two tables
#'
#' @param reference  A table representing the reference state to compare against
#' @param target Another table that may overlap in values with reference
#'
#' @return A percentage of equal values that overlap (number overlapping divided by total elements in reference)
#' @export
#'
#' @examples
#' \dontrun{
#' equal_overlap()
#' }
equal_overlap <- function(reference, target) {
  # First check, the data frames/matrices need to be the same size. Actually,
  # we can still do it, just figure out where to chop off (not now).
  if ( !all(dim(reference) == dim(target))) {
    return(0)
  }

  length(which(reference == target))/(nrow(reference)*ncol(reference))
}

