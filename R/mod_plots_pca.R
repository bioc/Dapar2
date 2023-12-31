#' plots_pca UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#'
mod_plots_pca_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("WarningNA_PCA")),
    uiOutput(ns("pcaOptions")),
    uiOutput(ns("pcaPlots"))
  )
}

#' plots_pca Server Function
#'
#' @noRd
#'
#' @importFrom SummarizedExperiment assay
#'
mod_plots_pca_server <- function(id,
                                 obj,
                                 coldata) {

  moduleServer(id, function(input, output, session){
    ns <- session$ns


    rv.pca <- reactiveValues(
      PCA_axes =NULL,
      res.pca = NULL,
      PCA_varScale = NULL
    )


    output$WarningNA_PCA <- renderUI({


      if (length(which(is.na(SummarizedExperiment::assay(obj())))) > 0) {
        req(obj())

        tagList(
          tags$p("Warning: As your dataset contains missing values, the PCA cannot be computed.
               Please impute them first.",
                 style="color:red;font-size: 20px")
        )
      }
    })



    output$pcaOptions <- renderUI({
      if (length(which(is.na(SummarizedExperiment::assay(obj())))) == 0) {
        req(obj())
        req(rv.pca$res.pca)

        tagList(

          tags$div(
            tags$div( style="display:inline-block; vertical-align: middle;padding-right: 20px;",
                      numericInput(ns('pca.axe1'), "Dimension 1", min=1, max=Compute_PCA_dim(),value=1,width='100px')
            ),
            tags$div( style="display:inline-block; vertical-align: middle;",
                      numericInput(ns('pca.axe2'), "Dimension 2", min=1, max=Compute_PCA_dim(),value=2,width='100px')
            ),
            tags$div( style="display:inline-block; vertical-align: middle; padding-right: 20px;",
                      checkboxInput(ns('varScale_PCA'), "Variance scaling", value=rv.pca$PCA_varScale))
          )
        )
      }
    })


    observeEvent(c(input$pca.axe1,input$pca.axe2),{
      rv.pca$PCA_axes <- c(input$pca.axe1,input$pca.axe2)
    })


    observeEvent(input$varScale_PCA,{
      rv.pca$PCA_varScale <- input$varScale_PCA
      rv.pca$res.pca <- Dapar2::wrapper.pca(SummarizedExperiment::assay(obj()),
                                            coldata()[["Condition"]],
                                            rv.pca$PCA_varScale,
                                            ncp=Compute_PCA_dim())
    })

    observeEvent(obj(), {
      if (length(which(is.na(SummarizedExperiment::assay(obj())))) == 0) {
        rv.pca$res.pca <- Dapar2::wrapper.pca(SummarizedExperiment::assay(obj()),
                                              coldata()[["Condition"]],
                                              rv.pca$PCA_varScale,
                                              ncp=Compute_PCA_dim())
      }
    })


    output$pcaPlots <- renderUI({
      if (length(which(is.na(SummarizedExperiment::assay(obj())))) == 0) {
        req(obj())
        req(rv.pca$res.pca)

        tagList(
          fluidRow(
            column(width=6,  plotOutput(ns("pcaPlotVar"))),
            column(width=6,  plotOutput(ns("pcaPlotInd")))
          ),
          fluidRow(
            column(width=6,  highchartOutput(ns("pcaPlotEigen"))),
            column(width=6,  mod_format_DT_ui(ns("PCAvarCoord")))
          )
        )
      }
    })


    output$pcaPlotVar <- renderPlot({
      req(rv.pca$PCA_axes)
      req(rv.pca$res.pca)
      withProgress(message = 'Making plot', value = 100, {
        Dapar2::plotPCA_Var(rv.pca$res.pca, rv.pca$PCA_axes)
      })
    })

    output$pcaPlotInd <- renderPlot({
      req(rv.pca$PCA_axes)
      req(rv.pca$res.pca)
      withProgress(message = 'Making plot', value = 100, {
        Dapar2::plotPCA_Ind(rv.pca$res.pca, rv.pca$PCA_axes)
      })
    })


    output$pcaPlotEigen <- renderHighchart({
      req(rv.pca$res.pca)

      withProgress(message = 'Making plot', value = 100, {
        Dapar2::plotPCA_Eigen_hc(rv.pca$res.pca)
      })
    })

    mod_format_DT_server("PCAvarCoord",
                         table2show=reactive({ if (!is.null(rv.pca$res.pca)) as.data.frame(round(rv.pca$res.pca$var$coord, digits=7)) }),
                         showRownames=TRUE,
                         #style=reactive({NULL})
                         style = reactive({ list(cols = colnames(rv.pca$res.pca$var$coord),
                                                 vals = colnames(rv.pca$res.pca$var$coord),
                                                 unique = unique(coldata()[['Condition']]),
                                                 pal = RColorBrewer::brewer.pal(3,'Dark2')[1:2])})
    )
    # style = reactive({ list(cols = colnames(colData(obj)),
    #                         vals = colnames(colData(obj))[2],
    #                         unique = unique(colData(obj)$Condition),
    #                         pal = RColorBrewer::brewer.pal(3,'Dark2')[1:2])}))



    Compute_PCA_dim <- reactive({
      nmax <- 12 # ncp should not be greater than...
      # for info, ncp = number of components or dimensions in PCA results

      y <- SummarizedExperiment::assay(obj())
      nprot <- dim(y)[1]
      n <- dim(y)[2] # If too big, take the number of conditions.

      if (n > nmax){
        n <- length(unique(coldata()[["Condition"]]))
      }

      ncp <- min(n, nmax)
      ncp
    })

  })

}

## To be copied in the UI
# mod_plots_pca_ui("plots_pca_ui_1")

## To be copied in the server
# callModule(mod_plots_pca_server, "plots_pca_ui_1")

