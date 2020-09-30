#Takes in an array of stock prices, one per weekday. Returns a pair of days representing the best day to buy and sell the stock for maximum profit


def stock_picker(prices)
  buy_sell_days = []
  max_earnings = 0

  prices.each_with_index do |buy_price, buy_index|
    prices.each_with_index do |sell_price, sell_index|

      if (sell_price - buy_price > max_earnings) && sell_index > buy_index
        buy_sell_days = [buy_index, sell_index]
        max_earnings = sell_price - buy_price
      end
      
    end
  end

  buy_sell_days
end

p stock_picker([17,3,6,9,15,8,6,1,10])
# #[1,4]  # for a profit of $15 - $3 == $12
