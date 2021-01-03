
#### Functions to average volumes once extracted ####

#' Prepare for Averaging by Decade
#'
#' This function cleans the saved NEMO-MEDUSA monthly summaries, for averaging into decades.
#'
#' @param array A dataframe containing a summarised month from NEMO-MEDUSA model outputs.
#' @param scheme A dataframe containing a summarised month from NEMO-MEDUSA model outputs.
#' @return A dataframe containing a summarised month of NEMO-MEDUSA output, gaining a decade column, and dropping columns
#' which aren't needed for spatial maps.
#' @family NEMO-MEDUSA averages
#' @export
slab <- function(array, scheme, fun = "weighted mean") {

if(!fun %in% c("weighted mean")) stop("summary operation not supported. Choose from 'mean' or 'weighted mean'")  
  
if(fun == "weighted mean") summary <- array_w_mean(array, scheme)

  return(summary)
}
