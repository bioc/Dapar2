library(shiny)
library(highcharter)
library(SummarizedExperiment)


source(file.path("../../../R","mod_plots_var_dist.R"), local=TRUE)$value
source(file.path("../../../R","mod_popover_for_help.R"), local=TRUE)$value


ui <- fluidPage(
  mod_plots_var_dist_ui('varDistPlot')
)



server <- function(input, output, session) {

  utils::data(Exp1_R25_prot, package='DAPARdata2')

  obj <- Exp1_R25_prot[[2]][1:1000,]
  conds <- SummarizedExperiment::colData(Exp1_R25_prot)[["Condition"]]

  mod_plots_var_dist_server('varDistPlot',
                            obj = reactive({obj}),
                            conds = reactive({conds}),
                            base_palette = reactive({Dapar2::Example_Palette(conds, Dapar2::Base_Palette(conditions = conds))}))
}


shinyApp(ui=ui, server=server)
