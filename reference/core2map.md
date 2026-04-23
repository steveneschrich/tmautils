# Create a data frame from flat TMA coordinates

Create a data frame from flat TMA coordinates

## Usage

``` r
core2map(x, row, col, val = NULL)
```

## Arguments

- x:

  A data frame to use

- row:

  The column name for TMA row information

- col:

  The column name for TMA column information

- val:

  The column to display in each cell. If omitted (or NULL), generate a
  coordinate display `(row,col)`.

## Value

A data frame representing the row/col arrangement of the table
