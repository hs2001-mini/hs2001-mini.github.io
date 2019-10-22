require './method'

ifdoneOCO

puts get_my_money("BTC")["amount"]

while(1)
 current_price = get_price
 puts current_price
 
 buy_price = 800000
 sell_price = 900000
    if (current_price > sell_price) && (get_my_money("BTC")["amount"] > 0.001)
        puts "売ります"
        order("SELL",sell_price,0.001)
    elsif (current_price < buy_price) && (get_my_money("JPY")[amount] > 1000)
        puts "買います"
        order("BUY",buy_price,0.001)
    else
        puts "何もしません"
    end
    sleep(1)
end
