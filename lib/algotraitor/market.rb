module Algotraitor

  # A Market represents the current state of a market: a basket of Stocks and
  # their associated information.
  class Market
    include Roxy::Moxie

    def initialize
      @stocks = {}
      @participants = {}
    end

    attr_reader :stocks, :participants

    def add_stock(stock)
      @stocks[stock.symbol] = stock
    end

    # Enable market.stocks << stock to index stock by symbol
    proxy :stocks do
      def <<(stock)
        proxy_owner.add_stock(stock)
      end
    end

    def add_participant(participant)
      @participants[participant.id] = participant
    end

    proxy :participants do
      def <<(participant)
        proxy_owner.add_participant(participant)
      end
    end

    # Returns a hash mapping stock symbols to current prices.
    def stock_prices
      @stocks.inject({}) do |hash, (symbol, stock)|
        hash[symbol] = stock.price
        hash
      end
    end



  end

end
