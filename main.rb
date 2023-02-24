require './PriceMonitor.rb'
require './Notification.rb'

topProfit = requestTopProfit()

if (topProfit >= 50.0)
    sendNotification(topProfit)
end
