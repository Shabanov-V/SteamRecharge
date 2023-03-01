require './PriceMonitor.rb'
require './Notification.rb'
require 'aws-sdk-cloudwatch'

def handler(event:, context:)
    topProfitResponse = requestTopProfit()
    topProfit = topProfitResponse[:profitPercent]
    if (topProfit >= 50.0)
        sendNotification(topProfitResponse)
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
          name: "Percent",
          value: "Time",
        },
      ],
      timestamp: Time.now,
      value: metric,
      unit: "Percent"
    }]
  })
end