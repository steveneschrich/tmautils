# Generating row/column mapping using an alignment function

Create a mapping between a source data frame and the desired transform.

## Usage

``` r
generate_alignment_mapping(target, align_fun = alignment_functions[[1]])
```

## Arguments

- target:

  The target(transformed) matrix to generate mappings

- align_fun:

  An alignment function from which mappings are used

## Value

A table of source and target mappings

## Details

Assuming an alignment (rotation/reverse) is known, create a mapping
between coordinates in the src coordinate system (before rotation) into
the reference system defined by the transform.

The result is a data frame with the prefix of `src` for original
coordinates (labels and index) to the transformed (presumably corrected)
coordinate system (labels and index). For instance, the source row and
columns indexes are `src_row_index` and `src_col_index`. The corrected
row/col index are `row_index` and `col_index`.
