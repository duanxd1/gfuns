% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fileConvert.R
\name{unicodeClean}
\alias{unicodeClean}
\title{Clean up unicode characters}
\usage{
unicodeClean(x, specials = matrix(c("b5", "u"), ncol = 2), csv = FALSE)
}
\arguments{
\item{x}{character string}

\item{specials}{character matrix where col1 is character to replace and col2 is replacement character}

\item{csv}{is file a csv}
}
\description{
Clean up unicode characters
}
\examples{
# bo = degree sign
# b5 = greek mu
}
