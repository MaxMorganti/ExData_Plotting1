#Read in and format data - approximate where to start so don't have to read whole file
my_data <- read.table('household_power_consumption.txt', sep = ';', na.strings = '?', header = TRUE, skip = 63630, 
                      nrows = 50000)
my_data$datetime <- paste(my_data[,1], my_data[,2])
my_data <- my_data[,-c(1:2)]
names(my_data) <- c('glb_active_pow', 'glb_reactive_pow','voltage', 'glb_intensity', 'meter1', 'meter2',
                    'meter3', 'datetime')
my_data[,'datetime'] <- as.POSIXct(my_data[,'datetime'], format ="%d/%m/%Y %H:%M:%S")
#Subset proper time interval
plot_time <- subset(my_data, as.Date(datetime, tz = '') == "2007-02-01" | as.Date(datetime, tz = '') == "2007-02-02")



#Open png graphics device and start plotting - modify mfrow to fit multiple plots in same file
png(filename = "plot4.png")
par(mfrow=c(2, 2))
#Plot 1
plot(plot_time$datetime, plot_time$glb_active_pow, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = 'Time')
#Plot 2
plot(plot_time$datetime, plot_time$voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
#Plot 3
plot(plot_time$datetime, plot_time$meter1, type = 'l', ylab = 'Energy Sub Metering', xlab = 'Time')
points(plot_time$datetime, plot_time$meter2, type = 'l', col = 'red')
points(plot_time$datetime, plot_time$meter3, type = 'l', col = 'blue')
legend("topright", lty = c(1, 1), col = c('black', 'red', 'blue'), legend = c('Meter 1', 'Meter 2', 'Meter 3'))
#Plot 4
plot(plot_time$datetime, plot_time$glb_reactive_pow, type = 'l', xlab = 'datetime', ylab = 'Global Reactive Power')
dev.off()