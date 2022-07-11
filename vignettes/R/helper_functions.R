
generate_location_data <- function() {

}

convert_nu2mu <- function(nu, kappa, d = getOption("wendland.cov.d_value")) {
  return(nu + kappa + (1+d)/2)
}

