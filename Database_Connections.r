library(DBI)
library(odbc)
library(readr)
library(magrittr)
library(dplyr)
library(dbplyr)

#----------Connect to Access------------#

db_path <- "data/Trees.accdb"
conn_string <- paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=", db_path)

conn <- dbConnect(odbc(), .connection_string = conn_string)

data <- tbl(conn, "tbl_Trees") %>%
  collect()

# Common tidying operations:
data <- mutate_if(data, is.character, trimws) %>%
  mutate_if(is.character, dplyr::na_if, "")

# Close the connection as soon as you no longer need it, otherwise you will get weird errors
dbDisconnect(conn)


