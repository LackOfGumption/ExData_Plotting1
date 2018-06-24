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
  colNumeric <- !(grepl("(Date|Time)", names(df)))
  # Warns that some values are NAs. This is expected.
  silent.as.numeric <- function(x) suppressWarnings(as.numeric(x))
  df[, colNumeric] <- apply(df[, colNumeric], 2, silent.as.numeric)
  
  # Convert Date and Time to proper Date/Time datatype
  df$DateTime <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
  
  # Creates and saves the histogram as plot1.png
  png(filename = "plot4.png")
  par(mfrow = c(2, 2))
  par(mar = as.list(rep(4, 4)))
  # Top left plot
  plot(df$DateTime, df$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
  # Top right plot
  plot(df$DateTime, df$Voltage, type="l", xlab = "", ylab = "Voltage")
  # Bottom left plot
  plot(df$DateTime, df$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
  lines(df$DateTime, df$Sub_metering_2, type="l", col = "red", lty = 2)
  lines(df$DateTime, df$Sub_metering_3, type="l", col = "blue", lty = 3)
  legend("topright", legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col = c("black", "red", "blue"), lty = 1:3, cex = 0.7)
  # Bottom right plot
  plot(df$DateTime, df$Global_reactive_power, type = 'l', xlab = "", ylab = "Global reactive power")
  dev.off()
  
} else {
  stop(paste("Could not find", dataDir))
}