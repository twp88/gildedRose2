require './item'

class GildedRose
  BACKSTAGE_QUALITY = [0, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2].freeze
  PRODUCT_NAMES = [
    'Aged Brie',
    'Sulfuras, Hand of Ragnaros',
    'Backstage passes to a TAFKAL80ETC concert'
  ].freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      reduce_sell_in(item)
      update_normal(item) unless PRODUCT_NAMES.include?(item.name)
      update_non_normal(item)
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

  def update_sulfuras(item)
    item.quality = 80
  end

  def update_backstage(item)
    item.sell_in >= 11 ?
      item.quality += 1 : item.quality += BACKSTAGE_QUALITY[item.sell_in]
    item.quality = 0 if item.sell_in.zero?
  end

  def reduce_sell_in(item)
    item.sell_in -= 1 if item.sell_in != 0
  end

  def update_non_normal(item)
    update_aged_brie(item) if item.name == PRODUCT_NAMES[0]
    update_sulfuras(item) if item.name == PRODUCT_NAMES[1]
    update_backstage(item) if item.name == PRODUCT_NAMES[2]
  end
end
