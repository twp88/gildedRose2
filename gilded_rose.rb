require './item'
require './aged_brie'
require './normal'
require './sulfuras'
require './backstage'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      reduce_sell_in(item)
      item.update
    end
  end

  private

  def reduce_sell_in(item)
    item.sell_in -= 1 if item.sell_in != 0
  end
end
