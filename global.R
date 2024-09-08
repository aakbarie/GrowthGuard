

# global.R


# Age function ------------------------------------------------------------

#' Calculate age
#' 
#' By default, calculates the typical "age in years", with a
#' \code{floor} applied so that you are, e.g., 5 years old from
#' 5th birthday through the day before your 6th birthday. Set
#' \code{floor = FALSE} to return decimal ages, and change \code{units}
#' for units other than years.
#' @param dob date-of-birth, the day to start calculating age.
#' @param age.day the date on which age is to be calculated.
#' @param units unit to measure age in. Defaults to \code{"years"}. Passed to \link{\code{duration}}.
#' @param floor boolean for whether or not to floor the result. Defaults to \code{TRUE}.
#' @return Age in \code{units}. Will be an integer if \code{floor = TRUE}.
#' @examples
#' my.dob <- as.Date('1983-10-20')
#' age(my.dob)
#' age(my.dob, units = "minutes")
#' age(my.dob, floor = FALSE)
age <- function(dob, age.day = today(), units = "months", floor = TRUE) {
  calc.age = interval(dob, age.day) / duration(num = 1, units = units)
  if (floor) return(as.integer(floor(calc.age)))
  return(calc.age)
}

#' Get age
#' 
#' Returns age, decimal or not, from single value or vector of strings
#' or dates, compared to a reference date defaulting to now. Note that
#' default is NOT the rounded value of decimal age.
#' @param from_date vector or single value of dates or characters
#' @param to_date date when age is to be computed
#' @param dec return decimal age or not
#' @examples
#' get_age("2000-01-01")
#' get_age(lubridate::as_date("2000-01-01"))
#' get_age("2000-01-01","2015-06-15")
#' get_age("2000-01-01",dec = TRUE)
#' get_age(c("2000-01-01","2003-04-12"))
#' get_age(c("2000-01-01","2003-04-12"),dec = TRUE)
get_age <- function(from_date,to_date = lubridate::now(),dec = FALSE){
  if(is.character(from_date)) from_date <- lubridate::as_date(from_date)
  if(is.character(to_date))   to_date   <- lubridate::as_date(to_date)
  if (dec) { age <- lubridate::interval(start = from_date, end = to_date)/(lubridate::days(365)+lubridate::hours(6))
  } else   { age <- lubridate::year(lubridate::as.period(lubridate::interval(start = from_date, end = to_date)))}
  age
}

