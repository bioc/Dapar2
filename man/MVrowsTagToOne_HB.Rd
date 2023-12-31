% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Filtering.R
\name{MVrowsTagToOne_HB}
\alias{MVrowsTagToOne_HB}
\title{Filter missing values by proportion}
\usage{
MVrowsTagToOne_HB(obj, sTab, int.prop, mode = "None")
}
\arguments{
\item{obj}{An object of class \code{SummarizedExperiment} containing quantitative data
and phenotype data.}

\item{sTab}{xxxx}

\item{int.prop}{float between 0 and 1 corresponding to the proportion
of intensities to keep in the lines.}

\item{mode}{character string. Four possibilities corresponding to the
description above: "None", WholeMatrix", "AllCond" and "AtLeastOneCond".}
}
\value{
the object given as input but with the lines not respecting the
proportion of NA requested in less.
}
\description{
Remove lines in the data according to the proportion of missing
values. This proportion is calculated differently depending on whether we
want a certain proportion of missing values (NA) to remain on:
* the entire matrix, regardless of the conditions: the rows containing a
proportion of NA equal or below the threshold will be kept.
* all the conditions: the lines for which all the conditions have a NA
proportion equal to or less than the fixed proportion will be kept.
* at least one condition: the lines for which at least one condition is
equal to or less than the fixed proportion of NA will be kept.
}
\details{

}
\examples{
library(QFeatures)
utils::data(Exp1_R25_prot, package='DAPARdata2')
obj <- Exp1_R25_pept
sTab <- colData(obj)

obj <- MVrowsTagToOne_HB(obj, sTab, mode = 'AtLeastOneCond', int.prop = 0.7)
na_filter_percent <- VariableFilter(field = "tagNA", value = "0", condition = "==")
obj <- filterFeaturesSam(object = obj, i = 2, name = 'na_filter_percent', filter=na_filter_percent)
obj <- removeAdditionalCol(obj, "tagNA")

}
\author{
H?l?ne Borges, Samuel Wieczorek
}
