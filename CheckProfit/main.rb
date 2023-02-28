require './PriceMonitor.rb'
require './Notification.rb'
require 'aws-sdk-cloudwatch'

def handler(event:, context:)
    topProfit = requestTopProfit()
    if (topProfit >= 50.0)
        sendNotification(topProfit)
    end
    reportMetric(topProfit)
    {
      statusCode: 200,
      body: {
        topProfit: topProfit,
      }
    }
end


def reportMetric(metric) 
  client = 	Aws::CloudWatch::Client.new
  client.put_metric_data({
    namespace: "SteamProfit",
    metric_data: [{
      metric_name: "Profit_by_percentages",
      dimensions: [
        {
          name: "Percent", # required
          value: "Time", # required
        },
      ],
      timestamp: Time.now,
      value: metric,
      unit: "Percent"
    }]
  })
end