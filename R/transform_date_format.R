transform_date_format <- function(df, date_format="%Y-%m-%d %H:%M",
                                  date_col = "date"){
  if (class(df[[date_col]])[1] == "character"){
    df$date <- as.POSIXct(strptime(df[[date_col]], format=date_format))
    df$date <- format(df[[date_col]], format="%d/%m/%Y %H:%M")
  }
  if (class(df[[date_col]])[1] == "POSIXct"){
    df$date <- format(df[[date_col]], format = "%d/%m/%Y %H:%M")
  }
  return(df)
}
