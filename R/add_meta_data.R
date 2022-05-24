#' Add air quality station meta data to pollutant data
#'
#' @param df A data frame with date and pollutant data.
#' @param pol Pollutant column name
#' @param aqs_meta A vector with key value pairs.
#' @param date_format  The format of date data. Default is "%Y-%m-%d %H:%M".
#' @param date_col Name of column with date data.
#' @param csv_path Path to save the csv file. Default is working directory.
#'
#' @return csv file
#' @export
#'
#' @examples
#' \dontrun{
#' library(Dict)
#' pin_o3 <- readRDS("~/R_tests/pin_meta_test.rds")
#' pin_meta <- c(
#'   "Station_id" = "0001",
#'   "Station_country" = "Brazil",
#'   "Station_city" = "Sao Paulo",
#'   "Station_name" = "Pinheiros",
#'   "Station_timezone" = Sys.timezone(),
#'   "Timeshift_from_UTC" = as.POSIXlt(Sys.time())$zone
#' )
#'
#' add_met_data(pin_o3, "o3", "%Y-%m-%d %H:%M", "date", pin_meta,
#'             csv_path = "~/")
#' }
add_met_data <- function(df, pol, aqs_meta, date_format = "%Y-%m-%d %H:%M",
                         date_col = "date", csv_path=getwd()){
  # Tranforming date to require format
  df_date <- transform_date_format(df, date_format, date_col)
  df <- df_date[, c("date", pol)]

  # Creating file_name
  start_year <- regmatches(df$date[1], regexpr("[0-9]{4}", df$date[1]))
  end_year <- regmatches(df$date[nrow(df)],
                         regexpr("[0-9]{4}", df$date[nrow(df)]))
  file_name <- paste0(toupper(pol), "_", aqs_meta["Station_id"], "_",
                      start_year, "_", end_year, ".csv")
  file_name <- paste0(csv_path, "/", file_name)

  # Adding attributes
  add_header_line(file_name, "Station_id", aqs_meta["Station_id"])
  for (key in names(aqs_meta)){
    add_header_line(file_name, key, aqs_meta[key])
  }
  cat(paste0("\"Time; value\";", toupper(pol), "\n"), file = file_name,
      append = TRUE)
  utils::write.table(df, file_name, sep=";", row.names = FALSE,
                     col.names = FALSE, append = TRUE)
  message(paste(file_name), " was created")
}
