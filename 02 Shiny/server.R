require(dplyr)
require(ggplot2)

require("jsonlite")
require("RCurl")
require("ggplot2")

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:1234/rest/native/?query="select * from KEI_Avg"')),httpheader=c(DB='jdbc:data:world:sql:chriscrider:s-17-edv-project-3', USER='gonzalez', PASS='eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OmdvbnphbGV6IiwiaXNzIjoiYWdlbnQ6Z29uemFsZXo6OmMwN2RkYmNkLTU3ZmEtNDBkNi04MzQwLTQ0NzJlYzI0OTBiMiIsImlhdCI6MTQ4NDY5NzMxOSwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.5mTuKVcV8fKTtPvvxxcyo-5TBGLGufXDQkIraPgCsuB4hc7mUj_editztVly63Yr4jxmvyvI-kUu07EvQnuZYw', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))


server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(df) + geom_point(aes(x=v_3, y=v_4, size=4)) + guides(size=FALSE)+xlab("Year")+ylab("Unemployment Rate")
  })
  
  output$plot2 <- renderPlot({
    brush = brushOpts(id="plot_brush", delayType = "throttle", delay = 30)
    bdf=brushedPoints(df, input$plot_brush)
    if( !is.null(input$plot_brush) ) {
      df %>% dplyr::filter(v_3 %in% bdf[, "v_3"]) %>% ggplot() + geom_point(aes(x=v_3, y=v_4, size=4)) + guides(size=FALSE)+xlab("Year")+ylab("Unemployment Rate")
    } 
  })
}

