% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/corstars.R
\name{corstars}
\alias{corstars}
\title{x is a matrix containing the data}
\usage{
corstars(
  x,
  method = c("pearson", "spearman"),
  removeTriangle = c("upper", "lower"),
  result = c("none", "html", "latex")
)
}
\arguments{
\item{x}{matrix to calculate correlations}

\item{method}{one of pearson or spearman}

\item{removeTriangle}{on of upper or lower}

\item{result}{on of none, html, or latex. none returns a matrix, the others format output}
}
\description{
the results will be displayed in html or latex format
from: http://www.sthda.com/english/wiki/elegant-correlation-table-using-xtable-r-package
and: http://myowelt.blogspot.com/2008/04/beautiful-correlation-tables-in-r.html
}
