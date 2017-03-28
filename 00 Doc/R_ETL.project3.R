require(readr)

#-----------------------FILE ONE------------------------------------------

file_path = "../01 Data/PreETL_ConfidenceHomeStats.csv"
chs <- readr::read_csv(file_path)
names(chs)

df <- chs
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.

measures <- c("Home_Sales_Avg", "Year_Avgs", "Home_Price_Avg", "CCI_AVG")

dimensions <- setdiff(names(df), measures)
dimensions

# Get rid of special characters in each column.
# Google ASCII Table to understand the following:
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="[^ -~]",replacement= ""))
}

str(df)
# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

na2emptyString <- function (x) {
  x[is.na(x)] <- ""
  return(x)
}
if( length(dimensions) > 0) {
  for(d in dimensions) {
    # Change NA to the empty string.
    df[d] <- data.frame(lapply(df[d], na2emptyString))
    # Get rid of " and ' in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern=":",replacement= ";"))
  }
}

na2zero <- function (x) {
  x[is.na(x)] <- 0
  return(x)
}
# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions, and change NA to 0.
if( length(dimensions) > 1) {
  for(m in dimensions) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x)))
 # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}

str(df)

write.csv(df, gsub("PreETL_", "", file_path), row.names=FALSE, na = "")

#-----------------------FILE TWO----------------------------------------

file_path = "../01 Data/PreETL_KEI_Avg.csv"
kavg <- readr::read_csv(file_path)
names(kavg)

df <- kavg
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.

measures <- c("Year_Avg", "Unemployment_U_S__Avg", "CCI_US__Avg", "Consumer_Confidence_Index_US", "Unemployment_U_S_")

#measures <- NA # Do this if there are no measures.

dimensions <- setdiff(names(df), measures)
dimensions

# Get rid of special characters in each column.
# Google ASCII Table to understand the following:
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="[^ -~]",replacement= ""))
}

str(df)
# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

na2emptyString <- function (x) {
  x[is.na(x)] <- ""
  return(x)
}
if( length(dimensions) > 0) {
  for(d in dimensions) {
    # Change NA to the empty string.
    df[d] <- data.frame(lapply(df[d], na2emptyString))
    # Get rid of " and ' in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern=":",replacement= ";"))
  }
}

na2zero <- function (x) {
  x[is.na(x)] <- 0
  return(x)
}
# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions, and change NA to 0.
if( length(dimensions) > 1) {
  for(m in dimensions) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x))) # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}
df["Year_Avg"] <- lapply(df["Year_Avg"], function(x) as.numeric(as.character(x)))
str(df)

write.csv(df, gsub("PreETL_", "", file_path), row.names=FALSE, na = "")

#-----------------------FILE THREE----------------------------------------

file_path = "../01 Data/PreETL_unemploymentTXandUSA_Ding.csv"
ding <- readr::read_csv(file_path)
names(ding)

df <- ding
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.

measures <- c("Unemployment_TX", "Unemployment_US", "ddate")
dates <- c("date")


dimensions <- setdiff(names(df), measures)
dimensions

# Get rid of special characters in each column.
# Google ASCII Table to understand the following:
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="[^ -~]",replacement= ""))
}

str(df)
# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

na2emptyString <- function (x) {
  x[is.na(x)] <- ""
  return(x)
}
if( length(dimensions) > 0) {
  for(d in dimensions) {
    # Change NA to the empty string.
    df[d] <- data.frame(lapply(df[d], na2emptyString))
    # Get rid of " and ' in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern=":",replacement= ";"))
  }
}

na2zero <- function (x) {
  x[is.na(x)] <- 0
  return(x)
}
# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions, and change NA to 0.
if( length(measures) > 1) {
  for(m in measures) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x))) # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}
if( length(dates) > 0) {
  for(d in dates) {
    print(d)
    df[d] <- data.frame(lapply(df[d],function(x) as.Date(x, "%m/%d/%Y")))
  }
}

str(df)

d_subset = df[,c(2,3,4,5)]
write.csv(d_subset, gsub("PreETL_", "", file_path), row.names=FALSE, na = "")
