\name{generalizedwendland-internal}
\alias{generalizedwendland-internal}
\alias{isEmptyList}
\alias{isValidRstruct}
\alias{control.wendland}
\alias{control.askey}
\alias{mapPars.Wend2Askey}
\title{Internal Functions defined in package \pkg{GeneralizedWendland}}

\description{
  The functions or variables listed here are used internally, i.e. they are
  not intended to be called directly by the user. Hence they're not exported
  by NAMESPACE.
}

\section{Internal function definitions}{
  \describe{
    \item{\code{isEmptyList(list)}:}{
      Checks if input list is empty.
    }

    \item{\code{isValidRstruct(Rstruct)}:}{
      Checks if Rstruct is a valid \code{spam.chol.NgPeyton} object.
    }

    \item{\code{control.wendland}}{
      Takes as input any relevant parameters for the generalized
      Wendland covariance function, inserts default arguments where
      parameters were left unspecified, and returns a list.
    }

    \item{\code{control.askey}}{
      Takes as input any relevant parameters for the Askey covariance,
      inserts default arguments where left unspecified, and returns a list.
    }

    \item{\code{mapPars.Wend2Askey}}{
      Takes as input a vector of parameters for \code{cov.wendland()} and
      drops the argument korresponding to parameter kappa.
    }
  }
}


\keyword{internal}