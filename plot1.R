# The data should be in a folder called data. This may be changed if the file is somewhere else.
dirData <- "data/household_power_consumption.txt"

if (file.exists(dirData)) {
  # Column classes are specified beforehand for optimisation
  colClasses <- list()
  colClasses[1:2] = "character"
  colClasses[3:9] = "numeric"
  
  df <- read.csv(dirData, sep = ";", na.strings="?", colClasses = colClasses)
  
  # Reduce the entries in df to make it more manageable
  df <- df[grepl("^(1|2)/2/2007$", df$Date),]
  
  # Convert entries to numeric data type
  colNumeric <- !(names(df) %in% c("Date", "Time"))
  # Warns that some values are NAs. This is expected.
  silent.as.numeric <- function(x) suppressWarnings(as.numeric(x))
  df[, colNumeric] <- apply(df[, colNumeric], 2, silent.as.numeric)
  
  # Creates and saves the histogram as plot1.png
  png(filename = "plot1.png")
  with(df, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "orange"))
  dev.off()
  
} else {
  stop(paste("Could not find", dataDir))
}