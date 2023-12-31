% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregation.R
\name{aggSum}
\alias{aggSum}
\title{Compute the intensity of proteins with the sum of the intensities
of their peptides.}
\usage{
aggSum(qPepData, X)
}
\arguments{
\item{qPepData}{A matrix of intensities of peptides.}

\item{X}{An adjacency matrix in which lines and columns correspond 
respectively to peptides and proteins.}
}
\value{
A matrix of intensities of proteins.
}
\description{
This function computes the intensity of proteins based on the sum of the 
intensities of their peptides.
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000,]
obj <- SetAdjMat(obj, 2)
X <- GetAdjMat(obj, 2)$all
aggSum(assay(obj, 2), X)

}
\author{
Alexia Dorffer, Samuel Wieczorek
}
