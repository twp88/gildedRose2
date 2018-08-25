require './item'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == 'Aged Brie'
        update_aged_brie(item)
      elsif item.name == 'Sulfuras, Hand of Ragnaros'
        update_sulfuras(item)
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage(item)
      else
        update_normal(item)
      end
    end
  end

  private

  def update_normal(item)
    item.sell_in -= 1 if item.sell_in != 0
    item.quality -= 1 if item.sell_in >= 1
    item.quality -= 2 if item.sell_in.zero? && item.quality != 0
  end

  def update_aged_brie(item)
    item.sell_in -= 1 if item.sell_in != 0
    item.quality += 1
  end

  def update_sulfuras(item)end

  def update_backstage(item)
    item.sell_in -= 1 if item.sell_in != 0
    item.quality += 1 if item.sell_in >= 11
    item.quality += 2 if item.sell_in <= 10 && item.sell_in >= 5
    item.quality += 3 if item.sell_in <= 4 && item.quality != 0
    item.quality = 0 if item.sell_in.zero?
  end
end
