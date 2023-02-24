require 'telegram/bot'
require 'yaml'

config = YAML.load_file('config.yaml')
TOKEN = config["tg_token"]
CHAT_ID = config["chat_id"]

def sendNotification(topProfit)
    message = "#{topProfit}% saving offer is available"
    Telegram::Bot::Client.run(TOKEN) do |bot|
        bot.api.send_message(
          chat_id: Integer(CHAT_ID),
          text: message
        )
      end
end




