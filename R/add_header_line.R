#' Add header information with meta data
#'
#' @param file_name The file name of exported data
#' @param attribute meta data attribute
#' @param value meta data value
#' @param append add line to the file. TRUE by default.
#'
#' @return meta data in header
#' @noRd
#' @keywords internal
add_header_line <- function(file_name, attribute, value){
  if (attribute == "Station_id"){
    cat(paste0("#", attribute, ": ", value, "\n"), file=file_name)
  } else {
    cat(paste0("#", attribute, ": ", value, "\n"), file=file_name, append=TRUE)
  }
}
