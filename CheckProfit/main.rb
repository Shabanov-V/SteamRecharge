require './PriceMonitor.rb'
require './Notification.rb'


def handler(event:, context:)
  
    topProfit = requestTopProfit()
    if (topProfit >= 50.0)
        sendNotification(topProfit)
    end

    {
      statusCode: 200,
      body: {
        topProfit: topProfit,
      }
    }
end
