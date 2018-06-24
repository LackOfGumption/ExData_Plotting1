# The data should be in a folder called data. This may be changed if the file is somewhere else.
dirData <- "data/household_power_consumption.txt"

if (file.exists(dirData)) {
  # Column classes are specified beforehand for optimisation
  colClasses <- list()
  colClasses[1:2] = "character"
  colClasses[3:9] = "numeric"
  
  df <- read.csv(dirData, sep = ";", na.strings = "?", colClasses = colClasses)
  
  # Reduce the entries in df to make it more manageable
  df <- df[grepl("^(1|2)/2/2007$", df$Date),]
  
  # Convert Date and Time to proper Date/Time datatype
  df$DateTime <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
  
  png("plot2.png")
  plot(df$DateTime, df$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
  dev.off()
  
} else {
  stop(paste("Could not find", dataDir))
}
