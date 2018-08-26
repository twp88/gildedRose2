require './item'

class GildedRose
  BACKSTAGE_QUALITY = [0, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2].freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      reduce_sell_in(item)

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
    item.quality -= 1 if item.sell_in >= 1
    item.quality -= 2 if item.sell_in.zero? && item.quality != 0
  end

  def update_aged_brie(item)
    item.quality += 1
  end

  def update_sulfuras(item)end

  def update_backstage(item)
    item.sell_in >= 11 ? item.quality += 1 : item.quality += BACKSTAGE_QUALITY[item.sell_in]
    item.quality = 0 if item.sell_in.zero?
  end

  def reduce_sell_in(item)
    item.sell_in -= 1 if item.sell_in != 0
  end
end
