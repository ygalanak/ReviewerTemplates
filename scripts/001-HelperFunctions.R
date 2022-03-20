#-----------------------Project Data Helper Functions---------------------------
#-Author: Yannis Galanakis-------------------------------Created: Feb 06, 2022-#
#-R Version: 4.1.2---------------------------------------Revised: Feb 06, 2022-#

# A Function  for creating a field containing the meta data from a brms object----
stan_metadata <- function(x, ...){
  # Construct a field with relevant metadata
  meta_data <- map_dfr(
    .x = x$fit@stan_args,
    .f = ~ tibble(
      warmup = str_remove_all(.x$time_info[1], "[^[:digit:]|\\.]"),
      sampling = str_remove_all(.x$time_info[2], "[^[:digit:]|\\.]"),
      total = str_remove_all(.x$time_info[3], "[^[:digit:]|\\.]"),
      misc = str_remove_all(.x$time_info[4], "[^[:digit:]|\\.]"),
      metadata = c(
        str_c("stanc_version:", .x$stanc_version[1], sep = " "),
        str_c("opencl_device_name:", .x$opencl_device_name[1], sep = " "),
        str_c("opencl_platform_name", .x$opencl_platform_name[1], sep = " "),
        str_c("date", .x$start_datetime[1], sep = " ")
      )
    ),
    .id = "chain"
  )
  # Return the metadata field
  return(meta_data)
}
