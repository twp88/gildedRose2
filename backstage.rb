class BackstagePasses < Item
  BACKSTAGE_QUALITY = [0, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2].freeze
  def update
    @sell_in >= 11 ? @quality += 1 : @quality += BACKSTAGE_QUALITY[@sell_in]
    @quality = 0 if @sell_in.zero?
  end
end
