require "http"

URL = "https://prices.sih.app/comparisons?page=1"
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

def requestTopProfit() 
    response = HTTP.post(URL, json: PARAMS).parse

    if (!response || !response["success"])
        return nil
    end
    topItem = response["items"][0]
    topItemMarket = topItem["markets"][0]
    topProfit  = topItem["profitPercent"]
    result = {
        profitPercent: topProfit, 
        buyLink: BUY_URL_TEMPLATE % {
            itemName: CGI.escape(topItem["item"]),
            marketplace: CGI.escape(topItemMarket["market"])
        },
        price: topItemMarket["price"]
    }
    return result
end
