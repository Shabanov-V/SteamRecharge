require './PriceMonitor.rb'
require './Notification.rb'

topProfit = requestTopProfit()

if (topProfit >= 5.0)
    sendNotification(topProfit)
end
