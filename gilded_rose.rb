class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case(item.name)
      when 'Sulfuras, Hand of Ragnaros'
        wow = WoWItem.new(item.sell_in, item.quality)
        item.quality = wow.new_quality
        item.sell_in = wow.new_sell_in
      when 'Aged Brie'
        brie = AgedBrie.new(item.sell_in, item.quality)
        item.sell_in = brie.new_sell_in
        item.quality = brie.new_quality
      when 'Backstage passes to a TAFKAL80ETC concert'
        pass = BackstagePass.new(item.sell_in, item.quality)
        item.sell_in = pass.new_sell_in
        item.quality = pass.new_quality
      else
        norm = NormalItem.new(item.sell_in, item.quality)
        item.sell_in = norm.new_sell_in
        item.quality = norm.new_quality
      end
    end
  end
end

class WoWItem
  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def new_sell_in
    return @sell_in
  end

  def new_quality
    return @quality
  end
end

class NormalItem
  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def new_quality
    decrement_quality
    decrement_quality if @sell_in < 0
    return @quality
  end

  def new_sell_in
    @sell_in -= 1
    return @sell_in
  end

  private

  def decrement_quality
    @quality -= 1 unless @quality <= 0
  end
end

class BackstagePass
  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def new_quality
    return 0 if @sell_in < 0

    increment_quality
    if @sell_in < 10
      increment_quality
    end
    if @sell_in < 5
      increment_quality
    end
    return @quality
  end

  def new_sell_in
    @sell_in -= 1
    return @sell_in
  end

  private

  def increment_quality
    @quality += 1 unless max_quality?
  end

  def max_quality?
    @quality >= 50
  end
end

class AgedBrie
  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def new_quality
    increment_quality
    increment_quality if @sell_in < 0
    return @quality
  end

  def new_sell_in
    @sell_in -= 1
    return @sell_in
  end

  private

  def increment_quality
    @quality += 1 unless max_quality?
  end

  def max_quality?
    @quality >= 50
  end
end


# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

