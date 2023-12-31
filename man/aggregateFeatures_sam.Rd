% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregation.R
\name{aggregateFeatures_sam}
\alias{aggregateFeatures_sam}
\title{Aggregate an assay's quantitative features which take into account
the peptides shared between proteins}
\usage{
aggregateFeatures_sam(
  object,
  i,
  aggType = "all",
  name,
  meta.names = NULL,
  fun,
  ...
)
}
\arguments{
\item{object}{An instance of class [QFeatures].}

\item{i}{The index or name of the assay which features will be
aggregated the create the new assay.}

\item{aggType}{The type of peptides used for the aggregation. Possibla values are: 'all', 'onlyShared' and 'onlySPec'. This argument automatically
selects the corresponding adjacency matrix.}

\item{name}{A `character(1)` naming the new assay. Default is `newAssay`. Note that the function will fail if there's
already an assay with `name`.}

\item{meta.names}{A vector of character strings that are the metadata of the peptides which needs to be aggregated
and kept in the protein dataset}

\item{fun}{A function used for quantitative feature
aggregation. See Details for examples.}

\item{...}{Additional parameters passed the `fun`.}
}
\value{
A `QFeatures` object with an additional assay.
}
\description{
This function aggregates the quantitative features of an assay,
applying an aggregation function (`fun`) to sets of features as
defined by the `fcol` feature variable. The new assay's features
will be named based on the unique `fcol` values.
This function is largely inspired by xxxx . The difference is that it can take into account the peptides shared between proteins.
}
\details{
Aggregation is performed by a function that takes a matrix as
input and returns a xxxxx. Examples
thereof are

- [Dapar2:aggSum()] to use the sum of each column (default);

- [Dapar2:aggMean()] to use the sum of each column;

- [Dapar2:aggIter()] to use the mean of each column;

- [Dapar2:aggIterParallel()] same as previous function but use parallelism.

- [Dapar2::aggTopn] to use the sum of each column;
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000]
obj <- SetAdjMat(obj, 2)
aggregateFeatures_sam(obj,2, aggType= 'all', name='aggregated', 
meta.names = 'Sequence', fun='aggTopn', n=3)

}
\seealso{
The *QFeatures* vignette provides an extended example and
    the *Processing* vignette, for a complete quantitative
    proteomics data processing pipeline.
}
