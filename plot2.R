# Read the dataset with necessary manipulations
data_full <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

# Create a single DateTime column combining Date and Time
data_full$DateTime <- as.POSIXct(paste(data_full$Date, data_full$Time), format="%d/%m/%Y %H:%M:%S")

# Subset the data for dates between 2007-02-01 and 2007-02-03 to include Saturday
data_filtered <- subset(data_full, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-03"))

# Filter data for 'Thu', 'Fri', and 'Sat' but use 'Thu' and 'Fri' for plotting
data_filtered_plot <- subset(data_filtered, format(DateTime, "%a") %in% c("Thu", "Fri"))

# Generate plot for 'Thu' and 'Fri', manually add 'Sat' label
png(file = "plot2.png", width = 480, height = 480)
with(data_filtered_plot, {
  plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
  axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
})
dev.off()
