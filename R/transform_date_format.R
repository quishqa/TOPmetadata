#' Transform date format from the original data frame
#'
#' @param df A data frame with date and pollutant data.
#' @param date_format The format of date data. Default is "%Y-%m-%d %H:%M".
#' @param date_col Name of column with date data
#'
#' @return data frame with TOP format
#' @noRd
#' @keywords internal
transform_date_format <- function(df, date_format="%Y-%m-%d %H:%M",
                                  date_col = "date"){
  if (class(df[[date_col]])[1] == "character"){
    df$date <- as.POSIXct(strptime(df[[date_col]], format=date_format))
    df$date <- format(df$date, format="%Y-%m-%d %H:%M")
  }
  if (class(df[[date_col]])[1] == "POSIXct"){
    df$date <- format(df[[date_col]], format = "%Y-%m-%d %H:%M")
  }
  return(df)
}
