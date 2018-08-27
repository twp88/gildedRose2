class Normal < Item
  def update
    @quality -= 1 if @sell_in >= 1
    @quality -= 2 if @sell_in.zero? && @quality != 0
  end
end
