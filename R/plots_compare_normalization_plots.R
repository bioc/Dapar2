
#' @title Builds a plot from a numeric matrix.
#' 
#' @description 
#' This plot compares the quantitative proteomics data before and after 
#' normalization
#' 
#' @param qDataBefore A numeric matrix containing quantitative data before normalization.
#' 
#' @param qDataAfter A numeric matrix containing quantitative data after normalization.
#' 
#' @param conds A vector of the conditions (one condition per sample).
#' 
#' @param keyId xxx
#' 
#' @param palette xxx
#' 
#' @param subset.view xxx
#' 
#' @param n xxx
#' 
#' @param type scatter or line
#' 
#' @return A plot
#' 
#' @author Samuel Wieczorek, Enora Fremy
#' 
#' @examples
#' library(QFeatures)
#' utils::data(Exp1_R25_pept, package='DAPARdata2')
#' obj <- Exp1_R25_pept[1:1000,]
#' conds <- colData(obj)$Condition
#' id <- metadata(obj)$keyId
#' obj <- normalizeD(obj, 2, name='norm', method='SumByColumns', conds=conds, type='overall')
#' palette <- ExtendPalette(2, "Dark2")
#' qBefore <- assay(obj, 2)
#' qAfter <- assay(obj, 3)
#' compareNormalizationD_HC(qBefore, qAfter, conds=conds, n=100)
#' compareNormalizationD_HC(qBefore, qAfter, conds=conds, keyId = id, n=100, palette=palette)
#' 
#' @import highcharter
#' @importFrom RColorBrewer brewer.pal
#' @importFrom tibble as_tibble
#' @importFrom utils str
#' 
#' @export
#' 
compareNormalizationD_HC <- function(qDataBefore,
                                     qDataAfter,
                                     conds,
                                     keyId = NULL,
                                     palette = NULL,
                                     subset.view = NULL,
                                     n = 100,
                                     type = 'scatter'){
  
  if (missing(qDataBefore))
    stop("'qDataBefore' is missing")
  
  if (missing(qDataAfter))
    stop("'qDataAfter' is missing")
  
  if (missing(conds))
    stop("'conds' is missing")
 
  if (is.null(keyId))
    keyId <- 1:length(qDataBefore)
  
  
  if (!is.null(subset.view) && length(subset.view) > 0)
  {
    keyId <- keyId[subset.view]
    if (nrow(qDataBefore) > 1)
      if (length(subset.view)==1){
        qDataBefore <- t(qDataBefore[subset.view,])
        qDataAfter <- t(qDataAfter[subset.view,])
      } else {
        qDataBefore <- qDataBefore[subset.view,]
        qDataAfter <- qDataAfter[subset.view,]
      }
  } 
  # else {
  #       qDataBefore <- as_tibble(cbind(t(qDataBefore)))
  #       qDataAfter <- as_tibble(cbind(t(qDataAfter)))
  # }
  
  
  if (!match(type, c('scatter', 'line') )){
    warning("'type' must be equal to 'scatter' or 'line'.")
    return(NULL)
  }
  
  # browser()
  if (is.null(n)){
    n <- seq_len(nrow(qDataBefore))
  } else {
    if (n > nrow(qDataBefore)){
      warning("'n' is higher than the number of rows of datasets. Set to number 
              of rows.")
      n <- nrow(qDataBefore)
    }
    
    ind <- sample(seq_len(nrow(qDataBefore)),n)
    keyId <- keyId[ind]
    if (nrow(qDataBefore) > 1)
      if (length(ind) == 1){
        # qDataBefore <- as_tibble(cbind(t(qDataBefore[ind,])))
        # qDataAfter <- as_tibble(cbind(t(qDataAfter[ind,])))
        qDataBefore <- t(qDataBefore[ind,])
        qDataAfter <- t(qDataAfter[ind,])
      } else {
        #qDataBefore <- as_tibble(cbind(qDataBefore[ind,]))
        # qDataAfter <- as_tibble(cbind(qDataAfter[ind,]))
        qDataBefore <- qDataBefore[ind,]
        qDataAfter <- qDataAfter[ind,]
      }
  }
  
  myColors <- NULL
  if (is.null(palette)){
    warning("Color palette set to default.")
    myColors <-   GetColorsForConditions(conds, ExtendPalette(length(unique(conds))))
  } else {
    if (length(palette) != length(unique(conds))){
      warning("The color palette has not the same dimension as the number of samples")
      myColors <- GetColorsForConditions(conds, ExtendPalette(length(unique(conds))))
    } else 
      myColors <- GetColorsForConditions(conds, palette)
  }
  
  x <- qDataBefore
  y <- qDataAfter/qDataBefore
  
  ##Colors definition
  legendColor <- unique(myColors)
  txtLegend <- unique(conds)
  
  
  series <- list()
  for (i in 1:length(conds)){
    series[[i]] <- list(name=colnames(x)[i],
                        data =list_parse(data.frame(x = x[,i],
                                                    y = y[,i],
                                                    name=keyId)
                        )
    )
  }
  
  h1 <-  highchart() %>% 
    dapar_hc_chart( chartType = type) %>%
    hc_add_series_list(series) %>%
    hc_colors(myColors) %>%
    hc_tooltip(headerFormat= '',pointFormat = "Id: {point.name}") %>%
    dapar_hc_ExportMenu(filename = "compareNormalization")
  h1
  
  
}

