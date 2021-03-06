% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/panderFuns.R
\name{cat_pir2}
\alias{cat_pir2}
\title{Format and add image using pander::pandoc.image.return}
\usage{
cat_pir2(
  plot_g,
  Caption = NULL,
  Tag = NULL,
  Width = knitr::opts_chunk$get("fig.width"),
  Height = knitr::opts_chunk$get("fig.height"),
  vec.res = 300
)
}
\arguments{
\item{plot_g}{plot to be added to document}

\item{Caption}{caption for plot}

\item{Tag}{tag to be referenced using pandoc-crossref}

\item{Width}{figure width}

\item{Height}{figure width}

\item{vec.res}{figure resolution}
}
\description{
Modification of cat.pir2 to allow for resizing using magick package. Pixels in a letter page = 612 x 792 so pixels per inch = 612/8.5 = 72
}
