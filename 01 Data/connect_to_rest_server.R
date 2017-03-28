require("jsonlite")
require("RCurl")
require("ggplot2")

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5018/rest/native/?query="select * from dataset"')),httpheader=c(DB='jdbc:data:world:sql:chriscrider:s-17-edv-project-3', USER='enter_username', PASS='redacted', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))