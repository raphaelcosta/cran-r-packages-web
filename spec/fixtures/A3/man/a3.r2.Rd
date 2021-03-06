\name{a3.r2}
\alias{a3.r2}
\title{Cross-Validated \eqn{R^2}}
\usage{
  a3.r2(y, x, simulate.fn, cv.folds)
}
\arguments{
  \item{y}{a vector or responses.}

  \item{x}{a matrix of features.}

  \item{simulate.fn}{a function object that creates a model
  and predicts y.}

  \item{cv.folds}{the cross-validation folds.}
}
\value{
  A list comprising of the following elements:
  \item{R2}{the cross-validated \eqn{R^2}}
  \item{predicted}{the predicted responses}
  \item{observed}{the observed responses}
}
\description{
  Applies cross validation to obtain the cross-validated
  \eqn{R^2} for a model: the fraction of the squared error
  explained by the model compared to the null model (which
  is defined as the average response). A pseudo \eqn{R^2}
  is implemented for classification.
}

