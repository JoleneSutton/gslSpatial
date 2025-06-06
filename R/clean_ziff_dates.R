#' Clean ziff dates
#'
#' Retains original data columns, and adds columns of updated dates.
#' Step 1) In cases where date.landed was "000000" or was missing, the date.caught is inferred to be the true date landed
#' Step 2) In remaining cases, if date.landed came earlier than date.caught, the date.caught is inferred to be the true date landed
#' Step 3) In cases where date.caught was "000000" or missing, the date.landed.updated is inferred to be the true date caught
#' @param x A data frame with columns 'date.landed' and 'date.caught'
#' @importFrom eclectic make_num_pretty
#' @return Data frame
#' @examples
#' clean_ziff_dates(dat.ziff[1:5,])
#' @export
clean_ziff_dates<-function(x){

  #//////////////////////////////////////////////////////////
  ## fix missing date.landed ----
  #//////////////////////////////////////////////////////////
  # in cases where date.landed was "000000" or empty, the date.caught was used as the date.landed
  ziff<-x

  index<-which(startsWith(ziff$date.landed,"0")|startsWith(ziff$date.landed," "))
  ziff$date.landed.updated<-ziff$date.landed
  ziff[index,"date.landed.updated"]<-ziff[index,"date.caught"]

  message(c("\n",
               paste0(c(eclectic::make_num_pretty(length(index))),
                      " missing 'date.landed' were updated to match 'date.caught'")))

  #//////////////////////////////////////////////////////////
  ## fix if date.caught are after date.landed ----
  #//////////////////////////////////////////////////////////
  DATE_date.caught<-as.Date(as.character(ziff$date.caught),format = "%Y%m%d")
  DATE_date.landed<-as.Date(as.character(ziff$date.landed.updated),format = "%Y%m%d")

  index<-which(DATE_date.landed < DATE_date.caught)

  ##### if the date landed is BEFORE date caught, change date caught to date landed
  ziff[index,"date.landed.updated"]<-ziff[index,"date.caught"]

  message(c("\n",
               paste0(c(eclectic::make_num_pretty(length(index)))," 'date.landed' that came before 'date.caught' were \nupdated to match date.caught")))

  #//////////////////////////////////////////////////////////
  ## fix missing date.caught ----
  #//////////////////////////////////////////////////////////
  # in cases where date.landed was "000000" or empty, the date.caught was used as the date.landed
  index<-which(startsWith(ziff$date.caught,"0")|startsWith(ziff$date.caught," "))

  ziff$date.caught.updated<-ziff$date.caught
  ziff[index,"date.caught.updated"]<-ziff[index,"date.landed.updated"]

  message(c("\n",
               paste0(c(eclectic::make_num_pretty(length(index))),
                      " missing 'date.caught' were updated to match 'date.landed.updated'")))

  #//////////////////////////////////////////////////////////
  ## create year, month, day columns----
  #//////////////////////////////////////////////////////////
  ziff$year.caught.updated<-substring(ziff[,'date.caught.updated'],1,4)
  ziff$month.caught.updated<-substring(ziff[,'date.caught.updated'],5,6)
  ziff$day.caught.updated<-substring(ziff[,'date.caught.updated'],7,8)

  ziff$year.landed.updated<-substring(ziff[,'date.landed.updated'],1,4)
  ziff$month.landed.updated<-substring(ziff[,'date.landed.updated'],5,6)
  ziff$day.landed.updated<-substring(ziff[,'date.landed.updated'],7,8)

  return(ziff)
}
