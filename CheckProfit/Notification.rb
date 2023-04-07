require 'telegram/bot'
require 'yaml'

def sendNotification(topProfitResponse, tg_token, chat_id)
    message = "#{escapeNumber(topProfitResponse[:profitPercent])}% saving offer " + 
      "is available\\. [Buy now](#{topProfitResponse[:buyLink]}) " + 
      "for $#{escapeNumber(topProfitResponse[:price])}"
    Telegram::Bot::Client.run(tg_token) do |bot|
        bot.api.send_message(
          chat_id: Integer(chat_id),
          text: message,
          parse_mode: "MarkdownV2",
          disable_web_page_preview: true
        )
      end
end

def escapeNumber(number)
  number.to_s.sub(".", "\\.")
end



