#' Metadata template
#'
#' Load the metadata template to fill in the blanks
#'
#' @return a character vector with key names
#' @export
#'
#' @examples
#' \dontrun{
#' my_meta <- load_meta_template()
#' }
load_meta_template <- function(){
  aqs_meta <- c(
    "Station_id" = "",
    "Station_country" = "",
    "Station_Local_id" = "",
    "Station_name" = "",
    "Station_city" = "",
    "Station_timezone" = "",
    "Station_lon" = "",
    "Station_lat" = "",
    "Station_alt" = "",
    "Station_type" = "",
    "Time_reporting" = "",
    "Station_type_of_area" = "",
    "Station_category" = "",
    "Timeshift_from_UTC" = "",
    "Station_climatic_zone" = "",
    "Station_htap_region" = "",
    "Station_reported_alt" = "",
    "Station_dominant_landcover" = "",
    "Contributor" = "",
    "Contributor_shortname" = "",
    "Contributor_country" = "",
    "Dataset_PI" = "",
    "Dataset_PI_email" = "",
    "Sampling_type" = "",
    "Measurement_method" = "",
    "Instrument_manufacturer" = "",
    "Instrument_model" = "",
    "Original_units" = "",
    "Calibration" = ""
  )
  return(aqs_meta)
}
