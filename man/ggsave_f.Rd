% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphics.R
\name{ggsave_f}
\alias{ggsave_f}
\title{Custom ggsave function}
\usage{
ggsave_f(
  filename,
  filepath = NULL,
  plt = ggplot2::last_plot(),
  device = c("pdf", "png", "wmf"),
  perspective = c("4.3", "16.9"),
  pWidth = 6,
  Units = "in",
  dpi = 300,
  verbose = F
)
}
\arguments{
\item{filename}{filename}

\item{plt}{plot to be printed}

\item{device}{vector of graphic device(s) for output. pdf and png use Cairo.}

\item{perspective}{vector of perspectives to plot}

\item{pWidth}{plot width}

\item{Units}{pWidth units}

\item{dpi}{image resolution}

\item{verbose}{logical to provide feedback}

\item{path}{path where plots should be saved}
}
\description{
Allows for multiple file formats
}
\details{
If verbose, return vector of filenames created else nothing
}
