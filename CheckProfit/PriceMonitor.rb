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

def requestTopProfit() 
    response = HTTP.post(URL, json: PARAMS).parse

    if (!response || !response["success"])
        return nil
    end
    topItem = response["items"][0]
    topProfit  = topItem["profitPercent"]
    return topProfit
end
