require 'telegram/bot'
require 'yaml'

config = YAML.load_file('config.yaml')
TOKEN = config["tg_token"]
CHAT_ID = config["chat_id"]

def sendNotification(topProfitResponse)
    message = "#{escapeNumber(topProfitResponse[:profitPercent])}% saving offer " + 
      "is available\\. [Buy now](#{topProfitResponse[:buyLink]}) " + 
      "for $#{escapeNumber(topProfitResponse[:price])}"
    Telegram::Bot::Client.run(TOKEN) do |bot|
        bot.api.send_message(
          chat_id: Integer(CHAT_ID),
          text: message,
          parse_mode: "MarkdownV2",
          disable_web_page_preview: true
        )
      end
end

def escapeNumber(number)
  number.to_s.sub(".", "\\.")
end



