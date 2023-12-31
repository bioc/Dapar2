% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DiffAnalysis.R
\name{Get_AllComparisons}
\alias{Get_AllComparisons}
\title{Returns list that contains a list of the statistical tests performed with Dapar2 and recorded
in an object of class \code{QFeatures}.}
\usage{
Get_AllComparisons(obj)
}
\arguments{
\item{obj}{An object of class \code{SummarizedExperiment}.}
}
\value{
A list of two slots: logFC and P_Value. Each slot contains a DataFrame
}
\description{
This method returns a list of the statistical tests performed with xxx and formatted as a 
list of two DataFrame: one for the logFC data and one for the p-values data.
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
object <- Exp1_R25_pept[1:1000,]
object <- addAssay(object, QFeatures::filterNA(object[[2]],  pNA = 0), name='filtered')
sTab <- colData(object)
gttest.se <- t_test_sam(object[[3]], sTab, FUN = compute.t.test)
object <- addAssay(object, gttest.se, name='t-test')
comp <- '25fmol_vs_10fmol'
object <- diff_analysis_sam(object, 't-test', name='diffAna', comp)

allComp <- Get_AllComparisons(object[['diffAna']])


}
\author{
Samuel Wieczorek
}
