% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/align.R
\name{try_data_frame_alignments}
\alias{try_data_frame_alignments}
\title{Try various alignments of two data frames}
\usage{
try_data_frame_alignments(
  reference,
  target,
  align_fun = tmautils::alignment_functions,
  overlap_fun = missing_overlap
)
}
\arguments{
\item{reference}{A data frame assumed to contain the 2D TMA representation of the known TMA orientation.}

\item{target}{A data frame that may have an alternate 2D TMA representation which, on transformation,
can match the reference.}

\item{align_fun}{Alignment function(s) that are used to rotate, etc the target data frame.}

\item{overlap_fun}{A function suitable for evaluating overlap in the transformed target compared to reference.}
}
\value{
A list of alignment results (elements overlap and transform) indicating quality of alignment for each
transform.
}
\description{
Try various transformations of the target data frame to align against the reference data frame. A
overlap function provides the quality of alignment.
}
