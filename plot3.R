# Read the dataset and perform necessary manipulations...
data_full <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

# Create a single DateTime column combining Date and Time
data_full$DateTime <- as.POSIXct(paste(data_full$Date, data_full$Time), format="%d/%m/%Y %H:%M:%S")

# Subset the data for dates between 2007-02-01 and 2007-02-03 to include Saturday
data_filtered <- subset(data_full, as.Date(data_full$DateTime) >= as.Date("2007-02-01") & as.Date(data_full$DateTime) <= as.Date("2007-02-03"))

# Filter data for 'Thu', 'Fri', and 'Sat' but use 'Thu' and 'Fri' for plotting
data_filtered_plot <- subset(data_filtered, format(data_filtered$DateTime, "%a") %in% c("Thu", "Fri"))

# Plot 3: Three lines representing different variables for 'Thu' and 'Fri'
png(file = "plot3.png", width = 480, height = 480)
with(data_filtered_plot, {
  plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
  lines(Sub_metering_2 ~ DateTime, col = 'Red')
  lines(Sub_metering_3 ~ DateTime, col = 'Blue')
  axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), 
       labels = c("Thu", "Fri", "Sat"))
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
