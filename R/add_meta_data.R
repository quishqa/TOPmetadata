#' Add air quality station meta data to pollutant data
#'
#' @param df A data frame with date and pollutant data.
#' @param pol Pollutant column name
#' @param date_format  The format of date data. Default is "%Y-%m-%d %H:%M".
#' @param date_col Name of column with date data.
#' @param id Air quality station id code.
#' @param from_here Get local information from your pc.
#' @param csv_path Path to save the csv file. Default is working directory.
#'
#' @return csv file
#' @export
#'
#' @examples
#' \dontrun{
#' add_met_data(df, "o3", "%Y-%m-%d %H:%M", "date", aqs_code)
#' }
add_met_data <- function(df, pol, date_format, date_col, id, from_here=TRUE,
                         csv_path=getwd()){
  # Tranforming date to require format
  df_date <- transform_date_format(df, date_format, date_col)
  df <- df_date[, c("date", pol)]

  # Creating file_name
  start_year <- regmatches(df$date[1], regexpr("[0-9]{4}", df$date[1]))
  end_year <- regmatches(df$date[nrow(df)],
                         regexpr("[0-9]{4}", df$date[nrow(df)]))
  file_name <- paste0(toupper(pol), "_", id, "_",
                      start_year, "_", end_year, ".csv")
  file_name <- paste0(csv_path, "/", file_name)

  # Adding attributes
  add_header_line(file_name, "Station_id", id, append = FALSE)
  if (from_here){
    add_header_line(file_name, "Station_timezone", Sys.timezone())
    add_header_line(file_name, "Timeshift_from_UTC",
                    as.POSIXlt(Sys.time())$zone)
  }
  cat(paste0("\"Time; value\"", toupper(pol), "\n"), file = file_name,
      append = TRUE)
  utils::write.table(df, file_name, sep=";", row.names = FALSE,
                     col.names = FALSE, append = TRUE)
  message(paste(file_name), "was created")
}
