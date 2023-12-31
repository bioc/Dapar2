% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/group_ttest.R
\name{compute.group.t.test}
\alias{compute.group.t.test}
\title{xxxxxx}
\usage{
\method{compute}{group.t.test}(obj, sampleTab, logFC = NULL, contrast = "OnevsOne", type = "Student")
}
\arguments{
\item{obj}{xxxxx}

\item{sampleTab}{xxxx}

\item{logFC}{A vector (or list of vectors) xxxx}

\item{contrast}{Indicates if the test consists of the comparison of each 
biological condition versus 
each of the other ones (contrast=1; 
for example H0:"C1=C2" vs H1:"C1!=C2", etc.) 
or each condition versus all others (contrast=2; e.g.  H0:"C1=(C2+C3)/2" vs
H1:"C1!=(C2+C3)/2", etc. if there are three conditions).}

\item{type}{xxxxx}
}
\value{
A DataFrame which contains the
}
\description{
xxxxxx
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:1000]
obj <- addAssay(obj, QFeatures::filterNA(obj[[2]],  pNA = 0), name='filtered')
obj <- SetAdjMat(obj, 3)
sTab <- colData(obj)
gttest <- compute.group.t.test(obj[[3]], sTab)

}
\author{
Thomas Burger, Samuel Wieczorek
}
