require 'net/http'
require 'cgi'
require 'json'

URL = "http://api.sih.app/comparisons?page=1"
PARAMS = {
    locked: false,
    marketsCountMin: "",
    marketsMax: ["steam_buyorder"],
    marketsMin: ["skinport", "gamerpay"],
    maxMarketPrice: "",
    maxPrice: "",
    minMarketPrice: "",
    minPrice: "5",
    priceGreaterThanSteam: false,
    profitSort: "percentDESC",
    weekSellsMin: "5"
}

BUY_URL_TEMPLATE = "https://t.sih-db.com/15GGBe?subid1=/buy?query=%{itemName}&subid2=%{marketplace}"

def requestTopProfit(amount)
    response = performRequest()

    if (!response || !response["success"])
        return nil
    end
    result = []
    amount.times do |i|
        item = response["items"][i]
        itemMarket = item["markets"][0]
        result += [{
            item: item["item"],
            profitPercent: item["profitPercent"],
            buyLink: BUY_URL_TEMPLATE % {
                itemName: CGI.escape(item["item"]),
                marketplace: CGI.escape(itemMarket["market"])
            },
            price: itemMarket["price"]
        }]
    end
    return result
end

def performRequest()
    uri = URI.parse("http://api.sih.app/comparisons?page=1")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Host"] = "api.sih.app"
    request.body = JSON.dump(PARAMS)
    req_options = {
        use_ssl: uri.scheme == "https",
      }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
    return JSON.parse(response.body)
end
