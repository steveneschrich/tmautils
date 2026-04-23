# Try various alignments of two data frames

Try various transformations of the target data frame to align against
the reference data frame. A overlap function provides the quality of
alignment.

## Usage

``` r
try_data_frame_alignments(
  reference,
  target,
  align_fun = tmautils::alignment_functions,
  overlap_fun = missing_overlap
)
```

## Arguments

- reference:

  A data frame assumed to contain the 2D TMA representation of the known
  TMA orientation.

- target:

  A data frame that may have an alternate 2D TMA representation which,
  on transformation, can match the reference.

- align_fun:

  Alignment function(s) that are used to rotate, etc the target data
  frame.

- overlap_fun:

  A function suitable for evaluating overlap in the transformed target
  compared to reference.

## Value

A list of alignment results (elements overlap and transform) indicating
quality of alignment for each transform.
