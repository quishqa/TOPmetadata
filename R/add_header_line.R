add_header_line <- function(file_name, attribute, value, append=TRUE){
  if (!append){
    cat(paste0(attribute, ":", value, ";\n"), file=file_name)
  } else {
    cat(paste0(attribute, ":", value, ";\n"), file=file_name, append=append)
  }
}
