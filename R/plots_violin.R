
#' @title Builds a violinplot from a numeric matrix
#' 
#' @description The parameter 'conds' is used to generate the color palette.
#' 
#' @param qData Numeric matrix
#' 
#' @param conds xxx
#' 
#' @param keyId xxx
#' 
#' @param legend A vector of the conditions (one condition per sample).
#' 
#' @param palette xxx
#' 
#' @param subset.view A vector of index indicating rows to highlight
#' 
#' @return A violinplot
#' 
#' @author Samuel Wieczorek, Anais Courtier, Enora Fremy
#' 
#' @examples
#' library(QFeatures)
#' utils::data(Exp1_R25_prot, package='DAPARdata2')
#' qData <- assay(Exp1_R25_prot[[2]])
#' key <- rowData(Exp1_R25_prot[[2]])[[ metadata(Exp1_R25_prot)[['keyId']] ]]
#' conds <- colData(Exp1_R25_prot)[["Condition"]]
#' violinPlotD(qData, conds, key, subset.view = 1:5)
#' 
#' @importFrom vioplot vioplot
#' 
#' @importFrom grDevices colorRampPalette
#' 
#' @importFrom graphics plot.window axis mtext legend points segments plot.new
#' 
#' @importFrom RColorBrewer brewer.pal
#' 
#' @export
#' 
violinPlotD <- function(qData, 
                        conds, 
                        keyId, 
                        legend = NULL, 
                        palette = NULL, 
                        subset.view = NULL){

  
  graphics::plot.new()
  
  if (is.null(qData)) {
    warning('The dataset in NULL and cannot be shown')
    return(NULL)
  }
  

  if(missing(conds))
    stop("'conds' is missing.")
  
  if (is.null(legend)) {
    legend <- conds
    for (i in unique(conds))
      legend[which(conds==i)] <- paste0(i,'_', 1:length(which(conds==i)))
  }
  
  if (!is.null(subset.view)) {
    if (is.null(keyId)|| missing(keyId))
      stop("'keyId' is missing.")
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
  
  graphics::plot.window(xlim=c(0, ncol(qData)+1),
                        ylim=c(min(na.omit(qData)),
                               max(na.omit(qData)))
                        )
  title( ylab="Log (intensity)")
  
  for (i in 1:ncol(qData)) 
    vioplot::vioplot(na.omit(qData[,i]), 
                     col = myColors[i], 
                     add=TRUE, 
                     at=i)

  graphics::axis(2, 
                 yaxp = c(floor(min(na.omit(qData))), 
                          floor(max(na.omit(qData))), 5),
                 las=1)
  
  if( !is.null(legend) ) {
    if ( is.vector(legend) )
      N <- 1
    else
      N <- ncol(legend)

    for (i in 1:N) {
      graphics::axis(side=1,
                     at = 1:ncol(qData),
                     labels = if (is.vector(legend) ) {legend} else {legend[,i]},
                     line= 2*i-1
                     )
    }
    
    graphics::mtext("Samples",
                    side = 1,
                    line = 6+length(colnames(legend)), 
                    cex.lab = 1, 
                    las = 1)
  }
  
  # Display of rows to highlight (index of row in subset.view) 
  if(!is.null(subset.view)){
    idVector <- keyId
    pal.trackProt <- ExtendPalette(length(subset.view), "Dark2")
    
    n=0
    for (i in subset.view) {
      n=n+1
      for (c in 1:(ncol(qData)-1)) {
        graphics::segments(y0=qData[i,c],
                           y1=qData[i,c+1],
                           x0=c,
                           x1=c+1,
                           pch=16,
                           col=pal.trackProt[n],
                           lwd=2
                           )
        graphics::points(y=qData[i,c],
                         x=c,
                         pch=16,
                         col=pal[n]
                         )
      }
      graphics::points(y=qData[i,ncol(qData)],
                       x=ncol(qData),
                       pch=16,
                       col=pal[n]
                       )
    }
    graphics::legend("topleft",
                     legend=idVector[subset.view],
                     lty=1,
                     lwd=2,
                     col=pal,
                     pch=16,
                     bg="transparent",
                     bty="n"
                     )
  }
  
}
