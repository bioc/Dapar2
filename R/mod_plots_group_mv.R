# Module UI

#' @title   mod_plots_group_mv_ui and mod_plots_group_mv_server
#'
#' @description  A shiny Module.
#'
#' @param id shiny id
#'
#' @param input internal
#'
#' @param output internal
#'
#' @param session internal
#'
#' @rdname mod_plots_group_mv
#'
#' @keywords internal
#'
#' @export
#'
#' @importFrom shiny NS tagList
#' @importFrom highcharter highchartOutput
#'
mod_plots_group_mv_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 4, highchartOutput(ns("histo_MV")), height="600px"),
      column(width = 4, highchartOutput(ns("histo_MV_per_lines"))),
      column(width = 4, highchartOutput(ns("histo_MV_per_lines_per_conditions")))
    )
  )
}

# Module Server

#' @rdname mod_plots_group_mv
#'
#' @param id xxx
#' @param obj xxx
#' @param conds xxx
#' @param base_palette xxx
#'
#' @export
#'
#' @keywords internal
#'
#' @importFrom SummarizedExperiment assay
#' @import highcharter
#'
mod_plots_group_mv_server <- function(id, obj, conds, base_palette){

  moduleServer(id, function(input, output, session){
    ns <- session$ns


    observe({
      req(obj())
      if (class(obj()) != "SummarizedExperiment") { return(NULL) }
    })



    output$histo_MV <- renderHighchart({
      req(obj())
      conds()
      base_palette()

      withProgress(message = 'Making plot', value = 100, {
        tmp <- Dapar2::mvHisto_HC(SummarizedExperiment::assay(obj()),
                                  conds=conds(),
                                  palette=Dapar2::Base_Palette(conditions = conds()))
      })
      tmp
    })



    output$histo_MV_per_lines <- renderHighchart({
      req(obj())
      conds()

      isolate({
        withProgress(message = 'Making plot', value = 100, {
          tmp <- Dapar2::mvPerLinesHisto_HC(SummarizedExperiment::assay(obj()),
                                            conds())
        })
      })
      tmp
    })




    output$histo_MV_per_lines_per_conditions <- renderHighchart({
      req(obj())
      conds()
      base_palette()

      withProgress(message = 'Making plot', value = 100, {
        tmp <- Dapar2::mvPerLinesHistoPerCondition_HC(SummarizedExperiment::assay(obj()),
                                                      samplesData = conds(),
                                                      palette = Dapar2::Base_Palette(conditions = conds()))
      })
      tmp
    })


  })


}

## To be copied in the UI
# mod_plots_group_mv_ui("plots_group_mv_ui_1")

## To be copied in the server
# callModule(mod_plots_group_mv_server, "plots_group_mv_ui_1")

