# Read the first row of the text file to get column names
first_row <- readLines("household_power_consumption.txt", n = 1)

# Split the first row into column names (assuming the columns are separated by a delimiter like space, tab, comma, etc.)
column_names <- strsplit(first_row, split = "\\s+")

# Print the column names
print(column_names)



# Read the first row of the text file to get column names
first_row <- readLines("household_power_consumption.txt", n = 1)

# Split the first row into column names using semicolon as delimiter
column_names <- strsplit(first_row, split = ";")[[1]]

# Print the column names
print(column_names)



# Read the dataset using the extracted column names and specifying the semicolon as the delimiter
data <- read.csv("household_power_consumption.txt", header = FALSE, sep = ";", col.names = column_names)

# Convert Date and Time to a single DateTime column
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Subset the data for dates between 2007-02-01 and 2007-02-02
data_sub <- subset(data, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))

# Replace '?' with NA in Global_active_power column
data_sub$Global_active_power[data_sub$Global_active_power == "?"] <- NA

# Convert Global_active_power to numeric
data_sub$Global_active_power <- as.numeric(as.character(data_sub$Global_active_power))

# Create the histogram plot with red bars and 12 breaks, adjusting density
hist_data <- hist(data_sub$Global_active_power[!is.na(data_sub$Global_active_power)], breaks = 12, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", border = "black", density = 100)

# Save the plot as "plot1.png" with specified dimensions
png(file = "plot1.png", width = 480, height = 480)
plot(hist_data, col = "red", border = "black", density = 100, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()


