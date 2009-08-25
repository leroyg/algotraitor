require File.dirname(__FILE__) + '/helper'

class StockTest < Test::Unit::TestCase
  setup do
    @stock = Algotraitor::Stock.new("XYZ", 1.00)
  end
  
  test "initializer takes stock and initial price as arguments" do
    stock = Algotraitor::Stock.new("ABC", 15.00)
    assert_equal "ABC", stock.symbol
    assert_equal 15.00, stock.price
  end

  test "notifies subscribers when price changes" do
    watcher = mock
    watcher.expects(:update).with do |stock, time, old_price, new_price|
      stock.symbol == 'XYZ' &&
        new_price = old_price + 1.0
    end

    @stock.add_observer(watcher)
    @stock.price += 1.0
    @stock.delete_observer(watcher)
  end

end
