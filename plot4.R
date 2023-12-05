# Read the dataset and perform necessary manipulations...
data_full <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

# Create a single DateTime column combining Date and Time
data_full$DateTime <- as.POSIXct(paste(data_full$Date, data_full$Time), format="%d/%m/%Y %H:%M:%S")

# Subset the data for dates between 2007-02-01 and 2007-02-03 to include Saturday
data_filtered <- subset(data_full, as.Date(data_full$DateTime) >= as.Date("2007-02-01") & as.Date(data_full$DateTime) <= as.Date("2007-02-03"))

# Filter data for 'Thu', 'Fri', and 'Sat' but use 'Thu' and 'Fri' for plotting
data_filtered_plot <- subset(data_filtered, format(data_filtered$DateTime, "%a") %in% c("Thu", "Fri"))

# Save the plot as "plot4.png" with specified dimensions
png(file = "plot4.png", width = 480, height = 480)

# Set up the plot layout
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Create the plots with days as x-axis labels and 'Sat' for Saturday
with(data_filtered_plot, {
  plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n")
  axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
  
  plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
  axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
  
  plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
  lines(Sub_metering_2 ~ DateTime, col = 'Red')
  lines(Sub_metering_3 ~ DateTime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
  
  plot(Global_reactive_power ~ DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
  axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
})

# Save the plot
dev.off()
